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

@WebServlet("/manage-tour-images")
public class ManageTourImagesServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String tourIdParameter = request.getParameter("tourId");

        /*
         * If no tour ID is supplied, simply open the page.
         * The JSP will display the tour-selection form.
         */
        if (tourIdParameter == null ||
                tourIdParameter.trim().isEmpty()) {

            request.getRequestDispatcher(
                    "/admin/manage-tour-images.jsp"
            ).forward(request, response);

            return;
        }

        int tourId;

        try {

            tourId = Integer.parseInt(
                    tourIdParameter.trim()
            );

        } catch (NumberFormatException e) {

            request.setAttribute(
                    "errorMessage",
                    "Invalid Tour ID."
            );

            request.getRequestDispatcher(
                    "/admin/manage-tour-images.jsp"
            ).forward(request, response);

            return;
        }

        if (tourId <= 0) {

            request.setAttribute(
                    "errorMessage",
                    "Invalid Tour ID."
            );

            request.getRequestDispatcher(
                    "/admin/manage-tour-images.jsp"
            ).forward(request, response);

            return;
        }


        // =========================================================
        // SQL
        // =========================================================

        String tourSQL =
                "SELECT id, name " +
                "FROM tours " +
                "WHERE id = ?";

        String imagesSQL =
                "SELECT id, tour_id, mime_type, " +
                "original_name, is_cover " +
                "FROM tour_images " +
                "WHERE tour_id = ? " +
                "ORDER BY is_cover DESC, id ASC";


        // =========================================================
        // DATABASE
        // =========================================================

        try (Connection connection =
                     DBConnection.getConnection()) {


            // -----------------------------------------------------
            // FIND TOUR
            // -----------------------------------------------------

            try (PreparedStatement statement =
                         connection.prepareStatement(tourSQL)) {

                statement.setInt(1, tourId);

                try (ResultSet resultSet =
                             statement.executeQuery()) {

                    if (!resultSet.next()) {

                        request.setAttribute(
                                "errorMessage",
                                "Tour with ID " + tourId +
                                " does not exist."
                        );

                        request.getRequestDispatcher(
                                "/admin/manage-tour-images.jsp"
                        ).forward(request, response);

                        return;
                    }

                    /*
                     * We don't need a separate Tour object here.
                     * Store only the values required by the JSP.
                     */

                    request.setAttribute(
                            "selectedTourId",
                            resultSet.getInt("id")
                    );

                    request.setAttribute(
                            "selectedTourName",
                            resultSet.getString("name")
                    );
                }
            }


            // -----------------------------------------------------
            // LOAD IMAGES
            // -----------------------------------------------------

            try (PreparedStatement statement =
                         connection.prepareStatement(imagesSQL)) {

                statement.setInt(1, tourId);

                try (ResultSet resultSet =
                             statement.executeQuery()) {

                    java.util.List<TourImageData> images =
                            new java.util.ArrayList<>();

                    while (resultSet.next()) {

                        TourImageData image =
                                new TourImageData();

                        image.setId(
                                resultSet.getInt("id")
                        );

                        image.setTourId(
                                resultSet.getInt("tour_id")
                        );

                        image.setMimeType(
                                resultSet.getString("mime_type")
                        );

                        image.setOriginalName(
                                resultSet.getString("original_name")
                        );

                        image.setCover(
                                resultSet.getBoolean("is_cover")
                        );

                        images.add(image);
                    }

                    request.setAttribute(
                            "images",
                            images
                    );
                }
            }


            // -----------------------------------------------------
            // DISPLAY JSP
            // -----------------------------------------------------

            request.getRequestDispatcher(
                    "/admin/manage-tour-images.jsp"
            ).forward(request, response);


        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "errorMessage",
                    "Unable to load tour images."
            );

            request.getRequestDispatcher(
                    "/admin/manage-tour-images.jsp"
            ).forward(request, response);
        }
    }


    // =============================================================
    // IMAGE DATA CLASS
    // =============================================================

    public static class TourImageData {

        private int id;
        private int tourId;
        private String mimeType;
        private String originalName;
        private boolean cover;


        public TourImageData() {
        }


        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }


        public int getTourId() {
            return tourId;
        }

        public void setTourId(int tourId) {
            this.tourId = tourId;
        }


        public String getMimeType() {
            return mimeType;
        }

        public void setMimeType(String mimeType) {
            this.mimeType = mimeType;
        }


        public String getOriginalName() {
            return originalName;
        }

        public void setOriginalName(String originalName) {
            this.originalName = originalName;
        }


        public boolean isCover() {
            return cover;
        }

        public void setCover(boolean cover) {
            this.cover = cover;
        }
    }
}