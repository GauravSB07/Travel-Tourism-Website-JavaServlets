package com.traveltourism.controller;

import com.traveltourism.model.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/delete-tour-image")
public class DeleteTourImageServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");


        // =========================================================
        // GET IMAGE ID
        // =========================================================

        String imageIdParameter =
                request.getParameter("imageId");


        if (imageIdParameter == null ||
                imageIdParameter.trim().isEmpty()) {

            redirectWithMessage(
                    request,
                    response,
                    "Image ID is required"
            );

            return;
        }


        int imageId;

        try {

            imageId =
                    Integer.parseInt(
                            imageIdParameter.trim()
                    );

        } catch (NumberFormatException e) {

            redirectWithMessage(
                    request,
                    response,
                    "Invalid image ID"
            );

            return;
        }


        if (imageId <= 0) {

            redirectWithMessage(
                    request,
                    response,
                    "Invalid image ID"
            );

            return;
        }


        // =========================================================
        // SQL
        // =========================================================

        String findImageSQL =
                "SELECT tour_id, is_cover " +
                "FROM tour_images " +
                "WHERE id = ?";


        String deleteImageSQL =
                "DELETE FROM tour_images " +
                "WHERE id = ?";


        /*
         * If the deleted image was the cover,
         * choose the oldest remaining image.
         */
        String findReplacementSQL =
                "SELECT id " +
                "FROM tour_images " +
                "WHERE tour_id = ? " +
                "ORDER BY id ASC " +
                "LIMIT 1";


        String makeReplacementCoverSQL =
                "UPDATE tour_images " +
                "SET is_cover = TRUE " +
                "WHERE id = ?";


        // =========================================================
        // DATABASE
        // =========================================================

        Connection connection = null;

        try {

            connection =
                    DBConnection.getConnection();

            connection.setAutoCommit(false);


            int tourId;
            boolean wasCover;


            // =====================================================
            // FIND IMAGE
            // =====================================================

            try (PreparedStatement statement =
                         connection.prepareStatement(
                                 findImageSQL)) {

                statement.setInt(
                        1,
                        imageId
                );

                try (ResultSet resultSet =
                             statement.executeQuery()) {

                    if (!resultSet.next()) {

                        connection.rollback();

                        redirectWithMessage(
                                request,
                                response,
                                "Image not found"
                        );

                        return;
                    }


                    tourId =
                            resultSet.getInt(
                                    "tour_id"
                            );


                    wasCover =
                            resultSet.getBoolean(
                                    "is_cover"
                            );
                }
            }


            // =====================================================
            // DELETE IMAGE
            // =====================================================

            try (PreparedStatement statement =
                         connection.prepareStatement(
                                 deleteImageSQL)) {

                statement.setInt(
                        1,
                        imageId
                );

                int deletedRows =
                        statement.executeUpdate();


                if (deletedRows == 0) {

                    connection.rollback();

                    redirectWithMessage(
                            request,
                            response,
                            "Image could not be deleted"
                    );

                    return;
                }
            }


            // =====================================================
            // IF DELETED IMAGE WAS COVER
            // FIND REPLACEMENT
            // =====================================================

            if (wasCover) {

                Integer replacementImageId =
                        null;


                try (PreparedStatement statement =
                             connection.prepareStatement(
                                     findReplacementSQL)) {

                    statement.setInt(
                            1,
                            tourId
                    );


                    try (ResultSet resultSet =
                                 statement.executeQuery()) {

                        if (resultSet.next()) {

                            replacementImageId =
                                    resultSet.getInt(
                                            "id"
                                    );
                        }
                    }
                }


                // =================================================
                // MAKE REPLACEMENT COVER
                // =================================================

                if (replacementImageId != null) {

                    try (PreparedStatement statement =
                                 connection.prepareStatement(
                                         makeReplacementCoverSQL)) {

                        statement.setInt(
                                1,
                                replacementImageId
                        );

                        statement.executeUpdate();
                    }
                }
            }


            // =====================================================
            // COMMIT
            // =====================================================

            connection.commit();


            redirectWithMessage(
                    request,
                    response,
                    "Image deleted successfully"
            );


        } catch (Exception e) {

            e.printStackTrace();


            // =====================================================
            // ROLLBACK
            // =====================================================

            if (connection != null) {

                try {

                    connection.rollback();

                } catch (Exception rollbackException) {

                    rollbackException.printStackTrace();
                }
            }


            redirectWithMessage(
                    request,
                    response,
                    "Error deleting image"
            );


        } finally {

            // =====================================================
            // RESTORE AUTOCOMMIT
            // =====================================================

            if (connection != null) {

                try {

                    connection.setAutoCommit(true);

                } catch (Exception e) {

                    e.printStackTrace();
                }


                try {

                    connection.close();

                } catch (Exception e) {

                    e.printStackTrace();
                }
            }
        }
    }


    // =============================================================
    // REDIRECT WITH MESSAGE
    // =============================================================

    private void redirectWithMessage(
            HttpServletRequest request,
            HttpServletResponse response,
            String message)
            throws IOException {

        String encodedMessage =
                URLEncoder.encode(
                        message,
                        StandardCharsets.UTF_8
                );


        response.sendRedirect(
                request.getContextPath()
                        + "/admin/manage-tour-images.jsp?message="
                        + encodedMessage
        );
    }
}