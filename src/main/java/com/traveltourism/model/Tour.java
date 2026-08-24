package com.traveltourism.model;

// Creating the template or blueprint for Tour to use by getting values from database
public class Tour {

    private int id;
    private String name;
    private String image;
    private int price;
    private String category;
    private String departureCity;
    private int duration;
    private String shortDescription;   // NEW FIELD

    // Updated constructor including shortDescription
    public Tour(int id, String name, String image, int price,
                String category, String departureCity, int duration,
                String shortDescription) {

        this.id = id;
        this.name = name;
        this.image = image;
        this.price = price;
        this.category = category;
        this.departureCity = departureCity;
        this.duration = duration;
        this.shortDescription = shortDescription;   // NEW ASSIGNMENT
    }

    // Getters
    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getImage() {
        return image;
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

    public String getShortDescription() {   // NEW GETTER
        return shortDescription;
    }
}
