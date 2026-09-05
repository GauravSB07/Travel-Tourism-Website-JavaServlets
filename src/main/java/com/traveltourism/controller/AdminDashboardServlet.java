package com.traveltourism.controller;

import com.traveltourism.model.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.LinkedHashMap;
import java.util.Map;

@WebServlet(urlPatterns = {"/admin", "/admin/"})
public class AdminDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Map<String, Integer> stats = emptyStats();
        try (Connection connection = DBConnection.getConnection()) {
            stats.put("tours", count(connection, "SELECT COUNT(*) FROM tours"));
            stats.put("activeTours", count(connection, "SELECT COUNT(*) FROM tours WHERE status='active'"));
            stats.put("holidays", count(connection, "SELECT COUNT(*) FROM holiday_packages"));
            stats.put("activeHolidays", count(connection, "SELECT COUNT(*) FROM holiday_packages WHERE active=TRUE"));
            stats.put("pendingBookings", count(connection, "SELECT COUNT(*) FROM booking_requests WHERE archived=FALSE AND status='pending'"));
            stats.put("openBookings", count(connection, "SELECT COUNT(*) FROM booking_requests WHERE archived=FALSE AND status IN('pending','reviewing')"));
            stats.put("newEnquiries", count(connection, "SELECT COUNT(*) FROM contact_enquiries WHERE archived=FALSE AND status='new'"));
            stats.put("openEnquiries", count(connection, "SELECT COUNT(*) FROM contact_enquiries WHERE archived=FALSE AND status IN('new','in_progress')"));
            stats.put("homePhotos", count(connection, "SELECT COUNT(*) FROM homepage_images"));
        } catch (Exception exception) {
            log("Admin dashboard statistics could not be loaded", exception);
        }
        request.setAttribute("stats", stats);
        request.getRequestDispatcher("/WEB-INF/admin/dashboard.jsp").forward(request, response);
    }

    private Map<String, Integer> emptyStats() {
        Map<String, Integer> stats = new LinkedHashMap<>();
        for (String key : new String[]{"tours", "activeTours", "holidays", "activeHolidays",
                "pendingBookings", "openBookings", "newEnquiries", "openEnquiries", "homePhotos"}) {
            stats.put(key, 0);
        }
        return stats;
    }

    private int count(Connection connection, String sql) {
        if (connection == null) return 0;
        try (PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet results = statement.executeQuery()) {
            return results.next() ? results.getInt(1) : 0;
        } catch (Exception exception) {
            return 0;
        }
    }
}
