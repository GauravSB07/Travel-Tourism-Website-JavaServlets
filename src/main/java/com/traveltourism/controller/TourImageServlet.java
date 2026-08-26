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

@WebServlet("/TourImageServlet")
public class TourImageServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String idParameter =
                request.getParameter("id");

        // -----------------------------------------------------
        // CHECK IMAGE ID
        // -----------------------------------------------------

        if (idParameter == null ||
                idParameter.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Image ID is required"
            );

            return;
        }

        int imageId;

        try {

            imageId =
                    Integer.parseInt(idParameter);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid image ID"
            );

            return;
        }


        // -----------------------------------------------------
        // SQL
        // -----------------------------------------------------

        String sql =
                "SELECT image_data, mime_type " +
                "FROM tour_images " +
                "WHERE id = ?";


        // -----------------------------------------------------
        // DATABASE
        // -----------------------------------------------------

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, imageId);


            try (
                    ResultSet resultSet =
                            statement.executeQuery()
            ) {

                // -------------------------------------------------
                // IMAGE NOT FOUND
                // -------------------------------------------------

                if (!resultSet.next()) {

                    response.sendError(
                            HttpServletResponse.SC_NOT_FOUND,
                            "Image not found"
                    );

                    return;
                }


                // -------------------------------------------------
                // GET IMAGE
                // -------------------------------------------------

                String mimeType =
                        resultSet.getString("mime_type");

                byte[] imageData =
                        resultSet.getBytes("image_data");


                if (imageData == null ||
                        imageData.length == 0) {

                    response.sendError(
                            HttpServletResponse.SC_NOT_FOUND,
                            "Image data is empty"
                    );

                    return;
                }


                // -------------------------------------------------
                // SEND IMAGE TO BROWSER
                // -------------------------------------------------

                response.setContentType(mimeType);

                response.setContentLength(
                        imageData.length
                );

                response.setHeader(
                        "Cache-Control",
                        "public, max-age=86400"
                );


                try (
                        OutputStream outputStream =
                                response.getOutputStream()
                ) {

                    outputStream.write(imageData);

                    outputStream.flush();
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            if (!response.isCommitted()) {

                response.sendError(
                        HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                        "Unable to load image"
                );
            }
        }
    }
}