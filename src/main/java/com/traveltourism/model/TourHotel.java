package com.traveltourism.model;

public class TourHotel {
    private String city;
    private String hotelName;
    private String checkIn;
    private String checkOut;

    public TourHotel(String city, String hotelName, String checkIn, String checkOut) {
        this.city = city;
        this.hotelName = hotelName;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
    }

    public String getCity() { return city; }
    public String getHotelName() { return hotelName; }
    public String getCheckIn() { return checkIn; }
    public String getCheckOut() { return checkOut; }
}
