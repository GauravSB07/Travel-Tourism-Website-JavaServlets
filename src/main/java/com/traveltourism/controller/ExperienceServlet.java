package com.traveltourism.controller;

import com.traveltourism.model.Experience;
import com.traveltourism.model.ExperienceDataAccess;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/experiences")
public class ExperienceServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
        throws ServletException, IOException {

        ExperienceDataAccess dao = new ExperienceDataAccess();
        List<Experience> experiences = dao.getAllExperiences();

        request.setAttribute("experiences", experiences);
        request.setAttribute("resultCount", experiences.size());

        RequestDispatcher rd =
                request.getRequestDispatcher("/experience.jsp");

        rd.forward(request, response);
    }
}
