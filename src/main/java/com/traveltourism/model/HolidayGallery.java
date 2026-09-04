package com.traveltourism.model;
import java.sql.*;
import java.util.*;
public final class HolidayGallery {
    private HolidayGallery() {}
    public static List<Map<String,Object>> load(String holidayId) throws SQLException {
        List<Map<String,Object>> photos=new ArrayList<>();
        try(Connection con=DBConnection.getConnection();PreparedStatement ps=con.prepareStatement(
                "SELECT id,caption FROM holiday_gallery WHERE holiday_id=? ORDER BY id")) {
            ps.setString(1,holidayId);
            try(ResultSet rs=ps.executeQuery()) { while(rs.next()) {
                Map<String,Object> photo=new LinkedHashMap<>();
                photo.put("id",rs.getLong(1));photo.put("caption",rs.getString(2));photos.add(photo);
            }}
        }catch(SQLException e){if(e.getErrorCode()!=1146)throw e;}
        return photos;
    }
}
