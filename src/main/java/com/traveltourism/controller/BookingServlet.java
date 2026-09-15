package com.traveltourism.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.UUID;

import com.traveltourism.model.BookingSelection;
import com.traveltourism.model.HolidayDataAccess;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        /* =====================================================
           CHECK USER LOGIN FIRST
           ===================================================== */

        HttpSession session = request.getSession(false);

        boolean loggedIn = session != null
                && Boolean.TRUE.equals(
                        session.getAttribute("userLoggedIn")
                );

        if (!loggedIn) {

            String holidayId = request.getParameter("holiday_id");
            String tourId = request.getParameter("tour_id");

            String redirectPath = "/booking";

            if (holidayId != null && !holidayId.isBlank()) {

                redirectPath += "?holiday_id="
                        + URLEncoder.encode(
                                holidayId,
                                StandardCharsets.UTF_8
                        );

            } else if (tourId != null && !tourId.isBlank()) {

                redirectPath += "?tour_id="
                        + URLEncoder.encode(
                                tourId,
                                StandardCharsets.UTF_8
                        );
            }

            String loginUrl =
                    request.getContextPath()
                    + "/login.jsp?redirect="
                    + URLEncoder.encode(
                            redirectPath,
                            StandardCharsets.UTF_8
                    );

            response.sendRedirect(loginUrl);
            return;
        }


        /* =====================================================
           GET SELECTED PACKAGE
           ===================================================== */

        String holidayId = request.getParameter("holiday_id");
        String tourId = request.getParameter("tour_id");


        if ((holidayId == null || holidayId.isBlank())
                && (tourId == null || tourId.isBlank())) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/destinations"
            );

            return;
        }


        /* =====================================================
           LOAD BOOKING SELECTION
           ===================================================== */

        try {

            request.setAttribute(
                    "selection",
                    BookingSelection.load(
                            holidayId,
                            tourId
                    )
            );

        } catch (IllegalArgumentException ex) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    ex.getMessage()
            );

            return;

        } catch (SQLException ex) {

            log(
                    "Unable to load booking package",
                    ex
            );

            response.sendError(
                    HttpServletResponse.SC_SERVICE_UNAVAILABLE,
                    "Packages are temporarily unavailable. Please try again shortly."
            );

            return;
        }


        /* =====================================================
           CREATE BOOKING TOKEN
           ===================================================== */

        if (session.getAttribute("bookingToken") == null) {

            session.setAttribute(
                    "bookingToken",
                    UUID.randomUUID().toString()
            );
        }


        /* =====================================================
           LOAD TODAY'S DATE
           ===================================================== */

        request.setAttribute(
                "today",
                HolidayDataAccess.today()
        );


        /* =====================================================
           OPEN BOOKING PAGE
           ===================================================== */

        request.getRequestDispatcher(
                "/booking.jsp"
        ).forward(
                request,
                response
        );
    }
}