package com.traveltourism.model;

import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

/** Resolve package details on the server; never accept a price from the browser. */
public final class BookingSelection {
    private BookingSelection() { }

    public static Map<String, Object> load(String holidayId, String tourId) throws SQLException {
        boolean holiday = holidayId != null && !holidayId.isBlank();
        boolean destination = tourId != null && !tourId.isBlank();
        if (holiday == destination) throw new IllegalArgumentException("Select one package to book.");
        Map<String, Object> selection = new LinkedHashMap<>();
        if (holiday) {
            HolidayPackage p = new HolidayDataAccess().findAvailable(holidayId);
            if (p == null) throw new IllegalArgumentException("This holiday is no longer available. Please choose another package.");
            selection.put("type", "holiday"); selection.put("id", p.getId()); selection.put("name", p.getName());
            selection.put("departure", p.getDepartureCity()); selection.put("duration", p.getDuration());
            selection.put("price", p.getPrice());
            selection.put("occasion", p.getOccasion());
        } else {
            int id;
            try { id = Integer.parseInt(tourId); }
            catch (NumberFormatException ex) { throw new IllegalArgumentException("A valid tour id is required."); }
            if (id < 1) throw new IllegalArgumentException("A valid tour id is required.");
            Tour p = new TourDataAccess().getTourById(id);
            if (p == null) throw new IllegalArgumentException("This tour is unavailable. Please choose another package.");
            selection.put("type", "destination"); selection.put("id", String.valueOf(id));
            selection.put("name", p.getName()); selection.put("departure", p.getDepartureCity());
            selection.put("duration", p.getDuration()); selection.put("price", p.getPrice());
        }
        return selection;
    }
}
