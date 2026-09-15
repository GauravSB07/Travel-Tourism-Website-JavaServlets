package com.traveltourism.controller;

import com.traveltourism.model.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

@WebServlet("/user-dashboard")
public class UserDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null
                || !Boolean.TRUE.equals(session.getAttribute("userLoggedIn"))) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?redirect=/user-dashboard"
            );
            return;
        }

        long userId;

        try {
            userId = Long.parseLong(
                    String.valueOf(session.getAttribute("userId"))
            );
        } catch (Exception ex) {

            session.invalidate();

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?redirect=/user-dashboard"
            );
            return;
        }

        Map<String, Object> profile = new LinkedHashMap<>();
        Map<String, Integer> bookingStats = new LinkedHashMap<>();

        int savedToursCount = 0;

        String loadError = null;

        try (Connection connection = DBConnection.getConnection()) {

            if (connection == null) {
                throw new SQLException("Database connection unavailable");
            }

            /* ================= PROFILE ================= */

            profile = loadProfile(connection, userId);

            if (profile.isEmpty()) {

                session.invalidate();

                response.sendRedirect(
                        request.getContextPath()
                        + "/login.jsp?redirect=/user-dashboard"
                );

                return;
            }

            /* ================= BOOKING COUNTS ================= */

            bookingStats.put(
                    "total",
                    count(
                            connection,
                            "SELECT COUNT(*) "
                            + "FROM booking_requests "
                            + "WHERE user_id=? AND archived=FALSE",
                            userId
                    )
            );

            bookingStats.put(
                    "active",
                    count(
                            connection,
                            "SELECT COUNT(*) "
                            + "FROM booking_requests "
                            + "WHERE user_id=? "
                            + "AND archived=FALSE "
                            + "AND status IN ('pending','reviewing','confirmed')",
                            userId
                    )
            );

            bookingStats.put(
                    "confirmed",
                    count(
                            connection,
                            "SELECT COUNT(*) "
                            + "FROM booking_requests "
                            + "WHERE user_id=? "
                            + "AND archived=FALSE "
                            + "AND status='confirmed'",
                            userId
                    )
            );

            /* ================= SAVED TOURS COUNT ================= */

            savedToursCount = count(
                    connection,
                    "SELECT COUNT(*) "
                    + "FROM saved_tours "
                    + "WHERE user_id=?",
                    userId
            );

        } catch (Exception ex) {

            log("User dashboard could not be loaded", ex);

            loadError =
                    "Some account information could not be loaded right now. "
                    + "Please try again shortly.";
        }

        /* ================= SEND DATA TO JSP ================= */

        request.setAttribute("profile", profile);

        request.setAttribute("bookingStats", bookingStats);

        request.setAttribute("savedToursCount", savedToursCount);

        request.setAttribute("loadError", loadError);

        request.getRequestDispatcher(
                "/WEB-INF/user/dashboard.jsp"
        ).forward(request, response);
    }


    /* =========================================================
       LOAD USER PROFILE
       ========================================================= */

    private Map<String, Object> loadProfile(
            Connection connection,
            long userId) throws SQLException {

        Map<String, Object> profile = new LinkedHashMap<>();

        String sql =
                "SELECT user_id, full_name, email, phone, created_at "
                + "FROM users "
                + "WHERE user_id=?";

        try (PreparedStatement statement =
                connection.prepareStatement(sql)) {

            statement.setLong(1, userId);

            try (ResultSet result = statement.executeQuery()) {

                if (result.next()) {

                    profile.put(
                            "user_id",
                            result.getLong("user_id")
                    );

                    profile.put(
                            "full_name",
                            result.getString("full_name")
                    );

                    profile.put(
                            "email",
                            result.getString("email")
                    );

                    profile.put(
                            "phone",
                            result.getString("phone")
                    );

                    profile.put(
                            "created_at",
                            result.getTimestamp("created_at")
                    );
                }
            }
        }

        return profile;
    }


    /* =========================================================
       GENERIC COUNT METHOD
       ========================================================= */

    private int count(
            Connection connection,
            String sql,
            long userId) throws SQLException {

        try (PreparedStatement statement =
                connection.prepareStatement(sql)) {

            statement.setLong(1, userId);

            try (ResultSet result = statement.executeQuery()) {

                return result.next()
                        ? result.getInt(1)
                        : 0;
            }
        }
    }
}