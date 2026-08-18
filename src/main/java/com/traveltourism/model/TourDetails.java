package com.traveltourism.model;

public class TourDetails {

    private int tourId;
    private String description;
    private String highlights;
    private String itinerary;

    public TourDetails(int tourId, String description, String highlights, String itinerary) {
        this.tourId = tourId;
        this.description = description;
        this.highlights = highlights;
        this.itinerary = itinerary;
    }

    public int getTourId() {
        return tourId;
    }

    public String getDescription() {
        return description;
    }

    public String getHighlights() {
        return highlights;
    }

    public String getItinerary() {
        return itinerary;
    }
}
