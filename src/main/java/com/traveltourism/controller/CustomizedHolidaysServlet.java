package com.traveltourism.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import com.traveltourism.model.HolidayDataAccess;
import com.traveltourism.model.HolidayPackage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/customize")
public class CustomizedHolidaysServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int duration, budget;
        try {
            duration = number(request.getParameter("duration"), 0);
            budget = number(request.getParameter("budget"), 0);
        } catch (NumberFormatException ex) {
            response.sendError(400, "Choose a valid duration and a non-negative budget.");
            return;
        }
        request.setAttribute("selectedDuration", duration);
        request.setAttribute("selectedBudget", budget == 0 ? "" : budget);
        request.setAttribute("holidaysLoaded", true);
        try {
            List<HolidayPackage> available = new HolidayDataAccess().getAvailable();
            String occasion = request.getParameter("occasion"), city = request.getParameter("city");
            List<HolidayPackage> holidays = available.stream()
                .filter(p -> occasion == null || occasion.isBlank() || p.getOccasion().equals(occasion))
                .filter(p -> city == null || city.isBlank() || p.getDepartureCity().equals(city))
                .filter(p -> duration == 0 || p.getDuration() == duration)
                .filter(p -> budget == 0 || p.getPrice() <= budget).toList();
            request.setAttribute("durations", available.stream().map(HolidayPackage::getDuration).distinct().sorted().toList());
            request.setAttribute("holidays", holidays);
            request.setAttribute("resultCount", holidays.size());
            request.setAttribute("occasions", available.stream().map(HolidayPackage::getOccasion).distinct().sorted().toList());
            request.setAttribute("cities", available.stream().map(HolidayPackage::getDepartureCity).distinct().sorted().toList());
        } catch (SQLException ex) {
            log("Could not load customized holidays", ex);
            response.setStatus(503);
            request.setAttribute("loadError", true);
        }
        request.getRequestDispatcher("/customized.jsp").forward(request, response);
    }

    private int number(String value, int fallback) {
        if (value == null || value.isBlank()) return fallback;
        int parsed = Integer.parseInt(value);
        if (parsed < 0) throw new NumberFormatException();
        return parsed;
    }
}
