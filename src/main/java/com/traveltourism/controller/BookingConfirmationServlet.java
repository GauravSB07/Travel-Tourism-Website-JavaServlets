package com.traveltourism.controller;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.UUID;
import com.traveltourism.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/booking-confirmation")
public class BookingConfirmationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("bookingReceipt") == null) {
            response.sendRedirect(request.getContextPath() + "/destinations");
            return;
        }
        response.setHeader("Cache-Control", "no-store");
        request.setAttribute("receipt", session.getAttribute("bookingReceipt"));
        request.getRequestDispatcher("/booking_confirmation.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        if (session == null || request.getParameter("bookingToken") == null
                || !request.getParameter("bookingToken").equals(session.getAttribute("bookingToken"))) {
            response.sendError(403, "Your booking form has expired. Please select your package again.");
            return;
        }
        Map<String, Object> selected = null;
        try {
            selected = BookingSelection.load(request.getParameter("holiday_id"), request.getParameter("tour_id"));
            String name = required(request, "customerName", 120);
            String email = required(request, "email", 254);
            String phone = required(request, "phone", 30);
            if (!email.matches("[^\\s@]+@[^\\s@]+\\.[^\\s@]+")) throw new IllegalArgumentException("Enter a valid email address.");
            if (!phone.matches("[+0-9() .-]{7,30}")) throw new IllegalArgumentException("Enter a valid phone number.");
            int travelers;
            LocalDate date;
            try {
                travelers = Integer.parseInt(request.getParameter("travelers"));
                date = LocalDate.parse(request.getParameter("travelDate"));
            } catch (Exception ex) { throw new IllegalArgumentException("Enter a valid travel date and traveller count."); }
            if (travelers < 1 || travelers > 30) throw new IllegalArgumentException("Choose between 1 and 30 travellers.");
            if (date.isBefore(HolidayDataAccess.today())) throw new IllegalArgumentException("Travel date cannot be in the past.");
            String preferences = request.getParameter("preferences");
            if (preferences == null) preferences = "";
            if (preferences.length() > 2000) throw new IllegalArgumentException("Keep your preferences within 2,000 characters.");
            long total = ((Number) selected.get("price")).longValue() * travelers;
            String reference = UUID.randomUUID().toString();
            // A unique form token also prevents duplicate requests from a double click.
            String sql = "INSERT INTO booking_requests (reference, request_token, package_type, package_id, package_name, departure_city, duration, price_per_person, customer_name, email, phone, travelers, travel_date, preferences, total_price) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            try (Connection con = DBConnection.getConnection()) {
                if (con == null) throw new SQLException("Database connection unavailable");
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setString(1, reference); ps.setString(2, request.getParameter("bookingToken"));
                    ps.setString(3, (String) selected.get("type")); ps.setString(4, (String) selected.get("id"));
                    ps.setString(5, (String) selected.get("name")); ps.setString(6, (String) selected.get("departure"));
                    ps.setInt(7, (Integer) selected.get("duration")); ps.setInt(8, (Integer) selected.get("price"));
                    ps.setString(9, name); ps.setString(10, email); ps.setString(11, phone);
                    ps.setInt(12, travelers); ps.setDate(13, java.sql.Date.valueOf(date));
                    ps.setString(14, preferences); ps.setLong(15, total);
                    ps.executeUpdate();
                }
            }
            Map<String, Object> receipt = new LinkedHashMap<>(selected);
            receipt.put("reference", reference); receipt.put("customerName", name); receipt.put("email", email);
            receipt.put("phone", phone); receipt.put("travelers", travelers); receipt.put("date", date.toString());
            receipt.put("preferences", preferences); receipt.put("total", total);
            session.setAttribute("bookingReceipt", receipt);
            session.setAttribute("bookingToken", UUID.randomUUID().toString());
            response.sendRedirect(request.getContextPath() + "/booking-confirmation");
        } catch (IllegalArgumentException ex) {
            if (selected == null) { response.sendError(400, ex.getMessage()); return; }
            showError(request, response, selected, 400, ex.getMessage());
        } catch (SQLException ex) {
            log("Unable to save booking request", ex);
            if (selected == null) { response.sendError(503, "Bookings are temporarily unavailable."); return; }
            showError(request, response, selected, 503, "We could not save this request. Please try again shortly. If you already submitted it, check your booking confirmation before retrying.");
        }
    }

    private String required(HttpServletRequest request, String field, int max) {
        String value = request.getParameter(field);
        if (value == null || value.isBlank() || value.trim().length() > max)
            throw new IllegalArgumentException("Please complete your contact details within the allowed lengths.");
        return value.trim();
    }

    private void showError(HttpServletRequest request, HttpServletResponse response,
            Map<String, Object> selected, int status, String error) throws ServletException, IOException {
        response.setStatus(status);
        request.setAttribute("selection", selected);
        request.setAttribute("today", HolidayDataAccess.today());
        request.setAttribute("error", error);
        request.getRequestDispatcher("/booking.jsp").forward(request, response);
    }
}
