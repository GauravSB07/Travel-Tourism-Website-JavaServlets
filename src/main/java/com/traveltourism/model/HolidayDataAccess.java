package com.traveltourism.model;

import java.sql.*;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.*;

public class HolidayDataAccess {
    public static LocalDate today() { return LocalDate.now(ZoneId.of("Asia/Kolkata")); }

    public List<HolidayPackage> getAvailable() throws SQLException {
        String sql = "SELECT * FROM holiday_packages WHERE active = TRUE AND occasion <> '' ORDER BY occasion, price, id";
        try (Connection con = DBConnection.getConnection()) {
            if (con == null) throw new SQLException("Database connection unavailable");
            Map<String, List<String>> days = new HashMap<>();
            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT holiday_id, description FROM holiday_itinerary ORDER BY holiday_id, day_number");
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) days.computeIfAbsent(rs.getString(1), k -> new ArrayList<>()).add(rs.getString(2));
            }
            List<HolidayPackage> result = new ArrayList<>();
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) result.add(new HolidayPackage(rs.getString("id"), rs.getString("name"),
                        rs.getString("occasion"), rs.getString("departure_city"),
                        rs.getInt("price"), rs.getInt("duration"),
                        rs.getString("description"), rs.getString("inclusions"), rs.getString("exclusions"),
                        rs.getString("source_url"), days.getOrDefault(rs.getString("id"), List.of())));
                }
            }
            return result;
        }
    }

    public HolidayPackage findAvailable(String id) throws SQLException {
        return getAvailable().stream().filter(p -> p.getId().equals(id)).findFirst().orElse(null);
    }
}
