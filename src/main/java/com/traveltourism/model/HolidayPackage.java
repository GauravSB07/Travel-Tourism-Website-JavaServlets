package com.traveltourism.model;

import java.util.List;

public class HolidayPackage {
    private final String id, name, occasion, departureCity, description, inclusions, exclusions, sourceUrl;
    private final int price, duration;
    private final List<String> itinerary;

    public HolidayPackage(String id, String name, String occasion, String departureCity,
            int price, int duration, String description,
            String inclusions, String exclusions, String sourceUrl, List<String> itinerary) {
        this.id = id; this.name = name; this.occasion = occasion; this.departureCity = departureCity;
        this.price = price; this.duration = duration;
        this.description = description; this.inclusions = inclusions; this.exclusions = exclusions;
        this.sourceUrl = sourceUrl; this.itinerary = List.copyOf(itinerary);
    }
    public String getId() { return id; }
    public String getName() { return name; }
    public String getOccasion() { return occasion; }
    public String getDepartureCity() { return departureCity; }
    public int getPrice() { return price; }
    public int getDuration() { return duration; }
    public String getShortDescription() { return description; }
    public String getInclusions() { return inclusions; }
    public String getExclusions() { return exclusions; }
    public String getSourceUrl() {
        return sourceUrl != null && sourceUrl.startsWith("https://") ? sourceUrl : "";
    }
    public List<String> getItinerary() { return itinerary; }
}
