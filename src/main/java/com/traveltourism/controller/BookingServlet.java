package com.traveltourism.controller;

import java.io.IOException;

import com.traveltourism.model.Tour;
import com.traveltourism.model.TourDataAccess;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
	@Override
	protected void doGet(HttpServletRequest request, 
			HttpServletResponse response) 
					throws ServletException, IOException {
		
		String tourId = request.getParameter("tour_id");
		if (tourId != null && !tourId.isBlank()) {
			try {
				Tour tour = new TourDataAccess().getTourById(Integer.parseInt(tourId));
				if (tour != null) {
					request.setAttribute("tour", tour);
				}
			} catch (NumberFormatException ignored) {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "A valid tour id is required.");
				return;
			}
		}

		RequestDispatcher rd = 
				request.getRequestDispatcher("/booking.jsp");
		
		rd.forward(request, response);
	}
}
