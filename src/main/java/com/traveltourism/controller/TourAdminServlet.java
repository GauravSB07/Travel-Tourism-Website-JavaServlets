package com.traveltourism.controller;

import com.traveltourism.model.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/tour-admin")
public class TourAdminServlet extends HttpServlet {

    // ==========================================
    // GET
    // ==========================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

            try {
                if ("edit".equals(action)) {
                    showEditTour(request, response);
            } else {
                showTours(request, response); 
            } 
        }catch (Exception ex) {
                System.getLogger(TourAdminServlet.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
    }


    // ==========================================
    // POST
    // ==========================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action =
                request.getParameter("action");

        try {

            if ("add".equals(action)) {

                addTour(request);

            } else if ("update".equals(action)) {

                updateTour(request);

            } else if ("delete".equals(action)) {

                deleteTour(request);
            }

            response.sendRedirect(
                    request.getContextPath()
                            + "/tour-admin?message="
                            + java.net.URLEncoder.encode(
                            "Operation completed successfully",
                            java.nio.charset.StandardCharsets.UTF_8)
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                            + "/tour-admin?message="
                            + java.net.URLEncoder.encode(
                            "Operation failed",
                            java.nio.charset.StandardCharsets.UTF_8)
            );
        }
    }


    // ==========================================
    // SHOW TOURS
    // ==========================================

    private void showTours(
            HttpServletRequest request,
            HttpServletResponse response)
            throws Exception {

        String sql =
                "SELECT id, name, category, departure_city, " +
                "duration, price, short_description, status " +
                "FROM tours " +
                "ORDER BY id DESC";

        List<Tour> tours =
                new ArrayList<>();

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet =
                     statement.executeQuery()) {

            while (resultSet.next()) {

                Tour tour = new Tour();

                tour.id =
                        resultSet.getInt("id");

                tour.name =
                        resultSet.getString("name");

                tour.category =
                        resultSet.getString("category");

                tour.departureCity =
                        resultSet.getString(
                                "departure_city");

                tour.duration =
                        resultSet.getInt("duration");

                tour.price =
                        resultSet.getDouble("price");

                tour.shortDescription =
                        resultSet.getString(
                                "short_description");

                tour.status =
                        resultSet.getString("status");

                tours.add(tour);
            }
        }

        request.setAttribute("tours", tours);

        request.getRequestDispatcher(
                "/admin/manage-tours.jsp"
        ).forward(request, response);
    }


    // ==========================================
    // SHOW EDIT
    // ==========================================

    private void showEditTour(
            HttpServletRequest request,
            HttpServletResponse response)
            throws Exception {

        int id =
                Integer.parseInt(
                        request.getParameter("id"));

        String sql =
                "SELECT * FROM tours WHERE id = ?";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, id);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                if (resultSet.next()) {

                    Tour tour = new Tour();

                    tour.id =
                            resultSet.getInt("id");

                    tour.name =
                            resultSet.getString("name");

                    tour.category =
                            resultSet.getString("category");

                    tour.departureCity =
                            resultSet.getString(
                                    "departure_city");

                    tour.duration =
                            resultSet.getInt("duration");

                    tour.price =
                            resultSet.getDouble("price");

                    tour.shortDescription =
                            resultSet.getString(
                                    "short_description");

                    tour.status =
                            resultSet.getString("status");

                    request.setAttribute(
                            "tour",
                            tour
                    );
                }
            }
        }

        request.getRequestDispatcher(
                "/admin/manage-tours.jsp"
        ).forward(request, response);
    }


    // ==========================================
    // ADD TOUR
    // ==========================================

    private void addTour(
            HttpServletRequest request)
            throws Exception {

        String sql =
                "INSERT INTO tours " +
                "(name, category, departure_city, duration, " +
                "price, short_description, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

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
                    request.getParameter("departureCity")
            );

            statement.setInt(
                    4,
                    Integer.parseInt(
                            request.getParameter("duration"))
            );

            statement.setDouble(
                    5,
                    Double.parseDouble(
                            request.getParameter("price"))
            );

            statement.setString(
                    6,
                    request.getParameter("shortDescription")
            );

            statement.setString(
                    7,
                    request.getParameter("status")
            );

            statement.executeUpdate();
        }
    }


    // ==========================================
    // UPDATE TOUR
    // ==========================================

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
                "short_description = ?, " +
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
                    request.getParameter("departureCity")
            );

            statement.setInt(
                    4,
                    Integer.parseInt(
                            request.getParameter("duration"))
            );

            statement.setDouble(
                    5,
                    Double.parseDouble(
                            request.getParameter("price"))
            );

            statement.setString(
                    6,
                    request.getParameter("shortDescription")
            );

            statement.setString(
                    7,
                    request.getParameter("status")
            );

            statement.setInt(
                    8,
                    Integer.parseInt(
                            request.getParameter("id"))
            );

            statement.executeUpdate();
        }
    }


    // ==========================================
    // DELETE TOUR
    // ==========================================

    private void deleteTour(
            HttpServletRequest request)
            throws Exception {

        String sql =
                "DELETE FROM tours WHERE id = ?";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(
                    1,
                    Integer.parseInt(
                            request.getParameter("id"))
            );

            statement.executeUpdate();
        }
    }


    // ==========================================
    // SIMPLE MODEL
    // ==========================================

    public static class Tour {

        public int id;

        public String name;

        public String category;

        public String departureCity;

        public int duration;

        public double price;

        public String shortDescription;

        public String status;

        public int getId() {
            return id;
        }

        public String getName() {
            return name;
        }

        public String getCategory() {
            return category;
        }

        public String getDepartureCity() {
            return departureCity;
        }

        public int getDuration() {
            return duration;
        }

        public double getPrice() {
            return price;
        }

        public String getShortDescription() {
            return shortDescription;
        }

        public String getStatus() {
            return status;
        }
    }
}