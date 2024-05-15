package com.carbon.server.model;

public class Trip {

    public enum Mode {
        DRIVING,
        WALKING,
        BICYCLING,
        TRANSIT
    }

    private String startLocation;
    private String endLocation;
    private double distance;
    private Mode mode;
    private double co2Output;

    // Constructor
    public Trip(String startLocation, String endLocation, double distance, Mode mode, double co2Output) {
        this.startLocation = startLocation;
        this.endLocation = endLocation;
        this.distance = distance;
        this.mode = mode;
        this.co2Output = co2Output;
    }

    // Getters and Setters
    public String getStartLocation() {
        return startLocation;
    }

    public void setStartLocation(String startLocation) {
        this.startLocation = startLocation;
    }

    public String getEndLocation() {
        return endLocation;
    }

    public void setEndLocation(String endLocation) {
        this.endLocation = endLocation;
    }

    public double getDistance() {
        return distance;
    }

    public void setDistance(double distance) {
        this.distance = distance;
    }

    public Mode getMode() {
        return mode;
    }

    public void setMode(Mode mode) {
        this.mode = mode;
    }

    public double getCo2Output() {
        return co2Output;
    }

    public void setCo2Output(double co2Output) {
        this.co2Output = co2Output;
    }

    // Method to calculate carbon footprint
    public void calculateCarbonFootprint() {
        this.co2Output = CarbonCalculator.calculateCO2(this.mode, this.distance);
    }

    @Override
    public String toString() {
        return "Trip{" +
                "startLocation='" + startLocation + '\'' +
                ", endLocation='" + endLocation + '\'' +
                ", distance=" + distance +
                ", mode=" + mode +
                ", co2Output=" + co2Output +
                '}';
    }
}
