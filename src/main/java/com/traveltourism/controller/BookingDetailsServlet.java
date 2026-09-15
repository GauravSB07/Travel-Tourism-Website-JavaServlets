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

@WebServlet("/booking-details")
public class BookingDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        /* =====================================================
           CHECK LOGIN
           ===================================================== */

        HttpSession session = request.getSession(false);

        if (session == null
                || !Boolean.TRUE.equals(
                        session.getAttribute("userLoggedIn"))) {

            String reference = request.getParameter("reference");

            String redirect =
                    "/booking-details";

            if (reference != null && !reference.isBlank()) {
                redirect += "?reference=" + reference;
            }

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?redirect="
                    + java.net.URLEncoder.encode(
                            redirect,
                            java.nio.charset.StandardCharsets.UTF_8
                    )
            );

            return;
        }

        /* =====================================================
           GET USER ID
           ===================================================== */

        Object userIdObject =
                session.getAttribute("userId");

        if (userIdObject == null) {

            session.invalidate();

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp"
            );

            return;
        }

        long userId;

        try {

            userId =
                    Long.parseLong(
                            userIdObject.toString()
                    );

        } catch (NumberFormatException ex) {

            session.invalidate();

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp"
            );

            return;
        }

        /* =====================================================
           GET BOOKING REFERENCE
           ===================================================== */

        String reference =
                request.getParameter("reference");

        if (reference == null
                || reference.isBlank()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Booking reference is required."
            );

            return;
        }

        /* =====================================================
           LOAD BOOKING
           ===================================================== */

        BookingDetails booking = null;

        String sql = """
                SELECT
                    reference,
                    request_token,
                    package_type,
                    package_id,
                    package_name,
                    departure_city,
                    duration,
                    price_per_person,
                    customer_name,
                    email,
                    phone,
                    travelers,
                    travel_date,
                    preferences,
                    contact_preference,
                    pickup_location,
                    total_price,
                    status,
                    admin_notes,
                    follow_up_date,
                    created_at,
                    updated_at
                FROM booking_requests
                WHERE reference = ?
                  AND user_id = ?
                  AND archived = 0
                LIMIT 1
                """;

        try (Connection con =
                     DBConnection.getConnection()) {

            if (con == null) {

                throw new SQLException(
                        "Database connection unavailable"
                );
            }

            try (PreparedStatement ps =
                         con.prepareStatement(sql)) {

                ps.setString(1, reference);
                ps.setLong(2, userId);

                try (ResultSet rs =
                             ps.executeQuery()) {

                    if (rs.next()) {

                        booking =
                                new BookingDetails();

                        booking.reference =
                                rs.getString("reference");

                        booking.requestToken =
                                rs.getString("request_token");

                        booking.packageType =
                                rs.getString("package_type");

                        booking.packageId =
                                rs.getString("package_id");

                        booking.packageName =
                                rs.getString("package_name");

                        booking.departureCity =
                                rs.getString("departure_city");

                        booking.duration =
                                rs.getInt("duration");

                        booking.pricePerPerson =
                                rs.getInt("price_per_person");

                        booking.customerName =
                                rs.getString("customer_name");

                        booking.email =
                                rs.getString("email");

                        booking.phone =
                                rs.getString("phone");

                        booking.travelers =
                                rs.getInt("travelers");

                        booking.travelDate =
                                rs.getDate("travel_date");

                        booking.preferences =
                                rs.getString("preferences");

                        booking.contactPreference =
                                rs.getString(
                                        "contact_preference"
                                );

                        booking.pickupLocation =
                                rs.getString(
                                        "pickup_location"
                                );

                        booking.totalPrice =
                                rs.getLong("total_price");

                        booking.status =
                                rs.getString("status");

                        booking.adminNotes =
                                rs.getString("admin_notes");

                        booking.followUpDate =
                                rs.getDate("follow_up_date");

                        booking.createdAt =
                                rs.getTimestamp("created_at");

                        booking.updatedAt =
                                rs.getTimestamp("updated_at");
                    }
                }
            }

        } catch (SQLException ex) {

            log(
                    "Unable to load booking details",
                    ex
            );

            request.setAttribute(
                    "bookingError",
                    "We could not load this booking right now. Please try again shortly."
            );
        }

        /* =====================================================
           BOOKING NOT FOUND
           ===================================================== */

        if (booking == null
                && request.getAttribute(
                        "bookingError"
                ) == null) {

            request.setAttribute(
                    "bookingError",
                    "Booking not found or you do not have permission to view it."
            );
        }

        /* =====================================================
           SEND TO JSP
           ===================================================== */

        request.setAttribute(
                "booking",
                booking
        );

        request.getRequestDispatcher(
                "/WEB-INF/user/booking-details.jsp"
        ).forward(
                request,
                response
        );
    }

    /* =========================================================
       BOOKING DETAILS MODEL
       ========================================================= */

    public static class BookingDetails {

        private String reference;
        private String requestToken;

        private String packageType;
        private String packageId;
        private String packageName;

        private String departureCity;

        private int duration;
        private int pricePerPerson;

        private String customerName;
        private String email;
        private String phone;

        private int travelers;

        private java.sql.Date travelDate;

        private String preferences;
        private String contactPreference;
        private String pickupLocation;

        private long totalPrice;

        private String status;

        private String adminNotes;

        private java.sql.Date followUpDate;

        private java.sql.Timestamp createdAt;
        private java.sql.Timestamp updatedAt;

        public String getReference() {
            return reference;
        }

        public String getRequestToken() {
            return requestToken;
        }

        public String getPackageType() {
            return packageType;
        }

        public String getPackageId() {
            return packageId;
        }

        public String getPackageName() {
            return packageName;
        }

        public String getDepartureCity() {
            return departureCity;
        }

        public int getDuration() {
            return duration;
        }

        public int getPricePerPerson() {
            return pricePerPerson;
        }

        public String getCustomerName() {
            return customerName;
        }

        public String getEmail() {
            return email;
        }

        public String getPhone() {
            return phone;
        }

        public int getTravelers() {
            return travelers;
        }

        public java.sql.Date getTravelDate() {
            return travelDate;
        }

        public String getPreferences() {
            return preferences;
        }

        public String getContactPreference() {
            return contactPreference;
        }

        public String getPickupLocation() {
            return pickupLocation;
        }

        public long getTotalPrice() {
            return totalPrice;
        }

        public String getStatus() {
            return status;
        }

        public String getAdminNotes() {
            return adminNotes;
        }

        public java.sql.Date getFollowUpDate() {
            return followUpDate;
        }

        public java.sql.Timestamp getCreatedAt() {
            return createdAt;
        }

        public java.sql.Timestamp getUpdatedAt() {
            return updatedAt;
        }
    }
}