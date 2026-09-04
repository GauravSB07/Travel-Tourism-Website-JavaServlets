package com.traveltourism.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Collections;

public class SearchDataAccess {

    public List<Tour> getSemanticResults(String query, int limit, List<Integer> excludeIds) {
        EmbeddingService embeddingService = EmbeddingService.getInstance();
        float[] vector = embeddingService.getEmbedding(query);
        if (vector == null) return Collections.emptyList();
        
        String vectorString = embeddingService.vectorToMysql(vector);
        
        List<Tour> list = new ArrayList<>();
        
        StringBuilder excludeClause = new StringBuilder();
        if (excludeIds != null && !excludeIds.isEmpty()) {
            excludeClause.append(" AND te.tour_id NOT IN (");
            for (int i = 0; i < excludeIds.size(); i++) {
                excludeClause.append("?");
                if (i < excludeIds.size() - 1) excludeClause.append(",");
            }
            excludeClause.append(")");
        }
        
        String sqlSetVec = "SET @query_vec = myvector_construct(?)";
        String sqlQuery = 
            "SELECT t.id, t.name, t.price, t.category, t.departure_city, t.duration, t.short_description, " +
            "ti.id AS image_id " +
            "FROM tour_embedding te " +
            "JOIN tours t ON t.id = te.tour_id " +
            "LEFT JOIN tour_images ti ON t.id = ti.tour_id AND ti.is_cover = TRUE " +
            "WHERE te.embedding_myvector IS NOT NULL " + excludeClause.toString() +
            " ORDER BY myvector_distance(te.embedding_myvector, @query_vec, 'Cosine') ASC " +
            "LIMIT ?";
            
        try (Connection con = DBConnection.getConnection()) {
            
            try (PreparedStatement ps1 = con.prepareStatement(sqlSetVec)) {
                ps1.setString(1, vectorString);
                ps1.execute();
            }
            
            try (PreparedStatement ps2 = con.prepareStatement(sqlQuery)) {
                int index = 1;
                if (excludeIds != null) {
                    for (Integer id : excludeIds) {
                        ps2.setInt(index++, id);
                    }
                }
                ps2.setInt(index, limit);
                try (ResultSet rs = ps2.executeQuery()) {
                    while (rs.next()) {
                        Tour t = new Tour(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getInt("image_id"),
                            rs.getInt("price"),
                            rs.getString("category"),
                            rs.getString("departure_city"),
                            rs.getInt("duration"),
                            rs.getString("short_description")
                        );
                        list.add(t);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
    public List<Tour> getFuzzyResults(String query, List<Integer> excludeIds) {
        List<Tour> list = new ArrayList<>();
        
        StringBuilder excludeClause = new StringBuilder();
        if (excludeIds != null && !excludeIds.isEmpty()) {
            excludeClause.append(" AND t.id NOT IN (");
            for (int i = 0; i < excludeIds.size(); i++) {
                excludeClause.append("?");
                if (i < excludeIds.size() - 1) excludeClause.append(",");
            }
            excludeClause.append(")");
        }
        
        String sql = 
            "SELECT t.id, t.name, t.price, t.category, t.departure_city, t.duration, t.short_description, " +
            "ti.id AS image_id " +
            "FROM tours t " +
            "LEFT JOIN tour_images ti ON t.id = ti.tour_id AND ti.is_cover = TRUE " +
            "WHERE t.name LIKE ? " +
            excludeClause.toString() +
            " ORDER BY t.id ASC";
            
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
             
            ps.setString(1, "%" + query + "%");
            
            int index = 2;
            if (excludeIds != null) {
                for (Integer id : excludeIds) {
                    ps.setInt(index++, id);
                }
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Tour t = new Tour(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getInt("image_id"),
                        rs.getInt("price"),
                        rs.getString("category"),
                        rs.getString("departure_city"),
                        rs.getInt("duration"),
                        rs.getString("short_description")
                    );
                    list.add(t);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
}
