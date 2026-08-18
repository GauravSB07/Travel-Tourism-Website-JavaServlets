package com.traveltourism.model;
//Creating the template or blueprint for Tour to use by getting values from database

public class Tour {
	private int id;
    private String name;
    private String image;
    private int price;
    private String category;
    private String departureCity;
    private int duration;

    public Tour(int id, String name, String image, int price,
                String category, String departureCity, int duration) {
        this.id = id;  //Used this.id as id already declared at top in class
        this.name = name; //this.name shows name signifies constructor's name
        this.image = image;
        this.price = price;
        this.category = category;
        this.departureCity = departureCity;
        this.duration = duration;
    }

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
}
