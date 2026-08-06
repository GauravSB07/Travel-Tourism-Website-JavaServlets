package com.traveltourism.model;

// Get tour data from the database

import java.sql.Connection;
import java.sql.*;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TourDataAccess {
	//Creating a list that takes values from Tour class created
	public List<Tour> get_all_tours() {
        List<Tour> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM tours";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            //Fetching values from database
            while (rs.next()) {
                Tour t = new Tour(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("image"),
                    rs.getInt("price"),
                    rs.getString("category"),
                    rs.getString("departure_city"),
                    rs.getInt("duration")
                );
                list.add(t);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
