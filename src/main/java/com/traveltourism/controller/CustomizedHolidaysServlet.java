package com.traveltourism.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.traveltourism.model.DBConnection;
import com.traveltourism.model.HolidayDataAccess;
import com.traveltourism.model.HolidayPackage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/customize")
public class CustomizedHolidaysServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int duration;
        int budget;

        try {

            duration = number(
                    request.getParameter("duration"),
                    0
            );

            budget = number(
                    request.getParameter("budget"),
                    0
            );

        } catch (NumberFormatException ex) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Choose a valid duration and a non-negative budget."
            );

            return;
        }


        request.setAttribute(
                "selectedDuration",
                duration
        );

        request.setAttribute(
                "selectedBudget",
                budget == 0 ? "" : budget
        );

        request.setAttribute(
                "holidaysLoaded",
                true
        );


        /*
         * =========================================================
         * SAVED HOLIDAYS
         * =========================================================
         */

        Map<String, Boolean> savedHolidayIds =
                new HashMap<>();


        HttpSession session =
                request.getSession(false);


        if (session != null
                && Boolean.TRUE.equals(
                        session.getAttribute("userLoggedIn"))) {

            Object userIdObject =
                    session.getAttribute("userId");


            if (userIdObject != null) {

                try {

                    long userId =
                            Long.parseLong(
                                    userIdObject.toString()
                            );


                    String savedSql = """
                            SELECT tour_id
                            FROM saved_tours
                            WHERE user_id = ?
                              AND tour_type = 'holiday'
                            """;


                    try (
                        Connection con =
                                DBConnection.getConnection();

                        PreparedStatement ps =
                                con.prepareStatement(savedSql)
                    ) {

                        ps.setLong(
                                1,
                                userId
                        );


                        try (
                            ResultSet rs =
                                    ps.executeQuery()
                        ) {

                            while (rs.next()) {

                                String tourId =
                                        rs.getString("tour_id");

                                if (tourId != null
                                        && !tourId.isBlank()) {

                                    savedHolidayIds.put(
                                            tourId,
                                            true
                                    );

                                }
                            }
                        }
                    }

                } catch (Exception ex) {

                    /*
                     * Do not stop the holiday page just because
                     * the saved-tour lookup failed.
                     */

                    log(
                            "Could not load saved holidays",
                            ex
                    );
                }
            }
        }


        request.setAttribute(
                "savedHolidayIds",
                savedHolidayIds
        );


        /*
         * =========================================================
         * LOAD HOLIDAY PACKAGES
         * =========================================================
         */

        try {

            HolidayDataAccess dataAccess =
                    new HolidayDataAccess();


            List<HolidayPackage> available =
                    dataAccess.getAvailable();


            /*
             * Get filters
             */

            String occasion =
                    request.getParameter("occasion");

            String city =
                    request.getParameter("city");


            /*
             * Apply filters
             */

            List<HolidayPackage> holidays =
                    available.stream()

                            .filter(p ->
                                    occasion == null
                                    || occasion.isBlank()
                                    || p.getOccasion()
                                            .equals(occasion)
                            )

                            .filter(p ->
                                    city == null
                                    || city.isBlank()
                                    || p.getDepartureCity()
                                            .equals(city)
                            )

                            .filter(p ->
                                    duration == 0
                                    || p.getDuration()
                                            == duration
                            )

                            .filter(p ->
                                    budget == 0
                                    || p.getPrice()
                                            <= budget
                            )

                            .toList();


            /*
             * =====================================================
             * FILTER OPTIONS
             * =====================================================
             */

            request.setAttribute(
                    "durations",
                    available.stream()
                            .map(HolidayPackage::getDuration)
                            .distinct()
                            .sorted()
                            .toList()
            );


            request.setAttribute(
                    "occasions",
                    available.stream()
                            .map(HolidayPackage::getOccasion)
                            .filter(v ->
                                    v != null
                                    && !v.isBlank()
                            )
                            .distinct()
                            .sorted()
                            .toList()
            );


            request.setAttribute(
                    "cities",
                    available.stream()
                            .map(HolidayPackage::getDepartureCity)
                            .filter(v ->
                                    v != null
                                    && !v.isBlank()
                            )
                            .distinct()
                            .sorted()
                            .toList()
            );


            /*
             * =====================================================
             * ACTUAL HOLIDAY RESULTS
             * =====================================================
             */

            request.setAttribute(
                    "holidays",
                    holidays
            );


            request.setAttribute(
                    "resultCount",
                    holidays.size()
            );


        } catch (SQLException ex) {

            log(
                    "Could not load customized holidays",
                    ex
            );


            response.setStatus(
                    HttpServletResponse.SC_SERVICE_UNAVAILABLE
            );


            request.setAttribute(
                    "loadError",
                    true
            );


            request.setAttribute(
                    "holidays",
                    List.of()
            );


            request.setAttribute(
                    "resultCount",
                    0
            );

        }


        /*
         * =========================================================
         * FORWARD TO JSP
         * =========================================================
         */

        request.getRequestDispatcher(
                "/customized.jsp"
        ).forward(
                request,
                response
        );
    }


    /*
     * =============================================================
     * NUMBER HELPER
     * =============================================================
     */

    private int number(
            String value,
            int fallback)
            throws NumberFormatException {

        if (value == null
                || value.isBlank()) {

            return fallback;
        }


        int result =
                Integer.parseInt(
                        value.trim()
                );


        if (result < 0) {

            throw new NumberFormatException(
                    "Negative value"
            );
        }


        return result;
    }
}