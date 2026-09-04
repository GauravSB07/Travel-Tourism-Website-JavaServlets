package com.traveltourism.model;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final String URL = "jdbc:mysql://javadb.rehat.xyz:3306/travel_tourism?ssl-mode=REQUIRED";
    private static final String USER = "avnadmin";
    private static final String PASS = "AVNS_skBVP1sM63j-YORGUKn";

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
