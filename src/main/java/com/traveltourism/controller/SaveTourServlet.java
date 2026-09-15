package com.traveltourism.controller;

import com.traveltourism.model.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/save-tour")
public class SaveTourServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String tourId =
                request.getParameter("tour_id");

        String tourType =
                request.getParameter("tour_type");

        String returnUrl =
                request.getParameter("return_url");


        if (tourId == null
                || tourId.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/destinations"
            );

            return;
        }


        tourId =
                tourId.trim();


        if (!"destination".equals(tourType)
                && !"holiday".equals(tourType)) {

            tourType =
                    "destination";
        }


        if (returnUrl == null
                || returnUrl.isBlank()
                || !returnUrl.startsWith("/")) {

            returnUrl =
                    "holiday".equals(tourType)
                    ? "/customize"
                    : "/destinations";
        }


        // =========================================================
        // LOGIN CHECK
        // =========================================================

        HttpSession session =
                request.getSession(false);


        if (session == null
                || !Boolean.TRUE.equals(
                        session.getAttribute(
                                "userLoggedIn"
                        )
                )) {

            String redirect =
                    "/save-tour"
                    + "?tour_id="
                    + URLEncoder.encode(
                            tourId,
                            StandardCharsets.UTF_8
                    )
                    + "&tour_type="
                    + URLEncoder.encode(
                            tourType,
                            StandardCharsets.UTF_8
                    )
                    + "&return_url="
                    + URLEncoder.encode(
                            returnUrl,
                            StandardCharsets.UTF_8
                    );


            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?redirect="
                    + URLEncoder.encode(
                            redirect,
                            StandardCharsets.UTF_8
                    )
            );

            return;
        }


        Object userIdObject =
                session.getAttribute("userId");


        if (userIdObject == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp"
            );

            return;
        }


        try {

            long userId =
                    Long.parseLong(
                            userIdObject.toString()
                    );


            String sql = """
                    INSERT INTO saved_tours
                    (
                        user_id,
                        tour_id,
                        tour_type
                    )
                    VALUES (?, ?, ?)
                    ON DUPLICATE KEY UPDATE
                        created_at = created_at
                    """;


            try (
                    Connection con =
                            DBConnection.getConnection();

                    PreparedStatement ps =
                            con.prepareStatement(sql)
            ) {

                ps.setLong(1, userId);
                ps.setString(2, tourId);
                ps.setString(3, tourType);

                ps.executeUpdate();
            }


            response.sendRedirect(
                    request.getContextPath()
                    + returnUrl
            );


        } catch (Exception e) {

            throw new ServletException(
                    "Unable to save tour.",
                    e
            );
        }
    }
}