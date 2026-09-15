/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.traveltourism.controller;

import com.traveltourism.model.DBConnection;
import com.traveltourism.model.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // =========================
        // GET FORM DATA
        // =========================

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // =========================
        // REQUIRED FIELD VALIDATION
        // =========================

        if (fullName == null || fullName.isBlank()
                || email == null || email.isBlank()
                || phone == null || phone.isBlank()
                || password == null || password.isBlank()
                || confirmPassword == null || confirmPassword.isBlank()) {

            request.setAttribute("error",
                    "Please fill in all the fields.");

            request.getRequestDispatcher("/register.jsp")
                    .forward(request, response);

            return;
        }

        // Remove unnecessary spaces
        fullName = fullName.trim();
        email = email.trim().toLowerCase();
        phone = phone.trim();

        // =========================
        // NAME VALIDATION
        // =========================

        if (fullName.length() < 2 || fullName.length() > 100) {

            request.setAttribute("error",
                    "Please enter a valid full name.");

            request.getRequestDispatcher("/register.jsp")
                    .forward(request, response);

            return;
        }

        // =========================
        // EMAIL VALIDATION
        // =========================

        if (!email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {

            request.setAttribute("error",
                    "Please enter a valid email address.");

            request.getRequestDispatcher("/register.jsp")
                    .forward(request, response);

            return;
        }

        // =========================
        // PHONE VALIDATION
        // =========================

        /*
         * Allows:
         * +91 9876543210
         * 9876543210
         * +1-123-456-7890
         * (022) 12345678
         *
         * Minimum 7 characters
         * Maximum 30 characters
         * At least one digit is required
         */

        if (!phone.matches("(?=.*\\d)[+0-9() .-]{7,30}")) {

            request.setAttribute("error",
                    "Please enter a valid phone number.");

            request.getRequestDispatcher("/register.jsp")
                    .forward(request, response);

            return;
        }

        // =========================
        // PASSWORD MATCH
        // =========================

        if (!password.equals(confirmPassword)) {

            request.setAttribute("error",
                    "Passwords do not match.");

            request.getRequestDispatcher("/register.jsp")
                    .forward(request, response);

            return;
        }

        // =========================
        // PASSWORD REQUIREMENTS
        // =========================

        if (password.length() < 8
                || !password.matches(".*[A-Z].*")
                || !password.matches(".*[a-z].*")
                || !password.matches(".*[0-9].*")
                || !password.matches(".*[^A-Za-z0-9].*")) {

            request.setAttribute("error",
                    "Password must contain at least 8 characters, "
                    + "one uppercase letter, one lowercase letter, "
                    + "one number, and one special character.");

            request.getRequestDispatcher("/register.jsp")
                    .forward(request, response);

            return;
        }

        // =========================
        // DATABASE
        // =========================

        try (Connection connection = DBConnection.getConnection()) {

            if (connection == null) {

                request.setAttribute("error",
                        "Database connection failed. Please try again later.");

                request.getRequestDispatcher("/register.jsp")
                        .forward(request, response);

                return;
            }

            // =========================
            // CHECK EMAIL
            // =========================

            String checkSql =
                    "SELECT user_id FROM users WHERE email = ?";

            try (PreparedStatement check =
                    connection.prepareStatement(checkSql)) {

                check.setString(1, email);

                try (ResultSet result = check.executeQuery()) {

                    if (result.next()) {

                        request.setAttribute("error",
                                "An account with this email already exists.");

                        request.getRequestDispatcher("/register.jsp")
                                .forward(request, response);

                        return;
                    }
                }
            }

            // =========================
            // HASH PASSWORD
            // =========================

            String hashedPassword =
                    PasswordUtil.hashPassword(password);

            // =========================
            // INSERT USER
            // =========================

            String insertSql =
                    "INSERT INTO users "
                    + "(full_name, email, phone, password) "
                    + "VALUES (?, ?, ?, ?)";

            try (PreparedStatement statement =
                    connection.prepareStatement(insertSql)) {

                statement.setString(1, fullName);
                statement.setString(2, email);
                statement.setString(3, phone);
                statement.setString(4, hashedPassword);

                statement.executeUpdate();
            }

            // =========================
            // REGISTRATION SUCCESS
            // =========================

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?registered=true"
            );

        } catch (Exception exception) {

            log("Registration failed", exception);

            request.setAttribute("error",
                    "Unable to create your account. Please try again.");

            request.getRequestDispatcher("/register.jsp")
                    .forward(request, response);
        }
    }
}