package com.traveltourism.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TourDataAccess {

    // ---------------------------------------------------------
    // 1. GET ALL TOURS
    // ---------------------------------------------------------
    public List<Tour> get_all_tours() {
        List<Tour> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM tours";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Tour t = new Tour(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("image"),
                    rs.getInt("price"),
                    rs.getString("category"),
                    rs.getString("departure_city"),
                    rs.getInt("duration"),
                    rs.getString("short_description")
                );
                list.add(t);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ---------------------------------------------------------
    // 2. GET TOUR BY ID
    // ---------------------------------------------------------
    public Tour getTourById(int id) {
        Tour tour = null;

        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM tours WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                tour = new Tour(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("image"),
                    rs.getInt("price"),
                    rs.getString("category"),
                    rs.getString("departure_city"),
                    rs.getInt("duration"),
                    rs.getString("short_description")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return tour;
    }

    // ---------------------------------------------------------
    // 3. GET TOUR DETAILS BY ID
    // ---------------------------------------------------------
    public TourDetails getTourDetailsById(int id) {
        TourDetails details = null;

        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM tour_details WHERE tour_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                details = new TourDetails(
                    rs.getInt("tour_id"),
                    rs.getString("long_description"),
                    rs.getString("itinerary"),
                    rs.getString("highlights"),
                    rs.getString("inclusions"),
                    rs.getString("exclusions"),
                    rs.getString("best_time"),
                    rs.getString("map_embed"),
                    rs.getString("preparation"),
                    rs.getString("payment_terms"),
                    rs.getString("upgrades_info")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return details;
    }

    // ---------------------------------------------------------
    // 4. GET TOUR IMAGES BY ID
    // ---------------------------------------------------------
    public List<TourImages> getTourImagesById(int id) {
        List<TourImages> images = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM tour_images WHERE tour_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                TourImages img = new TourImages(
                    rs.getInt("id"),
                    rs.getInt("tour_id"),
                    rs.getString("image_url")
                );
                images.add(img);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return images;
    }

    // ---------------------------------------------------------
    // 5. GET DAY-WISE ITINERARY
    // ---------------------------------------------------------
    public List<TourItinerary> getItineraryByTourId(int id) {
        List<TourItinerary> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM tour_itinerary WHERE tour_id = ? ORDER BY day_number ASC";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                TourItinerary ti = new TourItinerary(
                    rs.getInt("day_number"),
                    rs.getString("day_title"),
                    rs.getString("day_description")
                );
                list.add(ti);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ---------------------------------------------------------
    // 6. GET HOTEL DETAILS
    // ---------------------------------------------------------
    public List<TourHotel> getHotelsByTourId(int id) {
        List<TourHotel> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM tour_hotels WHERE tour_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                TourHotel th = new TourHotel(
                    rs.getString("city"),
                    rs.getString("hotel_name"),
                    rs.getString("check_in"),
                    rs.getString("check_out")
                );
                list.add(th);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
