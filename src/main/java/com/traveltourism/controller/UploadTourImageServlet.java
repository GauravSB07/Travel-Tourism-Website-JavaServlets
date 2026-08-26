package com.traveltourism.controller;

import com.traveltourism.model.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/upload-tour-image")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 10 * 1024 * 1024,
        maxRequestSize = 12 * 1024 * 1024
)
public class UploadTourImageServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // ==========================================
        // GET FORM DATA
        // ==========================================

        String tourIdParameter =
                request.getParameter("tourId");

        Part imagePart =
                request.getPart("image");

        boolean isCover =
                "true".equals(request.getParameter("isCover"));

        // ==========================================
        // VALIDATE TOUR ID
        // ==========================================

        if (tourIdParameter == null ||
                tourIdParameter.trim().isEmpty()) {

            redirectWithMessage(
                    request,
                    response,
                    "Tour ID is required"
            );

            return;
        }

        int tourId;

        try {

            tourId =
                    Integer.parseInt(tourIdParameter);

        } catch (NumberFormatException e) {

            redirectWithMessage(
                    request,
                    response,
                    "Invalid Tour ID"
            );

            return;
        }

        // ==========================================
        // VALIDATE IMAGE
        // ==========================================

        if (imagePart == null ||
                imagePart.getSize() == 0) {

            redirectWithMessage(
                    request,
                    response,
                    "Please select an image"
            );

            return;
        }

        String fileName =
                imagePart.getSubmittedFileName();

        String mimeType =
                imagePart.getContentType();

        if (!isAllowedImageType(mimeType)) {

            redirectWithMessage(
                    request,
                    response,
                    "Only JPG, PNG, WEBP and GIF images are allowed"
            );

            return;
        }

        // ==========================================
        // SQL
        // ==========================================

        String checkTourSQL =
                "SELECT id FROM tours WHERE id = ?";

        String removeOldCoverSQL =
                "UPDATE tour_images " +
                "SET is_cover = FALSE " +
                "WHERE tour_id = ?";

        String insertImageSQL =
                "INSERT INTO tour_images " +
                "(tour_id, image_data, mime_type, original_name, is_cover) " +
                "VALUES (?, ?, ?, ?, ?)";

        // ==========================================
        // DATABASE
        // ==========================================

        try (Connection connection =
                     DBConnection.getConnection()) {

            // ======================================
            // CHECK WHETHER TOUR EXISTS
            // ======================================

            try (PreparedStatement statement =
                         connection.prepareStatement(
                                 checkTourSQL)) {

                statement.setInt(1, tourId);

                try (ResultSet resultSet =
                             statement.executeQuery()) {

                    if (!resultSet.next()) {

                        redirectWithMessage(
                                request,
                                response,
                                "Tour does not exist"
                        );

                        return;
                    }
                }
            }

            // ======================================
            // MAKE OLD COVER FALSE
            // ======================================

            if (isCover) {

                try (PreparedStatement statement =
                             connection.prepareStatement(
                                     removeOldCoverSQL)) {

                    statement.setInt(1, tourId);

                    statement.executeUpdate();
                }
            }

            // ======================================
            // INSERT IMAGE
            // ======================================

            try (PreparedStatement statement =
                         connection.prepareStatement(
                                 insertImageSQL);
                 InputStream inputStream =
                         imagePart.getInputStream()) {

                statement.setInt(
                        1,
                        tourId
                );

                statement.setBinaryStream(
                        2,
                        inputStream,
                        imagePart.getSize()
                );

                statement.setString(
                        3,
                        mimeType
                );

                statement.setString(
                        4,
                        fileName
                );

                statement.setBoolean(
                        5,
                        isCover
                );

                statement.executeUpdate();
            }

            // ======================================
            // SUCCESS
            // ======================================

            redirectWithMessage(
                    request,
                    response,
                    "Image uploaded successfully"
            );

        } catch (Exception e) {

            e.printStackTrace();

            redirectWithMessage(
                    request,
                    response,
                    "Error uploading image"
            );
        }
    }

    // ==========================================
    // CHECK ALLOWED IMAGE TYPES
    // ==========================================

    private boolean isAllowedImageType(
            String mimeType) {

        if (mimeType == null) {
            return false;
        }

        return mimeType.equals("image/jpeg")
                || mimeType.equals("image/png")
                || mimeType.equals("image/webp")
                || mimeType.equals("image/gif");
    }

    // ==========================================
    // REDIRECT WITH MESSAGE
    // ==========================================

    private void redirectWithMessage(
            HttpServletRequest request,
            HttpServletResponse response,
            String message)
            throws IOException {

        response.sendRedirect(
                request.getContextPath()
                        + "/admin/upload-tour-image.jsp?message="
                        + URLEncoder.encode(
                                message,
                                StandardCharsets.UTF_8
                        )
        );
    }
}