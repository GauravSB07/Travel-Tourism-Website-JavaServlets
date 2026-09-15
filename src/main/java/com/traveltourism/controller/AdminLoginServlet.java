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

@WebServlet("/admin-login")
public class AdminLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || username.isBlank()
                || password == null || password.isBlank()) {

            request.setAttribute("error", "Please enter username and password.");
            request.setAttribute("loginType", "admin");

            request.getRequestDispatcher("/login.jsp")
                    .forward(request, response);

            return;
        }

        username = username.trim();

        String sql = """
                SELECT admin_id, username, password
                FROM admins
                WHERE username = ?
                """;

        try (Connection connection = DBConnection.getConnection()) {

            if (connection == null) {

                request.setAttribute("error",
                        "Database connection failed. Please try again later.");

                request.setAttribute("loginType", "admin");

                request.getRequestDispatcher("/login.jsp")
                        .forward(request, response);

                return;
            }

            try (PreparedStatement statement = connection.prepareStatement(sql)) {

                statement.setString(1, username);

                try (ResultSet result = statement.executeQuery()) {

                    if (result.next()) {

                        String storedPassword = result.getString("password");

                        if (PasswordUtil.checkPassword(password, storedPassword)) {

                            HttpSession session = request.getSession(true);

                            session.setAttribute("adminId",
                                    result.getInt("admin_id"));

                            session.setAttribute("adminUsername",
                                    result.getString("username"));

                            session.setAttribute("adminLoggedIn", true);

                            response.sendRedirect(
                                    request.getContextPath() + "/admin"
                            );

                            return;
                        }
                    }
                }
            }

        } catch (Exception exception) {

            log("Admin login failed", exception);

            request.setAttribute("error",
                    "Something went wrong while logging in. Please try again.");

            request.setAttribute("loginType", "admin");

            request.getRequestDispatcher("/login.jsp")
                    .forward(request, response);

            return;
        }

        request.setAttribute("error",
                "Invalid admin username or password.");

        request.setAttribute("loginType", "admin");

        request.getRequestDispatcher("/login.jsp")
                .forward(request, response);
    }
}