package com.traveltourism.controller;

import com.traveltourism.model.DBConnection;
import com.traveltourism.model.Tour;
import com.traveltourism.model.TourDataAccess;
import com.traveltourism.model.HolidayDataAccess;
import com.traveltourism.model.HolidayPackage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/saved-tours")
public class SavedToursServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);


        if (session == null
                || !Boolean.TRUE.equals(
                        session.getAttribute(
                                "userLoggedIn"
                        )
                )) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp"
            );

            return;
        }


        try {

            long userId =
                    Long.parseLong(
                            session.getAttribute(
                                    "userId"
                            ).toString()
                    );


            List<SavedTour> savedTours =
                    new ArrayList<>();


            String sql = """
                    SELECT
                        id,
                        tour_id,
                        tour_type,
                        created_at
                    FROM saved_tours
                    WHERE user_id = ?
                    ORDER BY created_at DESC
                    """;


            try (
                    Connection con =
                            DBConnection.getConnection();

                    PreparedStatement ps =
                            con.prepareStatement(sql)
            ) {

                ps.setLong(1, userId);


                try (
                        ResultSet rs =
                                ps.executeQuery()
                ) {

                    while (rs.next()) {

                        SavedTour saved =
                                new SavedTour();

                        saved.setId(
                                rs.getInt("id")
                        );

                        saved.setTourId(
                                rs.getString("tour_id")
                        );

                        saved.setTourType(
                                rs.getString("tour_type")
                        );

                        saved.setCreatedAt(
                                rs.getTimestamp(
                                        "created_at"
                                )
                        );

                        savedTours.add(saved);
                    }
                }
            }


            // =====================================================
            // LOAD DESTINATION TOURS
            // =====================================================

            TourDataAccess tourDAO =
                    new TourDataAccess();


            List<Tour> tours =
                    tourDAO.get_all_tours();


            for (SavedTour saved : savedTours) {

                if (!"destination".equals(
                        saved.getTourType()
                )) {
                    continue;
                }


                try {

                    int id =
                            Integer.parseInt(
                                    saved.getTourId()
                            );


                    for (Tour tour : tours) {

                        if (tour.getId() == id) {

                            saved.setTour(
                                    tour
                            );

                            break;
                        }
                    }

                } catch (
                        NumberFormatException ignored
                ) {
                }
            }


            // =====================================================
            // LOAD CUSTOMIZED HOLIDAYS
            // =====================================================

            try {

                HolidayDataAccess holidayDAO =
                        new HolidayDataAccess();


                List<HolidayPackage> holidays =
                        holidayDAO.getAvailable();


                for (SavedTour saved : savedTours) {

                    if (!"holiday".equals(
                            saved.getTourType()
                    )) {
                        continue;
                    }


                    for (
                            HolidayPackage holiday
                            : holidays
                    ) {

                        if (
                            holiday.getId()
                                .equals(
                                    saved.getTourId()
                                )
                        ) {

                            saved.setHoliday(
                                    holiday
                            );

                            break;
                        }
                    }
                }

            } catch (Exception e) {

                e.printStackTrace();
            }


            request.setAttribute(
                    "savedTours",
                    savedTours
            );


            request.getRequestDispatcher(
                    "/WEB-INF/user/saved-tours.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (Exception e) {

            throw new ServletException(
                    "Unable to load saved tours.",
                    e
            );
        }
    }


    // =============================================================
    // MODEL
    // =============================================================

    public static class SavedTour {

        private int id;

        private String tourId;

        private String tourType;

        private Timestamp createdAt;

        private Tour tour;

        private HolidayPackage holiday;


        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }


        public String getTourId() {
            return tourId;
        }

        public void setTourId(
                String tourId) {

            this.tourId = tourId;
        }


        public String getTourType() {
            return tourType;
        }

        public void setTourType(
                String tourType) {

            this.tourType = tourType;
        }


        public Timestamp getCreatedAt() {
            return createdAt;
        }

        public void setCreatedAt(
                Timestamp createdAt) {

            this.createdAt = createdAt;
        }


        public Tour getTour() {
            return tour;
        }

        public void setTour(Tour tour) {
            this.tour = tour;
        }


        public HolidayPackage getHoliday() {
            return holiday;
        }

        public void setHoliday(
                HolidayPackage holiday) {

            this.holiday = holiday;
        }
    }
}