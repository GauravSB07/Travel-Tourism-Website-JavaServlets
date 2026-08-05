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


@WebServlet("/DestinationsServlet")
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

        String price_min_str = request.getParameter("price_min");
        String price_max_str = request.getParameter("price_max");

        String duration_str = request.getParameter("duration");

        int price_min = (price_min_str != null && !price_min_str.isEmpty())
                ? Integer.parseInt(price_min_str) : 0;

        int price_max = (price_max_str != null && !price_max_str.isEmpty())
                ? Integer.parseInt(price_max_str) : Integer.MAX_VALUE;

        int duration = (duration_str != null && !duration_str.isEmpty())
                ? Integer.parseInt(duration_str) : 0;

        // Apply backend filtering to sensure filter works even if javascript is not enabled
        List<Tour> filtered_list = new ArrayList<>();

        for (Tour t : tours) {

            boolean match_city = (city == null || city.equals("all")
                    || t.getDepartureCity().equalsIgnoreCase(city));

            boolean match_category = (category == null || category.equals("all")
                    || t.getCategory().equalsIgnoreCase(category));

            boolean match_price = (t.getPrice() >= price_min && t.getPrice() <= price_max);

            boolean match_duration = (duration == 0 || t.getDuration() == duration);

            if (match_city && match_category && match_price && match_duration) {
                filtered_list.add(t);
            }
        }

        // Send filtered tours to JSP
        request.setAttribute("tours", filtered_list);

        // Forward to JSP
        request.getRequestDispatcher("/destinations.jsp").forward(request, response);
    }
}