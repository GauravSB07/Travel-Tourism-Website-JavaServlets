package com.traveltourism.controller;

import com.traveltourism.model.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(urlPatterns = {"/ExperienceImageServlet", "/experience-image"})
public class ExperienceImageServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String idParameter = request.getParameter("id");

        if (idParameter == null || idParameter.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Experience ID is required");
            return;
        }

        int imageId;
        try {
            imageId = Integer.parseInt(idParameter.trim());
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid experience ID");
            return;
        }

        String sql = "SELECT image_data, mime_type FROM experiences WHERE id = ?";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)
        ) {
            statement.setInt(1, imageId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (!resultSet.next()) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found");
                    return;
                }

                String mimeType = resultSet.getString("mime_type");
                if (mimeType == null || mimeType.trim().isEmpty()) {
                    mimeType = "image/jpeg";
                }

                byte[] imageData = resultSet.getBytes("image_data");
                if (imageData == null || imageData.length == 0) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image data is empty");
                    return;
                }

                response.setContentType(mimeType);
                response.setContentLength(imageData.length);
                response.setHeader("Cache-Control", "public, max-age=86400");

                try (OutputStream outputStream = response.getOutputStream()) {
                    outputStream.write(imageData);
                    outputStream.flush();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            if (!response.isCommitted()) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load image");
            }
        }
    }
}
