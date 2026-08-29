package com.traveltourism.controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/booking-confirmation")
public class BookingConfirmationServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
	@Override
	protected void doGet(HttpServletRequest request, 
			HttpServletResponse response) 
					throws ServletException, IOException {
		
		RequestDispatcher rd = 
				request.getRequestDispatcher("/booking_confirmation.jsp");
		
		rd.forward(request, response);
	}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("travelerName", request.getParameter("traveler_name"));
        request.setAttribute("tourName", request.getParameter("tour_name"));
        request.setAttribute("travelDate", request.getParameter("travel_date"));
        request.setAttribute("travelers", request.getParameter("travelers"));
        request.getRequestDispatcher("/booking_confirmation.jsp").forward(request, response);
    }
}
