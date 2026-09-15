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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/user-bookings")
public class UserBookingsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // User must be logged in
        if (session == null ||
            !Boolean.TRUE.equals(session.getAttribute("userLoggedIn"))) {

            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
            return;
        }

        Object userIdObject = session.getAttribute("userId");

        if (userIdObject == null) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
            return;
        }

        long userId;

        try {
            userId = Long.parseLong(userIdObject.toString());
        } catch (NumberFormatException e) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
            return;
        }

        /*
         * Optional status filter.
         *
         * Dashboard links:
         * /user-bookings
         * /user-bookings?status=active
         * /user-bookings?status=confirmed
         */
        String statusFilter = request.getParameter("status");

        List<BookingSummary> bookings = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
            "SELECT " +
            "reference, " +
            "package_type, " +
            "package_id, " +
            "package_name, " +
            "departure_city, " +
            "duration, " +
            "price_per_person, " +
            "travelers, " +
            "travel_date, " +
            "total_price, " +
            "status, " +
            "created_at, " +
            "updated_at " +
            "FROM booking_requests " +
            "WHERE user_id = ? " +
            "AND archived = 0 "
        );

        /*
         * "active" means bookings that are currently in
         * pending, reviewing or confirmed state.
         */
        if ("active".equalsIgnoreCase(statusFilter)) {

            sql.append(
                "AND status IN ('pending', 'reviewing', 'confirmed') "
            );

        } else if ("confirmed".equalsIgnoreCase(statusFilter)) {

            sql.append(
                "AND status = 'confirmed' "
            );
        }

        sql.append("ORDER BY created_at DESC");

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql.toString())) {

            ps.setLong(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    BookingSummary booking = new BookingSummary();

                    booking.setReference(
                        rs.getString("reference")
                    );

                    booking.setPackageType(
                        rs.getString("package_type")
                    );

                    booking.setPackageId(
                        rs.getString("package_id")
                    );

                    booking.setPackageName(
                        rs.getString("package_name")
                    );

                    booking.setDepartureCity(
                        rs.getString("departure_city")
                    );

                    booking.setDuration(
                        rs.getInt("duration")
                    );

                    booking.setPricePerPerson(
                        rs.getInt("price_per_person")
                    );

                    booking.setTravelers(
                        rs.getInt("travelers")
                    );

                    booking.setTravelDate(
                        rs.getDate("travel_date")
                    );

                    booking.setTotalPrice(
                        rs.getLong("total_price")
                    );

                    booking.setStatus(
                        rs.getString("status")
                    );

                    booking.setCreatedAt(
                        rs.getTimestamp("created_at")
                    );

                    booking.setUpdatedAt(
                        rs.getTimestamp("updated_at")
                    );

                    bookings.add(booking);
                }
            }

        } catch (SQLException e) {

            e.printStackTrace();

            request.setAttribute(
                "loadError",
                "Unable to load your bookings right now. Please try again later."
            );
        }

        request.setAttribute("bookings", bookings);
        request.setAttribute("statusFilter", statusFilter);

        request.getRequestDispatcher(
            "/WEB-INF/user/user-bookings.jsp"
        ).forward(request, response);
    }


    // =========================================================
    // BOOKING SUMMARY MODEL
    // =========================================================

    public static class BookingSummary {

        private String reference;
        private String packageType;
        private String packageId;
        private String packageName;
        private String departureCity;
        private int duration;
        private int pricePerPerson;
        private int travelers;
        private java.sql.Date travelDate;
        private long totalPrice;
        private String status;
        private java.sql.Timestamp createdAt;
        private java.sql.Timestamp updatedAt;


        public String getReference() {
            return reference;
        }

        public void setReference(String reference) {
            this.reference = reference;
        }


        public String getPackageType() {
            return packageType;
        }

        public void setPackageType(String packageType) {
            this.packageType = packageType;
        }


        public String getPackageId() {
            return packageId;
        }

        public void setPackageId(String packageId) {
            this.packageId = packageId;
        }


        public String getPackageName() {
            return packageName;
        }

        public void setPackageName(String packageName) {
            this.packageName = packageName;
        }


        public String getDepartureCity() {
            return departureCity;
        }

        public void setDepartureCity(String departureCity) {
            this.departureCity = departureCity;
        }


        public int getDuration() {
            return duration;
        }

        public void setDuration(int duration) {
            this.duration = duration;
        }


        public int getPricePerPerson() {
            return pricePerPerson;
        }

        public void setPricePerPerson(int pricePerPerson) {
            this.pricePerPerson = pricePerPerson;
        }


        public int getTravelers() {
            return travelers;
        }

        public void setTravelers(int travelers) {
            this.travelers = travelers;
        }


        public java.sql.Date getTravelDate() {
            return travelDate;
        }

        public void setTravelDate(java.sql.Date travelDate) {
            this.travelDate = travelDate;
        }


        public long getTotalPrice() {
            return totalPrice;
        }

        public void setTotalPrice(long totalPrice) {
            this.totalPrice = totalPrice;
        }


        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
        }


        public java.sql.Timestamp getCreatedAt() {
            return createdAt;
        }

        public void setCreatedAt(java.sql.Timestamp createdAt) {
            this.createdAt = createdAt;
        }


        public java.sql.Timestamp getUpdatedAt() {
            return updatedAt;
        }

        public void setUpdatedAt(java.sql.Timestamp updatedAt) {
            this.updatedAt = updatedAt;
        }
    }
}