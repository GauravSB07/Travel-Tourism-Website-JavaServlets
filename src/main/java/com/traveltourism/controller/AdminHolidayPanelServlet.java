package com.traveltourism.controller;

import com.traveltourism.model.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.*;
import java.util.*;

/** Administration uses the same holiday tables as the public catalogue. */
@WebServlet("/admin/holidays")
public class AdminHolidayPanelServlet extends HttpServlet {
    private static final String[] FIELDS = {"name", "occasion", "departure_city", "duration", "price",
        "description", "inclusions", "exclusions", "source_url", "active"};

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        render(req, res);
    }

    private void render(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (session.getAttribute("holidayCsrf") == null)
            session.setAttribute("holidayCsrf", UUID.randomUUID().toString());
        try (Connection con = DBConnection.getConnection()) {
            List<Map<String, Object>> packages = new ArrayList<>();
            try (PreparedStatement ps = con.prepareStatement("SELECT * FROM holiday_packages ORDER BY name, id");
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> row = new LinkedHashMap<>();
                    row.put("id", rs.getString("id"));
                    for (String field : FIELDS) row.put(field, rs.getString(field));
                    packages.add(row);
                }
            }
            req.setAttribute("packages", packages);
            if (req.getAttribute("editor") == null) {
                String id = req.getParameter("id");
                Map<String, Object> editor = packages.stream()
                    .filter(p -> Objects.equals(p.get("id"), id)).findFirst().orElse(null);
                if (id != null && editor == null) {
                    res.sendError(404, "Holiday package not found."); return;
                }
                req.setAttribute("editor", editor);
                req.setAttribute("editing", editor != null);
                List<String> days = new ArrayList<>();
                if (editor != null) {
                    try (PreparedStatement ps = con.prepareStatement(
                            "SELECT day_number, description FROM holiday_itinerary WHERE holiday_id=? ORDER BY day_number")) {
                        ps.setString(1, id);
                        try (ResultSet rs = ps.executeQuery()) {
                            while (rs.next()) {
                                int day = rs.getInt(1);
                                while (days.size() < day) days.add("");
                                days.set(day - 1, rs.getString(2));
                            }
                        }
                    }
                }
                req.setAttribute("days", days);
            }
            Map<?,?> currentEditor = (Map<?,?>) req.getAttribute("editor");
            req.setAttribute("gallery", currentEditor == null ? List.of() : com.traveltourism.model.HolidayGallery.load(String.valueOf(currentEditor.get("id"))));
            req.setAttribute("notice", session.getAttribute("holidayNotice"));
            session.removeAttribute("holidayNotice");
            req.getRequestDispatcher("/WEB-INF/admin/holidays.jsp").forward(req, res);
        } catch (SQLException e) {
            throw new ServletException("Unable to load holiday administration.", e);
        }
    }

    @Override protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession(false);
        if (session == null || !Objects.equals(session.getAttribute("holidayCsrf"), req.getParameter("csrf"))
                || req.getParameter("csrf") == null) {
            res.sendError(403, "Please reload the editor and try again."); return;
        }
        Map<String, Object> editor = new LinkedHashMap<>();
        editor.put("id", value(req, "id"));
        for (String field : FIELDS) editor.put(field, value(req, field));
        editor.put("active", "1".equals(req.getParameter("active")) ? "1" : "0");
        String[] submitted = req.getParameterValues("day");
        List<String> days = submitted == null ? new ArrayList<>() : new ArrayList<>(Arrays.asList(submitted));
        boolean creating = "create".equals(req.getParameter("action"));
        req.setAttribute("editor", editor);
        req.setAttribute("editing", !creating);
        req.setAttribute("days", days);
        try {
            if (!creating && !"save".equals(req.getParameter("action")))
                throw new IllegalArgumentException("Unknown action. Reload the editor.");
            validate(editor, days);
            save(editor, days, creating);
            session.setAttribute("holidayNotice", creating ? "Holiday package created." : "Holiday package saved.");
            res.sendRedirect(req.getContextPath() + "/admin/holidays?id="
                + URLEncoder.encode((String) editor.get("id"), StandardCharsets.UTF_8));
        } catch (IllegalArgumentException e) {
            res.setStatus(400);
            req.setAttribute("error", e.getMessage());
            render(req, res);
        } catch (SQLException e) {
            log("Unable to save holiday package", e);
            res.setStatus(500);
            req.setAttribute("error", "The package could not be saved. Your entries are still below. Check that the package ID is unique and try again.");
            render(req, res);
        }
    }

    static void validate(Map<String, Object> editor, List<String> days) {
        String id = (String) editor.get("id");
        if (id == null || !id.matches("[A-Za-z0-9_-]{1,80}"))
            throw new IllegalArgumentException("Use 1–80 letters, numbers, hyphens or underscores for the package ID.");
        String[] textFields = {"name", "occasion", "departure_city", "description", "inclusions", "exclusions"};
        int[] limits = {180, 80, 120, 15000, 15000, 15000};
        for (int i = 0; i < textFields.length; i++) {
            String text = (String) editor.get(textFields[i]);
            if (text == null || text.isBlank() || text.length() > limits[i])
                throw new IllegalArgumentException(textFields[i].replace('_', ' ') + " is required (maximum " + limits[i] + " characters).");
        }
        int duration = integer(editor, "duration", 1, 60);
        integer(editor, "price", 0, Integer.MAX_VALUE);
        String url = (String) editor.get("source_url");
        if (url != null && !url.isBlank()) {
            try {
                java.net.URI uri = java.net.URI.create(url);
                if (url.length() > 500 || uri.getHost() == null
                        || !Set.of("http", "https").contains(uri.getScheme().toLowerCase(Locale.ROOT)))
                    throw new IllegalArgumentException();
            } catch (RuntimeException e) {
                throw new IllegalArgumentException("Reference URL must be a valid http or https address, up to 500 characters.");
            }
        }
        // A saved itinerary always has exactly one non-empty entry per travel day.
        if (days.size() != duration)
            throw new IllegalArgumentException("Add exactly " + duration + " itinerary days to match the duration.");
        for (int i = 0; i < days.size(); i++) {
            String day = days.get(i).trim();
            if (day.isEmpty() || day.length() > 15000)
                throw new IllegalArgumentException("Day " + (i + 1) + " needs a description of up to 15000 characters.");
            days.set(i, day);
        }
    }

    private static int integer(Map<String, Object> editor, String field, int min, int max) {
        try {
            int n = Integer.parseInt((String) editor.get(field));
            if (n < min || n > max) throw new NumberFormatException();
            return n;
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException(field + " must be a whole number between " + min + " and " + max + ".");
        }
    }

    private static String value(HttpServletRequest req, String name) {
        return Optional.ofNullable(req.getParameter(name)).orElse("").trim();
    }

    private void save(Map<String, Object> editor, List<String> days, boolean creating) throws SQLException {
        try (Connection con = DBConnection.getConnection()) {
            save(con, editor, days, creating);
        }
    }

    static void save(Connection con, Map<String, Object> editor, List<String> days, boolean creating) throws SQLException {
        boolean autoCommit = con.getAutoCommit();
        try {
            con.setAutoCommit(false);
            try {
                // Serialize concurrent itinerary replacements for an existing package.
                if (!creating) {
                    try (PreparedStatement ps = con.prepareStatement("SELECT id FROM holiday_packages WHERE id=? FOR UPDATE")) {
                        ps.setString(1, (String) editor.get("id"));
                        try (ResultSet rs = ps.executeQuery()) {
                            if (!rs.next()) throw new IllegalArgumentException("This package no longer exists. Reload the catalogue.");
                        }
                    }
                }
                String sql = creating
                    ? "INSERT INTO holiday_packages (name,occasion,departure_city,duration,price,description,inclusions,exclusions,source_url,active,id) VALUES (?,?,?,?,?,?,?,?,?,?,?)"
                    : "UPDATE holiday_packages SET name=?,occasion=?,departure_city=?,duration=?,price=?,description=?,inclusions=?,exclusions=?,source_url=?,active=? WHERE id=?";
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    for (int i = 0; i < FIELDS.length; i++) {
                        String field = FIELDS[i];
                        if ("duration".equals(field) || "price".equals(field))
                            ps.setInt(i + 1, Integer.parseInt((String) editor.get(field)));
                        else if ("active".equals(field)) ps.setBoolean(i + 1, "1".equals(editor.get(field)));
                        else ps.setString(i + 1, (String) editor.get(field));
                    }
                    ps.setString(11, (String) editor.get("id"));
                    ps.executeUpdate();
                }
                try (PreparedStatement ps = con.prepareStatement("DELETE FROM holiday_itinerary WHERE holiday_id=?")) {
                    ps.setString(1, (String) editor.get("id")); ps.executeUpdate();
                }
                try (PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO holiday_itinerary (holiday_id,day_number,description) VALUES (?,?,?)")) {
                    for (int i = 0; i < days.size(); i++) {
                        ps.setString(1, (String) editor.get("id")); ps.setInt(2, i + 1);
                        ps.setString(3, days.get(i)); ps.addBatch();
                    }
                    ps.executeBatch();
                }
                con.commit();
            } catch (SQLException | RuntimeException e) {
                con.rollback(); throw e;
            }
        } finally {
            con.setAutoCommit(autoCommit);
        }
    }
}
