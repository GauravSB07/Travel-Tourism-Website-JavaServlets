package com.traveltourism.controller;

import com.traveltourism.model.SearchDataAccess;
import com.traveltourism.model.Tour;
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

    private SearchDataAccess searchDataAccess;

    @Override
    public void init() throws ServletException {
        searchDataAccess = new SearchDataAccess();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
            
        String query = request.getParameter("query");
        if (query == null || query.trim().isEmpty()) {
            request.setAttribute("aiResults", new ArrayList<>());
            request.setAttribute("normalResults", new ArrayList<>());
            request.getRequestDispatcher("/search.jsp").forward(request, response);
            return;
        }
        
        query = query.trim();
        request.setAttribute("searchQuery", query);
        
        // 1. Get Normal Fuzzy Results
        List<Tour> normalResults = searchDataAccess.getFuzzyResults(query, null);
        
        // Extract IDs to exclude from semantic results
        List<Integer> excludeIds = new ArrayList<>();
        for (Tour t : normalResults) {
            excludeIds.add(t.getId());
        }
        
        // 2. Get Top 3 Semantic Results (excluding exactly matched titles)
        List<Tour> aiResults = searchDataAccess.getSemanticResults(query, 3, excludeIds);
        
        request.setAttribute("aiResults", aiResults);
        request.setAttribute("normalResults", normalResults);
        
        request.getRequestDispatcher("/search.jsp").forward(request, response);
    }
}
