package com.traveltourism.controller;

import com.traveltourism.model.ContactEnquiryDataAccess;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.SecureRandom;
import java.sql.SQLException;
import java.util.Base64;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.regex.Pattern;

@WebServlet("/contact")
public class Contact_usServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final Pattern EMAIL =
            Pattern.compile("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");

    private static final String[] CONTACT_FIELDS = {
        "name",
        "email",
        "phone",
        "enquiryType",
        "destination",
        "travelMonth",
        "travellers",
        "budget",
        "message",
        "tourId"
    };

    @Override
    protected void doGet(HttpServletRequest req,
            HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        // Create CSRF token when needed.
        if (session.getAttribute("contactCsrf") == null) {
            byte[] bytes = new byte[24];
            new SecureRandom().nextBytes(bytes);

            session.setAttribute(
                    "contactCsrf",
                    Base64.getUrlEncoder()
                            .withoutPadding()
                            .encodeToString(bytes)
            );
        }

        // Move one-time messages/draft from session to request.
        for (String key : new String[]{
            "contactSuccess",
            "contactError",
            "contactDraft"
        }) {
            Object value = session.getAttribute(key);

            if (value != null) {
                req.setAttribute(key, value);
                session.removeAttribute(key);
            }
        }

        /*
         * For a logged-in user, the JSP reads the profile details
         * directly from the session:
         *
         * userName  -> users.full_name
         * userEmail -> users.email
         * userPhone -> users.phone
         *
         * If a validation error created contactDraft, the draft
         * values take priority so the user's entered data is preserved.
         */

        req.getRequestDispatcher("/contact_us.jsp")
                .forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req,
            HttpServletResponse res)
            throws IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();

        // =========================
        // CSRF CHECK
        // =========================

        String submittedCsrf = req.getParameter("csrf");
        Object sessionCsrf = session.getAttribute("contactCsrf");

        if (submittedCsrf == null
                || sessionCsrf == null
                || !submittedCsrf.equals(sessionCsrf.toString())) {

            res.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Reload the contact page and try again."
            );

            return;
        }

        // =========================
        // GET FORM DATA
        // =========================

        Map<String, String> values = new LinkedHashMap<>();

        for (String key : CONTACT_FIELDS) {
            values.put(
                    key,
                    Optional.ofNullable(req.getParameter(key))
                            .orElse("")
                            .trim()
            );
        }

        try {

            // =========================
            // VALIDATION
            // =========================

            check(
                    values.get("name"),
                    2,
                    120,
                    "Enter your full name."
            );

            if (!EMAIL.matcher(values.get("email")).matches()
                    || values.get("email").length() > 254) {

                throw new IllegalArgumentException(
                        "Enter a valid email address."
                );
            }

            if (!values.get("phone").matches(
                    "(?=.*\\d)[+0-9() .-]{7,30}")) {

                throw new IllegalArgumentException(
                        "Enter a valid phone number."
                );
            }

            if (!Set.of(
                    "general",
                    "destination",
                    "customized_holiday",
                    "existing_booking"
            ).contains(values.get("enquiryType"))) {

                throw new IllegalArgumentException(
                        "Choose how we can help."
                );
            }

            if (values.get("destination").length() > 120
                    || values.get("travelMonth").length() > 20
                    || values.get("budget").length() > 40) {

                throw new IllegalArgumentException(
                        "One of the planning details is too long."
                );
            }

            if (!values.get("travellers").isBlank()) {

                int numberOfTravellers;

                try {
                    numberOfTravellers =
                            Integer.parseInt(values.get("travellers"));

                } catch (NumberFormatException ex) {
                    throw new IllegalArgumentException(
                            "Enter a valid traveller count."
                    );
                }

                if (numberOfTravellers < 1
                        || numberOfTravellers > 50) {

                    throw new IllegalArgumentException(
                            "Traveller count must be between 1 and 50."
                    );
                }
            }

            if (!values.get("tourId").isBlank()) {

                int tourId;

                try {
                    tourId = Integer.parseInt(values.get("tourId"));

                } catch (NumberFormatException ex) {
                    throw new IllegalArgumentException(
                            "Invalid tour selection."
                    );
                }

                if (tourId < 1) {
                    throw new IllegalArgumentException(
                            "Invalid tour selection."
                    );
                }
            }

            check(
                    values.get("message"),
                    10,
                    3000,
                    "Tell us a little more about your enquiry."
            );

            // =========================
            // SAVE ENQUIRY
            // =========================

            long id =
                    ContactEnquiryDataAccess.create(values);

            session.setAttribute(
                    "contactSuccess",
                    "Thank you, "
                    + values.get("name")
                    + ". Your enquiry #"
                    + id
                    + " has reached our travel team."
            );

            // Force a fresh CSRF token after successful submission.
            session.removeAttribute("contactCsrf");

        } catch (IllegalArgumentException ex) {

            session.setAttribute(
                    "contactError",
                    ex.getMessage()
            );

            // Keep entered values when the form is shown again.
            session.setAttribute(
                    "contactDraft",
                    values
            );

        } catch (SQLException ex) {

            log("Contact enquiry save failed", ex);

            String message;

            if (ex.getErrorCode() == 1146) {
                message =
                        "Contact storage is not ready yet. "
                        + "Please ask the administrator to run "
                        + "database/contact_enquiries.sql.";
            } else {
                message =
                        "We could not save your enquiry right now. "
                        + "Please try again.";
            }

            session.setAttribute(
                    "contactError",
                    message
            );

            session.setAttribute(
                    "contactDraft",
                    values
            );
        }

        res.sendRedirect(
                req.getContextPath() + "/contact"
        );
    }

    private static void check(
            String value,
            int min,
            int max,
            String message) {

        if (value == null
                || value.length() < min
                || value.length() > max) {

            throw new IllegalArgumentException(message);
        }
    }
}
