package com.traveltourism.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TourDataAccess {


    // =========================================================
    // 1. GET ALL TOURS
    // =========================================================

    public List<Tour> get_all_tours() {

        List<Tour> list = new ArrayList<>();

        String sql =
                "SELECT " +
                "t.id, " +
                "t.name, " +
                "t.price, " +
                "t.category, " +
                "t.departure_city, " +
                "t.duration, " +
                "t.short_description, " +
                "ti.id AS image_id " +
                "FROM tours t " +
                "LEFT JOIN tour_images ti " +
                "ON t.id = ti.tour_id " +
                "AND ti.is_cover = TRUE " +
                "ORDER BY t.id ASC";


        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

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

        } catch (Exception e) {

            e.printStackTrace();
        }

        return list;
    }


    // =========================================================
    // 2. GET TOUR BY ID
    // =========================================================

    public Tour getTourById(int id) {

        Tour tour = null;


        String sql =
                "SELECT " +
                "t.id, " +
                "t.name, " +
                "t.price, " +
                "t.category, " +
                "t.departure_city, " +
                "t.duration, " +
                "t.short_description, " +
                "ti.id AS image_id " +
                "FROM tours t " +
                "LEFT JOIN tour_images ti " +
                "ON t.id = ti.tour_id " +
                "AND ti.is_cover = TRUE " +
                "WHERE t.id = ?";


        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);


            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    tour = new Tour(

                            rs.getInt("id"),

                            rs.getString("name"),

                            rs.getInt("image_id"),

                            rs.getInt("price"),

                            rs.getString("category"),

                            rs.getString("departure_city"),

                            rs.getInt("duration"),

                            rs.getString("short_description")
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return tour;
    }


    // =========================================================
    // 3. GET TOUR DETAILS BY ID
    // =========================================================

    public TourDetails getTourDetailsById(int id) {

        TourDetails details = null;


        String sql =
                "SELECT * " +
                "FROM tour_details " +
                "WHERE tour_id = ?";


        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);


            try (ResultSet rs = ps.executeQuery()) {

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
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return details;
    }


    // =========================================================
    // 4. GET TOUR IMAGES BY TOUR ID
    // =========================================================

    public List<TourImages> getTourImagesById(int id) {

        List<TourImages> images = new ArrayList<>();


        // Bytes are served by TourImageServlet; only metadata is needed here.
        String sql =
                "SELECT id, tour_id, is_cover " +
                "FROM tour_images " +
                "WHERE tour_id = ? " +
                "ORDER BY is_cover DESC, id ASC";


        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);


            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    TourImages img = new TourImages(

                            rs.getInt("id"),

                            rs.getInt("tour_id"),

                            null,

                            null,

                            rs.getBoolean("is_cover")
                    );

                    images.add(img);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return images;
    }


    // =========================================================
    // 5. GET DAY-WISE ITINERARY
    // =========================================================

    public List<TourItinerary> getItineraryByTourId(int id) {

        List<TourItinerary> list = new ArrayList<>();


        String sql =
                "SELECT * " +
                "FROM tour_itinerary " +
                "WHERE tour_id = ? " +
                "ORDER BY day_number ASC";


        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);


            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    TourItinerary ti = new TourItinerary(

                            rs.getInt("day_number"),

                            rs.getString("day_title"),

                            rs.getString("day_description")
                    );

                    list.add(ti);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return list;
    }


    // =========================================================
    // 6. GET HOTEL DETAILS
    // =========================================================

    public List<TourHotel> getHotelsByTourId(int id) {

        List<TourHotel> list = new ArrayList<>();


        String sql =
                "SELECT * " +
                "FROM tour_hotels " +
                "WHERE tour_id = ?";


        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);


            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    TourHotel th = new TourHotel(

                            rs.getString("city"),

                            rs.getString("hotel_name"),

                            rs.getString("check_in"),

                            rs.getString("check_out")
                    );

                    list.add(th);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return list;
    }
}