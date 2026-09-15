package com.traveltourism.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import com.traveltourism.model.BookingSelection;
import com.traveltourism.model.DBConnection;
import com.traveltourism.model.HolidayDataAccess;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/booking-confirmation")
public class BookingConfirmationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        /*
         * User must be logged in to access booking confirmation.
         */
        if (session == null
                || !Boolean.TRUE.equals(session.getAttribute("userLoggedIn"))) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?redirect=/destinations"
            );

            return;
        }

        /*
         * Show booking receipt if available.
         */
        if (session.getAttribute("bookingReceipt") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/destinations"
            );

            return;
        }

        response.setHeader("Cache-Control", "no-store");

        request.setAttribute(
                "receipt",
                session.getAttribute("bookingReceipt")
        );

        request.getRequestDispatcher(
                "/booking_confirmation.jsp"
        ).forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);


        /* =========================================================
           CHECK LOGIN
           ========================================================= */

        if (session == null
                || !Boolean.TRUE.equals(
                        session.getAttribute("userLoggedIn"))) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?redirect=/destinations"
            );

            return;
        }


        /* =========================================================
           CHECK BOOKING TOKEN
           ========================================================= */

        String bookingToken =
                request.getParameter("bookingToken");

        Object sessionBookingToken =
                session.getAttribute("bookingToken");

        if (bookingToken == null
                || sessionBookingToken == null
                || !bookingToken.equals(
                        sessionBookingToken.toString())) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Your booking form has expired. Please select your package again."
            );

            return;
        }


        Map<String, Object> selected = null;


        try {

            /* =====================================================
               LOAD SELECTED PACKAGE
               ===================================================== */

            selected = BookingSelection.load(
                    request.getParameter("holiday_id"),
                    request.getParameter("tour_id")
            );


            /* =====================================================
               GET LOGGED-IN USER ID
               ===================================================== */

            Object userIdObject =
                    session.getAttribute("userId");

            if (userIdObject == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/login.jsp?redirect=/destinations"
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

                throw new IllegalArgumentException(
                        "Your login session is invalid. Please login again."
                );
            }


            /* =====================================================
               BOOKING DETAILS
               ===================================================== */

            /*
             * We still read these fields for validation/error
             * handling, but the actual Name, Email and Phone
             * stored in the booking are taken from the logged-in
             * user's database record below.
             */

            String submittedName =
                    required(
                            request,
                            "customerName",
                            120
                    );

            String submittedEmail =
                    required(
                            request,
                            "email",
                            254
                    );

            String submittedPhone =
                    required(
                            request,
                            "phone",
                            30
                    );


            if (!submittedEmail.matches(
                    "[^\\s@]+@[^\\s@]+\\.[^\\s@]+")) {

                throw new IllegalArgumentException(
                        "Enter a valid email address."
                );
            }


            if (!submittedPhone.matches(
                    "[+0-9() .-]{7,30}")) {

                throw new IllegalArgumentException(
                        "Enter a valid phone number."
                );
            }


            /* =====================================================
               TRAVELLERS + DATE
               ===================================================== */

            int travelers;

            LocalDate date;

            try {

                travelers =
                        Integer.parseInt(
                                request.getParameter("travelers")
                        );

                date =
                        LocalDate.parse(
                                request.getParameter("travelDate")
                        );

            } catch (Exception ex) {

                throw new IllegalArgumentException(
                        "Enter a valid travel date and traveller count."
                );
            }


            if (travelers < 1 || travelers > 30) {

                throw new IllegalArgumentException(
                        "Choose between 1 and 30 travellers."
                );
            }


            if (date.isBefore(
                    HolidayDataAccess.today())) {

                throw new IllegalArgumentException(
                        "Travel date cannot be in the past."
                );
            }


            /* =====================================================
               PREFERENCES
               ===================================================== */

            String preferences =
                    request.getParameter("preferences");

            if (preferences == null) {
                preferences = "";
            }

            preferences = preferences.trim();


            if (preferences.length() > 2000) {

                throw new IllegalArgumentException(
                        "Keep your preferences within 2,000 characters."
                );
            }


            /* =====================================================
               CONTACT PREFERENCE
               ===================================================== */

            String contactPreference =
                    request.getParameter("contactPreference");


            if (!Set.of(
                    "email",
                    "phone",
                    "whatsapp"
            ).contains(contactPreference)) {

                throw new IllegalArgumentException(
                        "Choose how you would like us to contact you."
                );
            }


            /* =====================================================
               PICKUP LOCATION
               ===================================================== */

            String pickupLocation =
                    request.getParameter("pickupLocation");

            if (pickupLocation == null) {
                pickupLocation = "";
            }

            pickupLocation =
                    pickupLocation.trim();


            if (pickupLocation.length() > 180) {

                throw new IllegalArgumentException(
                        "Keep the pickup location within 180 characters."
                );
            }


            /* =====================================================
               TERMS
               ===================================================== */

            if (!"accepted".equals(
                    request.getParameter("termsAccepted"))) {

                throw new IllegalArgumentException(
                        "Please accept the booking-request terms before continuing."
                );
            }


            /* =====================================================
               TOTAL PRICE
               ===================================================== */

            long total =
                    ((Number) selected.get("price")).longValue()
                    * travelers;


            String reference =
                    UUID.randomUUID().toString();


            /* =====================================================
               DATABASE
               ===================================================== */

            try (Connection con =
                    DBConnection.getConnection()) {

                if (con == null) {

                    throw new SQLException(
                            "Database connection unavailable"
                    );
                }


                /* =================================================
                   GET CURRENT LOGGED-IN USER DETAILS
                   ================================================= */

                String userSql = """
                        SELECT user_id, full_name, email, phone
                        FROM users
                        WHERE user_id = ?
                        """;


                String customerName;
                String email;
                String phone;


                try (PreparedStatement userStatement =
                        con.prepareStatement(userSql)) {

                    userStatement.setLong(
                            1,
                            userId
                    );


                    try (ResultSet userResult =
                            userStatement.executeQuery()) {

                        if (!userResult.next()) {

                            throw new IllegalArgumentException(
                                    "Your user account could not be found. Please login again."
                            );
                        }


                        customerName =
                                userResult.getString(
                                        "full_name"
                                );

                        email =
                                userResult.getString(
                                        "email"
                                );

                        phone =
                                userResult.getString(
                                        "phone"
                                );
                    }
                }


                /* =================================================
                   CHECK USER CONTACT DETAILS
                   ================================================= */

                if (customerName == null
                        || customerName.isBlank()) {

                    throw new IllegalArgumentException(
                            "Your account does not have a name. Please update your profile."
                    );
                }


                if (email == null
                        || email.isBlank()) {

                    throw new IllegalArgumentException(
                            "Your account does not have an email address."
                    );
                }


                if (phone == null
                        || phone.isBlank()) {

                    throw new IllegalArgumentException(
                            "Your account does not have a phone number. Please update your profile."
                    );
                }


                /* =================================================
                   INSERT BOOKING
                   ================================================= */

                String sql = """
                        INSERT INTO booking_requests
                        (
                            user_id,
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
                            terms_accepted_at,
                            booking_channel,
                            total_price
                        )
                        VALUES
                        (
                            ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,
                            ?, ?, ?, ?, ?, ?, ?,
                            CURRENT_TIMESTAMP, 'account', ?
                        )
                        """;


                try (PreparedStatement ps =
                        con.prepareStatement(sql)) {

                    ps.setLong(
                            1,
                            userId
                    );

                    ps.setString(
                            2,
                            reference
                    );

                    ps.setString(
                            3,
                            bookingToken
                    );

                    ps.setString(
                            4,
                            (String) selected.get("type")
                    );

                    ps.setString(
                            5,
                            (String) selected.get("id")
                    );

                    ps.setString(
                            6,
                            (String) selected.get("name")
                    );

                    ps.setString(
                            7,
                            (String) selected.get("departure")
                    );

                    ps.setInt(
                            8,
                            (Integer) selected.get("duration")
                    );

                    ps.setInt(
                            9,
                            (Integer) selected.get("price")
                    );

                    ps.setString(
                            10,
                            customerName
                    );

                    ps.setString(
                            11,
                            email
                    );

                    ps.setString(
                            12,
                            phone
                    );

                    ps.setInt(
                            13,
                            travelers
                    );

                    ps.setDate(
                            14,
                            java.sql.Date.valueOf(date)
                    );

                    ps.setString(
                            15,
                            preferences
                    );

                    ps.setString(
                            16,
                            contactPreference
                    );

                    ps.setString(
                            17,
                            pickupLocation
                    );

                    ps.setLong(
                            18,
                            total
                    );


                    ps.executeUpdate();
                }


                /* =================================================
                   CREATE RECEIPT
                   ================================================= */

                Map<String, Object> receipt =
                        new LinkedHashMap<>(selected);


                receipt.put(
                        "reference",
                        reference
                );

                receipt.put(
                        "customerName",
                        customerName
                );

                receipt.put(
                        "email",
                        email
                );

                receipt.put(
                        "phone",
                        phone
                );

                receipt.put(
                        "travelers",
                        travelers
                );

                receipt.put(
                        "date",
                        date.toString()
                );

                receipt.put(
                        "preferences",
                        preferences
                );

                receipt.put(
                        "contactPreference",
                        contactPreference
                );

                receipt.put(
                        "pickupLocation",
                        pickupLocation
                );

                receipt.put(
                        "total",
                        total
                );


                session.setAttribute(
                        "bookingReceipt",
                        receipt
                );


                /*
                 * Generate a fresh token after successful booking
                 * so the same form cannot be submitted twice.
                 */

                session.setAttribute(
                        "bookingToken",
                        UUID.randomUUID().toString()
                );


                response.sendRedirect(
                        request.getContextPath()
                        + "/booking-confirmation"
                );
            }


        } catch (IllegalArgumentException ex) {

            if (selected == null) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        ex.getMessage()
                );

                return;
            }


            showError(
                    request,
                    response,
                    selected,
                    HttpServletResponse.SC_BAD_REQUEST,
                    ex.getMessage()
            );


        } catch (SQLException ex) {

            log(
                    "Unable to save booking request",
                    ex
            );


            if (selected == null) {

                response.sendError(
                        HttpServletResponse.SC_SERVICE_UNAVAILABLE,
                        "Bookings are temporarily unavailable."
                );

                return;
            }


            showError(
                    request,
                    response,
                    selected,
                    HttpServletResponse.SC_SERVICE_UNAVAILABLE,
                    "We could not save this request. Please try again shortly. If you already submitted it, check your booking confirmation before retrying."
            );
        }
    }


    /* =============================================================
       REQUIRED FIELD VALIDATION
       ============================================================= */

    private String required(
            HttpServletRequest request,
            String field,
            int max) {

        String value =
                request.getParameter(field);


        if (value == null
                || value.isBlank()
                || value.trim().length() > max) {

            throw new IllegalArgumentException(
                    "Please complete your contact details within the allowed lengths."
            );
        }


        return value.trim();
    }


    /* =============================================================
       SHOW BOOKING ERROR
       ============================================================= */

    private void showError(
            HttpServletRequest request,
            HttpServletResponse response,
            Map<String, Object> selected,
            int status,
            String error)
            throws ServletException, IOException {

        response.setStatus(status);


        request.setAttribute(
                "selection",
                selected
        );


        request.setAttribute(
                "today",
                HolidayDataAccess.today()
        );


        request.setAttribute(
                "error",
                error
        );


        request.getRequestDispatcher(
                "/booking.jsp"
        ).forward(
                request,
                response
        );
    }
}