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
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/user-login")
public class UserLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // =========================
        // GET LOGIN DETAILS
        // =========================

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.isBlank()
                || password == null || password.isBlank()) {

            request.setAttribute(
                    "error",
                    "Please enter your email and password."
            );

            request.getRequestDispatcher("/login.jsp")
                    .forward(request, response);

            return;
        }

        email = email.trim().toLowerCase();

        // =========================
        // GET USER FROM DATABASE
        // =========================

        String sql = """
                SELECT user_id, full_name, email, phone, password
                FROM users
                WHERE email = ?
                """;

        try (Connection connection = DBConnection.getConnection()) {

            if (connection == null) {

                request.setAttribute(
                        "error",
                        "Database connection failed. Please try again later."
                );

                request.getRequestDispatcher("/login.jsp")
                        .forward(request, response);

                return;
            }

            try (PreparedStatement statement =
                    connection.prepareStatement(sql)) {

                statement.setString(1, email);

                try (ResultSet result = statement.executeQuery()) {

                    if (result.next()) {

                        // =========================
                        // CHECK PASSWORD
                        // =========================

                        String storedPassword =
                                result.getString("password");

                        if (PasswordUtil.checkPassword(
                                password,
                                storedPassword)) {

                            // =========================
                            // CREATE USER SESSION
                            // =========================

                            HttpSession session =
                                    request.getSession(true);

                            session.setAttribute(
                                    "userId",
                                    result.getInt("user_id")
                            );

                            session.setAttribute(
                                    "userName",
                                    result.getString("full_name")
                            );

                            session.setAttribute(
                                    "userEmail",
                                    result.getString("email")
                            );

                            // Store registered phone number
                            session.setAttribute(
                                    "userPhone",
                                    result.getString("phone")
                            );

                            session.setAttribute(
                                    "userLoggedIn",
                                    true
                            );

                            // =========================
                            // REDIRECT AFTER LOGIN
                            // =========================

                            String redirect =
                                    request.getParameter("redirect");

                            if (redirect != null
                                    && !redirect.isBlank()
                                    && redirect.startsWith("/")) {

                                response.sendRedirect(
                                        request.getContextPath()
                                        + redirect
                                );

                            } else {

                                response.sendRedirect(
                                        request.getContextPath()
                                        + "/index.jsp"
                                );
                            }

                            return;
                        }
                    }
                }
            }

        } catch (Exception exception) {

            log("User login failed", exception);

            request.setAttribute(
                    "error",
                    "Something went wrong while logging in. Please try again."
            );

            request.getRequestDispatcher("/login.jsp")
                    .forward(request, response);

            return;
        }

        // =========================
        // INVALID LOGIN
        // =========================

        request.setAttribute(
                "error",
                "Invalid email or password."
        );

        request.getRequestDispatcher("/login.jsp")
                .forward(request, response);
    }
}