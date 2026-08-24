package com.traveltourism.controller;

import com.traveltourism.model.Tour;
import com.traveltourism.model.TourDataAccess;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/destinations")
public class DestinationsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Fetch all tours from database
        TourDataAccess dao = new TourDataAccess();
        List<Tour> tours = dao.get_all_tours();

        // Read filters from JSP like city, category, price, range, duration
        String city = request.getParameter("city");
        String category = request.getParameter("category");
        String place = request.getParameter("place");

        String price_min_str = request.getParameter("price_min");
        String price_max_str = request.getParameter("price_max");

        String duration_str = request.getParameter("duration");

        int price_min;
        int price_max;
        int duration;

        try {
            price_min = parseNonNegativeInt(price_min_str, 0);
            price_max = parseNonNegativeInt(price_max_str, Integer.MAX_VALUE);
            duration = parseNonNegativeInt(duration_str, 0);
        } catch (NumberFormatException exception) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Filter values must be valid non-negative numbers.");
            return;
        }

        if (price_min > price_max) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Minimum price cannot exceed maximum price.");
            return;
        }

        // Apply backend filtering to sensure filter works even if javascript is not enabled
        List<Tour> filtered_list = new ArrayList<>();

        for (Tour t : tours) {

            boolean match_city = (city == null || city.equals("all")
                    || t.getDepartureCity().equalsIgnoreCase(city));

            boolean match_category = (category == null || category.equals("all")
                    || t.getCategory().equalsIgnoreCase(category));

            boolean match_price = (t.getPrice() >= price_min && t.getPrice() <= price_max);

            boolean match_duration = (duration == 0 || t.getDuration() == duration);

            boolean match_place = (place == null || place.isBlank()
                    || t.getName().toLowerCase().contains(place.toLowerCase())
                    || t.getCategory().toLowerCase().contains(place.toLowerCase())
                    || t.getDepartureCity().toLowerCase().contains(place.toLowerCase()));

            if (match_city && match_category && match_price && match_duration && match_place) {
                filtered_list.add(t);
            }
        }

        // Send filtered tours to JSP
        request.setAttribute("tours", filtered_list);
        request.setAttribute("resultCount", filtered_list.size());

        // Forward to JSP
        request.getRequestDispatcher("/destinations.jsp").forward(request, response);
    }

    private int parseNonNegativeInt(String value, int defaultValue) {
        if (value == null || value.isBlank()) {
            return defaultValue;
        }

        int parsedValue = Integer.parseInt(value);
        if (parsedValue < 0) {
            throw new NumberFormatException("Negative numbers are not allowed.");
        }
        return parsedValue;
    }
}
