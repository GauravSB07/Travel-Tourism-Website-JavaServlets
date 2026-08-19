package com.traveltourism.controller;

import java.io.IOException;
import com.traveltourism.model.Tour;
import com.traveltourism.model.TourDataAccess;
import com.traveltourism.model.TourDetails;
import com.traveltourism.model.TourImages;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/tour-details")
public class TourDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        TourDataAccess dao = new TourDataAccess();

        Tour tour = dao.getTourById(id);
        TourDetails details = dao.getTourDetailsById(id);
        java.util.List<TourImages> images = dao.getTourImagesById(id);

        request.setAttribute("tour", tour);
        request.setAttribute("details", details);
        request.setAttribute("images", images);

        RequestDispatcher rd = request.getRequestDispatcher("/tour_details.jsp");
        rd.forward(request, response);
    }
}
