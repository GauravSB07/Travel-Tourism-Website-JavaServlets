package com.traveltourism.model;

/**
 * Image metadata for a tour.
 * Binary image bytes live in tour_images.image_data (BLOB)
 * and are served by TourImageServlet.
 */
public class TourImages {

    private int id;
    private int tourId;
    private String imagePath;
    private byte[] imageData;
    private boolean cover;

    public TourImages(
            int id,
            int tourId,
            String imagePath,
            byte[] imageData,
            boolean cover) {

        this.id = id;
        this.tourId = tourId;
        this.imagePath = imagePath;
        this.imageData = imageData;
        this.cover = cover;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getTourId() {
        return tourId;
    }

    public void setTourId(int tourId) {
        this.tourId = tourId;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public byte[] getImageData() {
        return imageData;
    }

    public void setImageData(byte[] imageData) {
        this.imageData = imageData;
    }

    public boolean isCover() {
        return cover;
    }

    public void setCover(boolean cover) {
        this.cover = cover;
    }
}