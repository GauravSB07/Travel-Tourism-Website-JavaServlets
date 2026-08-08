package com.traveltourism.controller;


import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/experiences")
public class ExperienceServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, 
			HttpServletResponse response) 
		throws ServletException, IOException {
		
		RequestDispatcher rd = 
				request.getRequestDispatcher("/experience.jsp");
		
		rd.forward(request, response);
		
	}
}
