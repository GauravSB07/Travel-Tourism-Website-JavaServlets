package com.traveltourism.controller;

import com.traveltourism.model.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.UUID;

@WebServlet("/edit-profile")
public class EditProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = requireUser(request, response);
        if (session == null) return;

        String csrfToken = (String) session.getAttribute("profileCsrfToken");
        if (csrfToken == null) {
            csrfToken = UUID.randomUUID().toString();
            session.setAttribute("profileCsrfToken", csrfToken);
        }

        loadCurrentProfile(request, session);
        request.getRequestDispatcher("/WEB-INF/user/edit-profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = requireUser(request, response);
        if (session == null) return;

        String submittedToken = request.getParameter("csrfToken");
        String sessionToken = (String) session.getAttribute("profileCsrfToken");

        if (sessionToken == null || submittedToken == null || !sessionToken.equals(submittedToken)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Your profile form has expired. Please try again.");
            return;
        }

        long userId;
        try {
            userId = Long.parseLong(String.valueOf(session.getAttribute("userId")));
        } catch (Exception ex) {
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/login.jsp?redirect=/edit-profile");
            return;
        }

        String fullName = trim(request.getParameter("fullName"));
        String email = trim(request.getParameter("email")).toLowerCase();
        String phone = trim(request.getParameter("phone"));

        request.setAttribute("fullName", fullName);
        request.setAttribute("email", email);
        request.setAttribute("phone", phone);

        if (fullName.length() < 2 || fullName.length() > 100) {
            request.setAttribute("error", "Please enter a valid full name.");
            forward(request, response);
            return;
        }

        if (!email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            request.setAttribute("error", "Please enter a valid email address.");
            forward(request, response);
            return;
        }

        if (!phone.matches("(?=.*\\d)[+0-9() .-]{7,30}")) {
            request.setAttribute("error", "Please enter a valid phone number.");
            forward(request, response);
            return;
        }

        try (Connection connection = DBConnection.getConnection()) {
            if (connection == null) {
                request.setAttribute("error", "Database connection failed. Please try again later.");
                forward(request, response);
                return;
            }

            String duplicateSql = "SELECT user_id FROM users WHERE email=? AND user_id<>?";
            try (PreparedStatement check = connection.prepareStatement(duplicateSql)) {
                check.setString(1, email);
                check.setLong(2, userId);
                try (ResultSet result = check.executeQuery()) {
                    if (result.next()) {
                        request.setAttribute("error", "Another account already uses this email address.");
                        forward(request, response);
                        return;
                    }
                }
            }

            String updateSql = "UPDATE users SET full_name=?, email=?, phone=? WHERE user_id=?";
            try (PreparedStatement update = connection.prepareStatement(updateSql)) {
                update.setString(1, fullName);
                update.setString(2, email);
                update.setString(3, phone);
                update.setLong(4, userId);
                update.executeUpdate();
            }

            session.setAttribute("userName", fullName);
            session.setAttribute("userEmail", email);
            session.setAttribute("userPhone", phone);
            session.setAttribute("profileNotice", "Your profile has been updated successfully.");

            response.sendRedirect(request.getContextPath() + "/user-dashboard");

        } catch (Exception ex) {
            log("Profile update failed", ex);
            request.setAttribute("error", "We could not update your profile. Please try again.");
            forward(request, response);
        }
    }

    private HttpSession requireUser(HttpServletRequest request,
            HttpServletResponse response) throws IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !Boolean.TRUE.equals(session.getAttribute("userLoggedIn"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?redirect=/edit-profile");
            return null;
        }
        return session;
    }

    private void loadCurrentProfile(HttpServletRequest request, HttpSession session) {
        request.setAttribute("fullName", session.getAttribute("userName"));
        request.setAttribute("email", session.getAttribute("userEmail"));
        request.setAttribute("phone", session.getAttribute("userPhone"));
    }

    private void forward(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/user/edit-profile.jsp").forward(request, response);
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
