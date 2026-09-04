package com.traveltourism.controller;

import java.io.IOException;
import java.sql.SQLException;
import com.traveltourism.model.HolidayDataAccess;
import com.traveltourism.model.HolidayPackage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/holiday-details")
public class HolidayDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id == null || id.isBlank() || id.length() > 80) {
            response.sendError(400, "Please select a holiday to view its details.");
            return;
        }
        try {
            HolidayPackage holiday = new HolidayDataAccess().findAvailable(id);
            if (holiday == null) {
                response.sendError(404, "This holiday is no longer available.");
                return;
            }
            request.setAttribute("holiday", holiday);
            request.setAttribute("gallery", com.traveltourism.model.HolidayGallery.load(id));
            request.getRequestDispatcher("/holiday_details.jsp").forward(request, response);
        } catch (SQLException ex) {
            log("Could not load holiday details", ex);
            response.sendError(503, "Holiday details are temporarily unavailable. Please try again shortly.");
        }
    }
}
