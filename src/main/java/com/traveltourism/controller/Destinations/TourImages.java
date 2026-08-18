package com.traveltourism.controller.Destinations;

public class TourImages {

    private int id;
    private int tourId;
    private String imageUrl;

    public TourImages(int id, int tourId, String imageUrl) {
        this.id = id;
        this.tourId = tourId;
        this.imageUrl = imageUrl;
    }

    public int getId() {
        return id;
    }

    public int getTourId() {
        return tourId;
    }

    public String getImageUrl() {
        return imageUrl;
    }
}
