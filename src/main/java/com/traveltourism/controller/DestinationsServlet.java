package com.traveltourism.controller;

import com.traveltourism.model.DBConnection;
import com.traveltourism.model.Tour;
import com.traveltourism.model.TourDataAccess;

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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/destinations")
public class DestinationsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        /* =========================================================
           LOAD ALL TOURS
           ========================================================= */

        TourDataAccess dao = new TourDataAccess();

        List<Tour> tours = dao.get_all_tours();


        /* =========================================================
           FILTER PARAMETERS
           ========================================================= */

        String city = request.getParameter("city");
        String category = request.getParameter("category");
        String place = request.getParameter("place");

        String price_min_str =
                request.getParameter("price_min");

        String price_max_str =
                request.getParameter("price_max");

        String duration_str =
                request.getParameter("duration");


        int price_min;
        int price_max;
        int duration;


        try {

            price_min =
                    parseNonNegativeInt(
                            price_min_str,
                            0
                    );

            price_max =
                    parseNonNegativeInt(
                            price_max_str,
                            Integer.MAX_VALUE
                    );

            duration =
                    parseNonNegativeInt(
                            duration_str,
                            0
                    );

        } catch (NumberFormatException exception) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Filter values must be valid non-negative numbers."
            );

            return;
        }


        if (price_min > price_max) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Minimum price cannot exceed maximum price."
            );

            return;
        }


        /* =========================================================
           APPLY FILTERS
           ========================================================= */

        List<Tour> filtered_list =
                new ArrayList<>();


        for (Tour t : tours) {

            boolean match_city =
                    city == null
                    || city.equals("all")
                    || t.getDepartureCity()
                            .equalsIgnoreCase(city);


            boolean match_category =
                    category == null
                    || category.equals("all")
                    || t.getCategory()
                            .equalsIgnoreCase(category);


            boolean match_price =
                    t.getPrice() >= price_min
                    && t.getPrice() <= price_max;


            boolean match_duration =
                    duration == 0
                    || t.getDuration() == duration;


            boolean match_place =
                    place == null
                    || place.isBlank()
                    || t.getName()
                            .toLowerCase()
                            .contains(place.toLowerCase())
                    || t.getCategory()
                            .toLowerCase()
                            .contains(place.toLowerCase())
                    || t.getDepartureCity()
                            .toLowerCase()
                            .contains(place.toLowerCase());


            if (
                    match_city
                    && match_category
                    && match_price
                    && match_duration
                    && match_place
            ) {

                filtered_list.add(t);

            }

        }


        /* =========================================================
           LOAD SAVED TOURS FOR LOGGED-IN USER
           ========================================================= */

        Map<Integer, Boolean> savedTourIds =
                new HashMap<>();


        HttpSession session =
                request.getSession(false);


        if (
                session != null
                && Boolean.TRUE.equals(
                        session.getAttribute("userLoggedIn")
                )
        ) {

            Object userIdObject =
                    session.getAttribute("userId");


            if (userIdObject != null) {

                try {

                    long userId =
                            Long.parseLong(
                                    userIdObject.toString()
                            );


                    String sql =
                            "SELECT tour_id " +
                            "FROM saved_tours " +
                            "WHERE user_id = ? " +
                            "AND tour_type = 'destination'";


                    try (
                            Connection con =
                                    DBConnection.getConnection();

                            PreparedStatement ps =
                                    con.prepareStatement(sql)
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


                                try {

                                    int id =
                                            Integer.parseInt(
                                                    tourId
                                            );

                                    savedTourIds.put(
                                            id,
                                            Boolean.TRUE
                                    );

                                } catch (
                                        NumberFormatException ignored
                                ) {

                                    /*
                                     * Ignore invalid saved tour IDs.
                                     */

                                }

                            }

                        }

                    }

                } catch (
                        SQLException
                        | NumberFormatException exception
                ) {

                    /*
                     * If saved-tour loading fails,
                     * the destination page should still work.
                     */

                    log(
                            "Could not load saved tours",
                            exception
                    );

                }

            }

        }


        /* =========================================================
           SEND DATA TO JSP
           ========================================================= */

        request.setAttribute(
                "tours",
                filtered_list
        );


        request.setAttribute(
                "resultCount",
                filtered_list.size()
        );


        request.setAttribute(
                "savedTourIds",
                savedTourIds
        );


        /* =========================================================
           OPEN DESTINATIONS PAGE
           ========================================================= */

        request.getRequestDispatcher(
                "/destinations.jsp"
        ).forward(
                request,
                response
        );

    }


    /* =============================================================
       NUMBER VALIDATION
       ============================================================= */

    private int parseNonNegativeInt(
            String value,
            int defaultValue) {

        if (
                value == null
                || value.isBlank()
        ) {

            return defaultValue;

        }


        int parsedValue =
                Integer.parseInt(value);


        if (parsedValue < 0) {

            throw new NumberFormatException(
                    "Negative numbers are not allowed."
            );

        }


        return parsedValue;

    }

}