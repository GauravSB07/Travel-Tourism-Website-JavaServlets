package com.traveltourism.model;

public class TourDetails {

    private int tourId;
    private String longDescription;
    private String itinerary;
    private String highlights;
    private String inclusions;
    private String exclusions;
    private String bestTime;
    private String mapEmbed;

    // NEW FIELDS
    private String preparation;
    private String paymentTerms;
    private String upgradesInfo;

    public TourDetails(int tourId, String longDescription, String itinerary, String highlights,
                       String inclusions, String exclusions, String bestTime, String mapEmbed,
                       String preparation, String paymentTerms, String upgradesInfo) {

        this.tourId = tourId;
        this.longDescription = longDescription;
        this.itinerary = itinerary;
        this.highlights = highlights;
        this.inclusions = inclusions;
        this.exclusions = exclusions;
        this.bestTime = bestTime;
        this.mapEmbed = mapEmbed;

        // NEW ASSIGNMENTS
        this.preparation = preparation;
        this.paymentTerms = paymentTerms;
        this.upgradesInfo = upgradesInfo;
    }

    public int getTourId() { return tourId; }
    public String getLongDescription() { return longDescription; }
    public String getItinerary() { return itinerary; }
    public String getHighlights() { return highlights; }
    public String getInclusions() { return inclusions; }
    public String getExclusions() { return exclusions; }
    public String getBestTime() { return bestTime; }
    public String getMapEmbed() { return mapEmbed; }

    // NEW GETTERS
    public String getPreparation() { return preparation; }
    public String getPaymentTerms() { return paymentTerms; }
    public String getUpgradesInfo() { return upgradesInfo; }
}
