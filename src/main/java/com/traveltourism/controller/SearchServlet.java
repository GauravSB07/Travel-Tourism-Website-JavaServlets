package com.traveltourism.controller;

import com.traveltourism.model.HolidayDataAccess;
import com.traveltourism.model.HolidayPackage;
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

        TourDataAccess tourDao = new TourDataAccess();
        List<Tour> allTours = tourDao.get_all_tours();

        List<Tour> tourResults = new ArrayList<>();

        String lowerQuery = query.toLowerCase();

        if (!lowerQuery.isEmpty()) {
            for (Tour t : allTours) {
                boolean matchName = t.getName() != null && t.getName().toLowerCase().contains(lowerQuery);
                boolean matchDestination = t.getDepartureCity() != null && t.getDepartureCity().toLowerCase().contains(lowerQuery);

                if (matchName || matchDestination) {
                    tourResults.add(t);
                }
            }
        }

        // Also search customized holidays
        List<HolidayPackage> holidayResults = new ArrayList<>();
        try {
            List<HolidayPackage> allHolidays = new HolidayDataAccess().getAvailable();
            if (!lowerQuery.isEmpty()) {
                for (HolidayPackage h : allHolidays) {
                    boolean matchName = h.getName() != null && h.getName().toLowerCase().contains(lowerQuery);
                    boolean matchCity = h.getDepartureCity() != null && h.getDepartureCity().toLowerCase().contains(lowerQuery);

                    if (matchName || matchCity) {
                        holidayResults.add(h);
                    }
                }
            }
        } catch (Exception e) {
            // Holiday search failure should not break tour results
            e.printStackTrace();
        }

        request.setAttribute("tours", tourResults);
        request.setAttribute("holidays", holidayResults);
        request.setAttribute("resultCount", tourResults.size() + holidayResults.size());
        request.setAttribute("query", query);

        request.getRequestDispatcher("/search.jsp").forward(request, response);
    }
}
