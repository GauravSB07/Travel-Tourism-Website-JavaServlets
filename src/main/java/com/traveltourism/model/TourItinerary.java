package com.traveltourism.model;

public class TourItinerary {

    private final int dayNumber;
    private final String dayTitle;
    private final String dayDescription;

    public TourItinerary(int dayNumber, String dayTitle, String dayDescription) {
        this.dayNumber = dayNumber;
        this.dayTitle = dayTitle;
        this.dayDescription = dayDescription;
    }

    public int getDayNumber() {
        return dayNumber;
    }

    public String getDayTitle() {
        return dayTitle;
    }

    public String getDayDescription() {
        return dayDescription;
    }
}
