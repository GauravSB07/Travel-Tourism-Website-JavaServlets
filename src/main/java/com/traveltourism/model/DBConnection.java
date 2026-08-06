package com.traveltourism.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.SQLException;

public class DBConnection {
	private static final String URL = "jdbc:mysql://localhost:3306/travel_tourism";
    private static final String USER = "root";
    private static final String PASS = "strawberry";

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
