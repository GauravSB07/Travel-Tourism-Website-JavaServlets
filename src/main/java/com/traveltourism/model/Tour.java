package com.traveltourism.model;

/**
 * Model class representing a tour.
 *
 * Tour information is loaded from the database.
 * The tour's cover image is stored in the tour_images table,
 * so this class stores the ID of that image.
 */
public class Tour {

    // =========================================================
    // FIELDS
    // =========================================================

    private int id;
    private String name;

    // ID of the cover image stored in the tour_images table
    private int imageId;

    private int price;
    private String category;
    private String departureCity;
    private int duration;
    private String shortDescription;


    // =========================================================
    // CONSTRUCTOR
    // =========================================================

    public Tour(
            int id,
            String name,
            int imageId,
            int price,
            String category,
            String departureCity,
            int duration,
            String shortDescription) {

        this.id = id;
        this.name = name;
        this.imageId = imageId;
        this.price = price;
        this.category = category;
        this.departureCity = departureCity;
        this.duration = duration;
        this.shortDescription = shortDescription;
    }


    // =========================================================
    // GETTERS
    // =========================================================

    public int getId() {
        return id;
    }


    public String getName() {
        return name;
    }


    /**
     * Returns the database ID of the tour's cover image.
     *
     * JSP usage:
     * ${tour.imageId}
     */
    public int getImageId() {
        return imageId;
    }


    public int getPrice() {
        return price;
    }


    public String getCategory() {
        return category;
    }


    public String getDepartureCity() {
        return departureCity;
    }


    public int getDuration() {
        return duration;
    }


    public String getShortDescription() {
        return shortDescription;
    }
}