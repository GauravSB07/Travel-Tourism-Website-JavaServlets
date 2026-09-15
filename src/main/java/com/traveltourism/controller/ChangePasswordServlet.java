package com.traveltourism.controller;

import com.traveltourism.model.DBConnection;
import com.traveltourism.model.PasswordUtil;

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

@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = requireUser(request, response);
        if (session == null) return;

        if (session.getAttribute("passwordCsrfToken") == null) {
            session.setAttribute("passwordCsrfToken", UUID.randomUUID().toString());
        }

        request.getRequestDispatcher("/WEB-INF/user/change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = requireUser(request, response);
        if (session == null) return;

        String submittedToken = request.getParameter("csrfToken");
        String sessionToken = (String) session.getAttribute("passwordCsrfToken");

        if (sessionToken == null || submittedToken == null || !sessionToken.equals(submittedToken)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Your password form has expired. Please try again.");
            return;
        }

        long userId;
        try {
            userId = Long.parseLong(String.valueOf(session.getAttribute("userId")));
        } catch (Exception ex) {
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/login.jsp?redirect=/change-password");
            return;
        }

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (currentPassword == null || newPassword == null || confirmPassword == null
                || currentPassword.isBlank() || newPassword.isBlank() || confirmPassword.isBlank()) {
            request.setAttribute("error", "Please fill in all password fields.");
            forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "New password and confirm password do not match.");
            forward(request, response);
            return;
        }

        if (newPassword.length() < 8
                || !newPassword.matches(".*[A-Z].*")
                || !newPassword.matches(".*[a-z].*")
                || !newPassword.matches(".*[0-9].*")
                || !newPassword.matches(".*[^A-Za-z0-9].*")) {
            request.setAttribute("error",
                    "Password must contain at least 8 characters, one uppercase letter, one lowercase letter, one number, and one special character.");
            forward(request, response);
            return;
        }

        if (currentPassword.equals(newPassword)) {
            request.setAttribute("error", "Your new password must be different from your current password.");
            forward(request, response);
            return;
        }

        try (Connection connection = DBConnection.getConnection()) {
            if (connection == null) {
                request.setAttribute("error", "Database connection failed. Please try again later.");
                forward(request, response);
                return;
            }

            String selectSql = "SELECT password FROM users WHERE user_id=?";
            String storedHash;

            try (PreparedStatement select = connection.prepareStatement(selectSql)) {
                select.setLong(1, userId);
                try (ResultSet result = select.executeQuery()) {
                    if (!result.next()) {
                        session.invalidate();
                        response.sendRedirect(request.getContextPath() + "/login.jsp?redirect=/change-password");
                        return;
                    }
                    storedHash = result.getString("password");
                }
            }

            if (!PasswordUtil.checkPassword(currentPassword, storedHash)) {
                request.setAttribute("error", "Your current password is incorrect.");
                forward(request, response);
                return;
            }

            String newHash = PasswordUtil.hashPassword(newPassword);
            String updateSql = "UPDATE users SET password=? WHERE user_id=?";

            try (PreparedStatement update = connection.prepareStatement(updateSql)) {
                update.setString(1, newHash);
                update.setLong(2, userId);
                update.executeUpdate();
            }

            session.setAttribute("passwordNotice", "Your password has been changed successfully.");
            session.setAttribute("passwordCsrfToken", UUID.randomUUID().toString());
            response.sendRedirect(request.getContextPath() + "/user-dashboard");

        } catch (Exception ex) {
            log("Password change failed", ex);
            request.setAttribute("error", "We could not change your password. Please try again.");
            forward(request, response);
        }
    }

    private HttpSession requireUser(HttpServletRequest request,
            HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !Boolean.TRUE.equals(session.getAttribute("userLoggedIn"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?redirect=/change-password");
            return null;
        }
        return session;
    }

    private void forward(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/user/change-password.jsp").forward(request, response);
    }
}
