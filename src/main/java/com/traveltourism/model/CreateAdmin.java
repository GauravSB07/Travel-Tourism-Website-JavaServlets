/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.traveltourism.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Scanner;

public class CreateAdmin {

    public static void main(String[] args) {

        Scanner scanner = new Scanner(System.in);

        System.out.println("=================================");
        System.out.println("      CREATE ADMIN ACCOUNT");
        System.out.println("=================================");

        System.out.print("Enter admin username: ");
        String username = scanner.nextLine().trim();

        System.out.print("Enter admin password: ");
        String password = scanner.nextLine();

        if (username.isBlank() || password.isBlank()) {
            System.out.println("Username and password cannot be empty.");
            return;
        }

        String checkSql =
                "SELECT admin_id FROM admins WHERE username = ?";

        String insertSql =
                "INSERT INTO admins (username, password) VALUES (?, ?)";

        try (Connection connection = DBConnection.getConnection()) {

            if (connection == null) {
                System.out.println("Database connection failed.");
                System.out.println("Please check your DBConnection.java.");
                return;
            }

            // Check whether username already exists
            try (PreparedStatement checkStatement =
                         connection.prepareStatement(checkSql)) {

                checkStatement.setString(1, username);

                try (ResultSet result = checkStatement.executeQuery()) {

                    if (result.next()) {
                        System.out.println(
                                "An admin with this username already exists."
                        );
                        return;
                    }
                }
            }

            // Create BCrypt password hash
            String hashedPassword =
                    PasswordUtil.hashPassword(password);

            // Insert admin
            try (PreparedStatement insertStatement =
                         connection.prepareStatement(insertSql)) {

                insertStatement.setString(1, username);
                insertStatement.setString(2, hashedPassword);

                int rows = insertStatement.executeUpdate();

                if (rows > 0) {
                    System.out.println();
                    System.out.println("=================================");
                    System.out.println(" ADMIN CREATED SUCCESSFULLY!");
                    System.out.println(" Username: " + username);
                    System.out.println(" Password: [hidden]");
                    System.out.println("=================================");
                } else {
                    System.out.println("Admin could not be created.");
                }
            }

        } catch (Exception e) {

            System.out.println();
            System.out.println("Error while creating admin:");
            e.printStackTrace();

        } finally {
            scanner.close();
        }
    }
}