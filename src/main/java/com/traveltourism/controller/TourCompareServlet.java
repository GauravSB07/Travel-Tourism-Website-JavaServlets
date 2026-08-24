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

@WebServlet("/compare-tours")
public class TourCompareServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Tour> selectedTours = new ArrayList<>();
        String ids = request.getParameter("ids");
        TourDataAccess dao = new TourDataAccess();

        if (ids != null) {
            for (String value : ids.split(",")) {
                try {
                    Tour tour = dao.getTourById(Integer.parseInt(value.trim()));
                    if (tour != null) {
                        selectedTours.add(tour);
                    }
                } catch (NumberFormatException ignored) {
                    // Ignore malformed ids and render any valid selections.
                }
            }
        }

        request.setAttribute("tours", selectedTours);
        request.getRequestDispatcher("/compare_tours.jsp").forward(request, response);
    }
}
