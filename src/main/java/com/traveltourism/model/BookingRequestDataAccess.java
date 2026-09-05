package com.traveltourism.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public final class BookingRequestDataAccess {
    private BookingRequestDataAccess() {}

    public static List<Map<String, Object>> list(String status, String search, boolean archived) throws SQLException {
        List<Map<String, Object>> bookings = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM booking_requests WHERE archived=?");
        List<String> parameters = new ArrayList<>();
        if (status != null && !"all".equals(status)) {
            sql.append(" AND status=?");
            parameters.add(status);
        }
        if (search != null && !search.isBlank()) {
            sql.append(" AND (reference LIKE ? OR customer_name LIKE ? OR email LIKE ? OR package_name LIKE ?)");
            String term = "%" + search.trim() + "%";
            for (int i = 0; i < 4; i++) parameters.add(term);
        }
        sql.append(" ORDER BY CASE status WHEN 'pending' THEN 0 WHEN 'reviewing' THEN 1 ")
           .append("WHEN 'confirmed' THEN 2 WHEN 'completed' THEN 3 ELSE 4 END, created_at DESC");
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql.toString())) {
            int index = 1;
            statement.setBoolean(index++, archived);
            for (String value : parameters) statement.setString(index++, value);
            try (ResultSet results = statement.executeQuery()) {
                while (results.next()) bookings.add(row(results));
            }
        }
        return bookings;
    }

    public static Map<String, Object> find(String reference) throws SQLException {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement("SELECT * FROM booking_requests WHERE reference=?")) {
            statement.setString(1, reference);
            try (ResultSet results = statement.executeQuery()) {
                return results.next() ? row(results) : null;
            }
        }
    }

    public static void update(String reference, String status, String notes, Date followUpDate, boolean archived) throws SQLException {
        String sql = "UPDATE booking_requests SET status=?, admin_notes=?, follow_up_date=?, archived=? WHERE reference=?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, status);
            statement.setString(2, notes);
            if (followUpDate == null) statement.setNull(3, Types.DATE);
            else statement.setDate(3, followUpDate);
            statement.setBoolean(4, archived);
            statement.setString(5, reference);
            statement.executeUpdate();
        }
    }

    public static boolean deleteArchived(String reference) throws SQLException {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement("DELETE FROM booking_requests WHERE reference=? AND archived=TRUE")) {
            statement.setString(1, reference);
            return statement.executeUpdate() == 1;
        }
    }

    public static Map<String, Integer> counts() throws SQLException {
        Map<String, Integer> counts = new LinkedHashMap<>();
        for (String status : new String[]{"pending", "reviewing", "confirmed", "completed", "cancelled"}) counts.put(status, 0);
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement("SELECT status, COUNT(*) FROM booking_requests WHERE archived=FALSE GROUP BY status");
             ResultSet results = statement.executeQuery()) {
            while (results.next()) counts.put(results.getString(1), results.getInt(2));
        }
        return counts;
    }

    private static Map<String, Object> row(ResultSet results) throws SQLException {
        Map<String, Object> values = new LinkedHashMap<>();
        ResultSetMetaData metadata = results.getMetaData();
        for (int i = 1; i <= metadata.getColumnCount(); i++) values.put(metadata.getColumnLabel(i), results.getObject(i));
        return values;
    }
}
