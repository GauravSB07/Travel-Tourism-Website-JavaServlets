package com.traveltourism.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ExperienceDataAccess {

    public List<Experience> getAllExperiences() {
        List<Experience> list = new ArrayList<>();

        String sql = "SELECT id, title, location, description, reviewer_name, " +
                     "trip_type, rating, image_url " +
                     "FROM experiences " +
                     "WHERE is_active = TRUE " +
                     "ORDER BY id ASC";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                Experience exp = new Experience(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("location"),
                        rs.getString("description"),
                        rs.getString("reviewer_name"),
                        rs.getString("trip_type"),
                        rs.getInt("rating"),
                        rs.getString("image_url")
                );
                list.add(exp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
