package com.traveltourism.controller;

import com.traveltourism.model.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

@WebServlet("/admin/tour-action")
public class AdminTourActionServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action =
                request.getParameter("action");

        if (action == null ||
                action.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Missing action"
            );

            return;
        }

        try {

            switch (action) {

                case "addTour":
                    addTour(request);
                    break;

                case "updateTour":
                    updateTour(request);
                    break;

                case "deleteTour":
                    deleteTour(request);
                    break;

                case "saveDetails":
                    saveDetails(request);
                    break;

                case "deleteDetails":
                    deleteDetails(request);
                    break;

                case "addItinerary":
                    addItinerary(request);
                    break;

                case "updateItinerary":
                    updateItinerary(request);
                    break;

                case "deleteItinerary":
                    deleteItinerary(request);
                    break;

                case "addHotel":
                    addHotel(request);
                    break;

                case "updateHotel":
                    updateHotel(request);
                    break;

                case "deleteHotel":
                    deleteHotel(request);
                    break;

                case "deleteImage":
                    deleteImage(request);
                    break;

                default:

                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Unknown action"
                    );

                    return;
            }

            String tourId =
                    request.getParameter("tourId");

            if (tourId != null &&
                    !tourId.trim().isEmpty()) {

                response.sendRedirect(
                        request.getContextPath() +
                        "/admin/tours?tourId=" +
                        tourId
                );

            } else {

                response.sendRedirect(
                        request.getContextPath() +
                        "/admin/tours"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            throw new ServletException(
                    "Admin tour action failed",
                    e
            );
        }
    }

    // =============================================================
    // ADD TOUR
    // =============================================================

    private void addTour(
            HttpServletRequest request)
            throws Exception {

        String sql =
                "INSERT INTO tours " +
                "(name, category, departure_city, duration, price, status) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(
                             sql,
                             Statement.RETURN_GENERATED_KEYS)) {

            statement.setString(
                    1,
                    request.getParameter("name")
            );

            statement.setString(
                    2,
                    request.getParameter("category")
            );

            statement.setString(
                    3,
                    request.getParameter("departure_city")
            );

            statement.setInt(
                    4,
                    Integer.parseInt(
                            request.getParameter("duration")
                    )
            );

            statement.setBigDecimal(
                    5,
                    new BigDecimal(
                            request.getParameter("price")
                    )
            );

            statement.setString(
                    6,
                    request.getParameter("status")
            );

            statement.executeUpdate();
        }
    }

    // =============================================================
    // UPDATE TOUR
    // =============================================================

    private void updateTour(
            HttpServletRequest request)
            throws Exception {

        String sql =
                "UPDATE tours SET " +
                "name = ?, " +
                "category = ?, " +
                "departure_city = ?, " +
                "duration = ?, " +
                "price = ?, " +
                "status = ? " +
                "WHERE id = ?";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(
                    1,
                    request.getParameter("name")
            );

            statement.setString(
                    2,
                    request.getParameter("category")
            );

            statement.setString(
                    3,
                    request.getParameter("departure_city")
            );

            statement.setInt(
                    4,
                    Integer.parseInt(
                            request.getParameter("duration")
                    )
            );

            statement.setBigDecimal(
                    5,
                    new BigDecimal(
                            request.getParameter("price")
                    )
            );

            statement.setString(
                    6,
                    request.getParameter("status")
            );

            statement.setInt(
                    7,
                    Integer.parseInt(
                            request.getParameter("tourId")
                    )
            );

            statement.executeUpdate();
        }
    }

    // =============================================================
    // DELETE TOUR
    // =============================================================

    private void deleteTour(
            HttpServletRequest request)
            throws Exception {

        int tourId =
                Integer.parseInt(
                        request.getParameter("tourId")
                );

        try (Connection connection =
                     DBConnection.getConnection()) {

            connection.setAutoCommit(false);

            try {

                // Delete child records first.

                deleteByTourId(
                        connection,
                        "DELETE FROM tour_images WHERE tour_id = ?",
                        tourId
                );

                deleteByTourId(
                        connection,
                        "DELETE FROM tour_hotels WHERE tour_id = ?",
                        tourId
                );

                deleteByTourId(
                        connection,
                        "DELETE FROM tour_itinerary WHERE tour_id = ?",
                        tourId
                );

                deleteByTourId(
                        connection,
                        "DELETE FROM tour_details WHERE tour_id = ?",
                        tourId
                );

                // Finally delete tour.

                String sql =
                        "DELETE FROM tours WHERE id = ?";

                try (PreparedStatement statement =
                             connection.prepareStatement(sql)) {

                    statement.setInt(1, tourId);

                    statement.executeUpdate();
                }

                connection.commit();

            } catch (Exception e) {

                connection.rollback();

                throw e;
            }
        }
    }

    // =============================================================
    // SAVE TOUR DETAILS
    // =============================================================

    private void saveDetails(
            HttpServletRequest request)
            throws Exception {

        int tourId =
                Integer.parseInt(
                        request.getParameter("tourId")
                );

        String checkSql =
                "SELECT id FROM tour_details WHERE tour_id = ?";

        boolean exists = false;

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement check =
                     connection.prepareStatement(checkSql)) {

            check.setInt(1, tourId);

            try (ResultSet resultSet =
                         check.executeQuery()) {

                exists = resultSet.next();
            }

            if (exists) {

                String sql =
                        "UPDATE tour_details SET " +
                        "long_description = ?, " +
                        "highlights = ?, " +
                        "inclusions = ?, " +
                        "exclusions = ?, " +
                        "best_time = ?, " +
                        "map_embed = ?, " +
                        "duration_text = ?, " +
                        "states_covered = ?, " +
                        "cities_covered = ?, " +
                        "route = ?, " +
                        "preparation = ?, " +
                        "payment_terms = ?, " +
                        "upgrades_info = ? " +
                        "WHERE tour_id = ?";

                try (PreparedStatement statement =
                             connection.prepareStatement(sql)) {

                    setDetailsParameters(
                            statement,
                            request
                    );

                    statement.setInt(
                            14,
                            tourId
                    );

                    statement.executeUpdate();
                }

            } else {

                String sql =
                        "INSERT INTO tour_details " +
                        "(tour_id, long_description, highlights, " +
                        "inclusions, exclusions, best_time, map_embed, " +
                        "duration_text, states_covered, cities_covered, " +
                        "route, preparation, payment_terms, upgrades_info) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

                try (PreparedStatement statement =
                             connection.prepareStatement(sql)) {

                    statement.setInt(
                            1,
                            tourId
                    );

                    setDetailsParameters(
                            statement,
                            request,
                            2
                    );

                    statement.executeUpdate();
                }
            }
        }
    }

    private void setDetailsParameters(
            PreparedStatement statement,
            HttpServletRequest request)
            throws Exception {

        setDetailsParameters(
                statement,
                request,
                1
        );
    }

    private void setDetailsParameters(
            PreparedStatement statement,
            HttpServletRequest request,
            int startIndex)
            throws Exception {

        statement.setString(
                startIndex,
                request.getParameter("long_description")
        );

        statement.setString(
                startIndex + 1,
                request.getParameter("highlights")
        );

        statement.setString(
                startIndex + 2,
                request.getParameter("inclusions")
        );

        statement.setString(
                startIndex + 3,
                request.getParameter("exclusions")
        );

        statement.setString(
                startIndex + 4,
                request.getParameter("best_time")
        );

        statement.setString(
                startIndex + 5,
                request.getParameter("map_embed")
        );

        statement.setString(
                startIndex + 6,
                request.getParameter("duration_text")
        );

        statement.setString(
                startIndex + 7,
                request.getParameter("states_covered")
        );

        statement.setString(
                startIndex + 8,
                request.getParameter("cities_covered")
        );

        statement.setString(
                startIndex + 9,
                request.getParameter("route")
        );

        statement.setString(
                startIndex + 10,
                request.getParameter("preparation")
        );

        statement.setString(
                startIndex + 11,
                request.getParameter("payment_terms")
        );

        statement.setString(
                startIndex + 12,
                request.getParameter("upgrades_info")
        );
    }

    // =============================================================
    // DELETE TOUR DETAILS
    // =============================================================

    private void deleteDetails(
            HttpServletRequest request)
            throws Exception {

        String sql =
                "DELETE FROM tour_details WHERE tour_id = ?";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(
                    1,
                    Integer.parseInt(
                            request.getParameter("tourId")
                    )
            );

            statement.executeUpdate();
        }
    }

    // =============================================================
    // ADD ITINERARY
    // =============================================================

    private void addItinerary(
            HttpServletRequest request)
            throws Exception {

        String sql =
                "INSERT INTO tour_itinerary " +
                "(tour_id, day_number, day_title, day_description) " +
                "VALUES (?, ?, ?, ?)";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(
                    1,
                    Integer.parseInt(
                            request.getParameter("tourId")
                    )
            );

            statement.setInt(
                    2,
                    Integer.parseInt(
                            request.getParameter("day_number")
                    )
            );

            statement.setString(
                    3,
                    request.getParameter("day_title")
            );

            statement.setString(
                    4,
                    request.getParameter("day_description")
            );

            statement.executeUpdate();
        }
    }

    // =============================================================
    // UPDATE ITINERARY
    // =============================================================

    private void updateItinerary(
            HttpServletRequest request)
            throws Exception {

        String sql =
                "UPDATE tour_itinerary SET " +
                "day_number = ?, " +
                "day_title = ?, " +
                "day_description = ? " +
                "WHERE id = ? AND tour_id = ?";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(
                    1,
                    Integer.parseInt(
                            request.getParameter("day_number")
                    )
            );

            statement.setString(
                    2,
                    request.getParameter("day_title")
            );

            statement.setString(
                    3,
                    request.getParameter("day_description")
            );

            statement.setInt(
                    4,
                    Integer.parseInt(
                            request.getParameter("id")
                    )
            );

            statement.setInt(
                    5,
                    Integer.parseInt(
                            request.getParameter("tourId")
                    )
            );

            statement.executeUpdate();
        }
    }

    // =============================================================
    // DELETE ITINERARY
    // =============================================================

    private void deleteItinerary(
            HttpServletRequest request)
            throws Exception {

        String sql =
                "DELETE FROM tour_itinerary " +
                "WHERE id = ? AND tour_id = ?";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(
                    1,
                    Integer.parseInt(
                            request.getParameter("id")
                    )
            );

            statement.setInt(
                    2,
                    Integer.parseInt(
                            request.getParameter("tourId")
                    )
            );

            statement.executeUpdate();
        }
    }

    // =============================================================
    // ADD HOTEL
    // =============================================================

    private void addHotel(
            HttpServletRequest request)
            throws Exception {

        String sql =
                "INSERT INTO tour_hotels " +
                "(tour_id, city, hotel_name, check_in, check_out) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(
                    1,
                    Integer.parseInt(
                            request.getParameter("tourId")
                    )
            );

            statement.setString(
                    2,
                    request.getParameter("city")
            );

            statement.setString(
                    3,
                    request.getParameter("hotel_name")
            );

            statement.setDate(
                    4,
                    Date.valueOf(
                            request.getParameter("check_in")
                    )
            );

            statement.setDate(
                    5,
                    Date.valueOf(
                            request.getParameter("check_out")
                    )
            );

            statement.executeUpdate();
        }
    }

    // =============================================================
    // UPDATE HOTEL
    // =============================================================

    private void updateHotel(
            HttpServletRequest request)
            throws Exception {

        String sql =
                "UPDATE tour_hotels SET " +
                "city = ?, " +
                "hotel_name = ?, " +
                "check_in = ?, " +
                "check_out = ? " +
                "WHERE id = ? AND tour_id = ?";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(
                    1,
                    request.getParameter("city")
            );

            statement.setString(
                    2,
                    request.getParameter("hotel_name")
            );

            statement.setDate(
                    3,
                    Date.valueOf(
                            request.getParameter("check_in")
                    )
            );

            statement.setDate(
                    4,
                    Date.valueOf(
                            request.getParameter("check_out")
                    )
            );

            statement.setInt(
                    5,
                    Integer.parseInt(
                            request.getParameter("id")
                    )
            );

            statement.setInt(
                    6,
                    Integer.parseInt(
                            request.getParameter("tourId")
                    )
            );

            statement.executeUpdate();
        }
    }

    // =============================================================
    // DELETE HOTEL
    // =============================================================

    private void deleteHotel(
            HttpServletRequest request)
            throws Exception {

        String sql =
                "DELETE FROM tour_hotels " +
                "WHERE id = ? AND tour_id = ?";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(
                    1,
                    Integer.parseInt(
                            request.getParameter("id")
                    )
            );

            statement.setInt(
                    2,
                    Integer.parseInt(
                            request.getParameter("tourId")
                    )
            );

            statement.executeUpdate();
        }
    }

    // =============================================================
    // DELETE IMAGE
    // =============================================================

    private void deleteImage(
            HttpServletRequest request)
            throws Exception {

        String sql =
                "DELETE FROM tour_images " +
                "WHERE id = ? AND tour_id = ?";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(
                    1,
                    Integer.parseInt(
                            request.getParameter("id")
                    )
            );

            statement.setInt(
                    2,
                    Integer.parseInt(
                            request.getParameter("tourId")
                    )
            );

            statement.executeUpdate();
        }
    }

    // =============================================================
    // COMMON DELETE
    // =============================================================

    private void deleteByTourId(
            Connection connection,
            String sql,
            int tourId)
            throws Exception {

        try (PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(
                    1,
                    tourId
            );

            statement.executeUpdate();
        }
    }
}