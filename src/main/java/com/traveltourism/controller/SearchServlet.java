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

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String query = request.getParameter("query");
        if (query == null) {
            query = "";
        }

        TourDataAccess dao = new TourDataAccess();
        List<Tour> allTours = dao.get_all_tours();

        List<Tour> searchResults = new ArrayList<>();

        String lowerQuery = query.toLowerCase();

        for (Tour t : allTours) {
            boolean matchName = t.getName() != null && t.getName().toLowerCase().contains(lowerQuery);
            boolean matchDestination = t.getDepartureCity() != null && t.getDepartureCity().toLowerCase().contains(lowerQuery);
            
            if (matchName || matchDestination) {
                searchResults.add(t);
            }
        }

        request.setAttribute("tours", searchResults);
        request.setAttribute("resultCount", searchResults.size());
        request.setAttribute("query", query);

        request.getRequestDispatcher("/search.jsp").forward(request, response);
    }
}
