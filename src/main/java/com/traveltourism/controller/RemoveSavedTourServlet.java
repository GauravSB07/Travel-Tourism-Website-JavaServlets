package com.traveltourism.controller;

import com.traveltourism.model.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/remove-saved-tour")
public class RemoveSavedTourServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);


        if (session == null
                || !Boolean.TRUE.equals(
                        session.getAttribute(
                                "userLoggedIn"
                        )
                )) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp"
            );

            return;
        }


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
                    + "/saved-tours"
            );

            return;
        }


        if (!"destination".equals(tourType)
                && !"holiday".equals(tourType)) {

            tourType =
                    "destination";
        }


        if (returnUrl == null
                || returnUrl.isBlank()
                || !returnUrl.startsWith("/")) {

            returnUrl =
                    "/saved-tours";
        }


        try {

            long userId =
                    Long.parseLong(
                            session.getAttribute(
                                    "userId"
                            ).toString()
                    );


            String sql = """
                    DELETE FROM saved_tours
                    WHERE user_id = ?
                    AND tour_id = ?
                    AND tour_type = ?
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
                    "Unable to remove saved tour.",
                    e
            );
        }
    }
}