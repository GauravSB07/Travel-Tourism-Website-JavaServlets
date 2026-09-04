package com.traveltourism.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.UUID;
import com.traveltourism.model.BookingSelection;
import com.traveltourism.model.HolidayDataAccess;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String holidayId = request.getParameter("holiday_id"), tourId = request.getParameter("tour_id");
        if ((holidayId == null || holidayId.isBlank()) && (tourId == null || tourId.isBlank())) {
            response.sendRedirect(request.getContextPath() + "/destinations");
            return;
        }
        try {
            request.setAttribute("selection", BookingSelection.load(holidayId, tourId));
        } catch (IllegalArgumentException ex) {
            response.sendError(400, ex.getMessage());
            return;
        } catch (SQLException ex) {
            log("Unable to load booking package", ex);
            response.sendError(503, "Packages are temporarily unavailable. Please try again shortly.");
            return;
        }
        HttpSession session = request.getSession();
        if (session.getAttribute("bookingToken") == null)
            session.setAttribute("bookingToken", UUID.randomUUID().toString());
        request.setAttribute("today", HolidayDataAccess.today());
        request.getRequestDispatcher("/booking.jsp").forward(request, response);
    }
}
