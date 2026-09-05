package com.traveltourism.model;

/**
 * Model class representing a traveler experience / review.
 */
public class Experience {

    private int id;
    private String title;
    private String location;
    private String description;
    private String reviewerName;
    private String tripType;
    private int rating;
    private String imageUrl;

    public Experience(int id, String title, String location, String description,
                      String reviewerName, String tripType, int rating, String imageUrl) {
        this.id = id;
        this.title = title;
        this.location = location;
        this.description = description;
        this.reviewerName = reviewerName;
        this.tripType = tripType;
        this.rating = rating;
        this.imageUrl = imageUrl;
    }

    public int getId() { return id; }
    public String getTitle() { return title; }
    public String getLocation() { return location; }
    public String getDescription() { return description; }
    public String getReviewerName() { return reviewerName; }
    public String getTripType() { return tripType; }
    public int getRating() { return rating; }
    public String getImageUrl() { return imageUrl; }

    /**
     * Returns the rating as a string of star characters for display in JSP.
     */
    public String getStars() {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < rating; i++) sb.append("★");
        for (int i = rating; i < 5; i++) sb.append("☆");
        return sb.toString();
    }
}
