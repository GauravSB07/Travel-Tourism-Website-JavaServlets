package com.traveltourism.model;

import java.sql.*;
import java.util.LinkedHashMap;
import java.util.Map;

public final class HomepageDataAccess {
    private HomepageDataAccess() {}
    public static Map<String,String> defaults() {
        Map<String,String> v=new LinkedHashMap<>();
        v.put("hero_label","DISCOVER • EXPERIENCE • REMEMBER");
        v.put("hero_title","Your Journey.");
        v.put("hero_accent","Your Way.");
        v.put("hero_description","Explore India's most beautiful destinations, discover unforgettable experiences and find a holiday designed around your occasion.");
        v.put("destination_label","EXPLORE INDIA");
        v.put("destination_title","Popular Destinations");
        v.put("destination_description","From beaches and mountains to heritage cities, discover places worth remembering.");
        v.put("holiday_label","MADE FOR YOUR MOMENT");
        v.put("holiday_title","Holidays for Every Occasion");
        v.put("holiday_description","Choose a celebration that matters to you, then explore thoughtfully designed birthday, honeymoon, anniversary, family and group holiday packages.");
        v.put("holiday_button","Explore Customized Holidays");
        return v;
    }
    public static Map<String,String> load() {
        Map<String,String> v=defaults();
        try(Connection con=DBConnection.getConnection(); PreparedStatement ps=con.prepareStatement("SELECT * FROM homepage_content WHERE id=1"); ResultSet rs=ps.executeQuery()) {
            if(rs.next()) for(String key:v.keySet()){String value=rs.getString(key);if(value!=null&&!value.isBlank())v.put(key,value);}
        } catch(SQLException ignored) {}
        return v;
    }
    public static void save(Map<String,String> values)throws SQLException {
        String sql="INSERT INTO homepage_content (id,hero_label,hero_title,hero_accent,hero_description,destination_label,destination_title,destination_description,holiday_label,holiday_title,holiday_description,holiday_button) VALUES (1,?,?,?,?,?,?,?,?,?,?,?) ON DUPLICATE KEY UPDATE hero_label=VALUES(hero_label),hero_title=VALUES(hero_title),hero_accent=VALUES(hero_accent),hero_description=VALUES(hero_description),destination_label=VALUES(destination_label),destination_title=VALUES(destination_title),destination_description=VALUES(destination_description),holiday_label=VALUES(holiday_label),holiday_title=VALUES(holiday_title),holiday_description=VALUES(holiday_description),holiday_button=VALUES(holiday_button)";
        try(Connection con=DBConnection.getConnection();PreparedStatement ps=con.prepareStatement(sql)){int i=1;for(String key:defaults().keySet())ps.setString(i++,values.get(key));ps.executeUpdate();}
    }
}