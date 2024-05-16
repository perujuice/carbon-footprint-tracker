package com.carbon.server.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import jakarta.persistence.*;

@Entity
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")

public class Trip {
    public enum Mode {
        DRIVING,
        WALKING,
        BICYCLING,
        TRANSIT
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "trip_id")

    private Long id;

    private String startLocation;
    private String endLocation;
    private double distance;
    @Enumerated(EnumType.STRING)
    private Mode mode;
    private double co2Output;

    @ManyToOne
    @JoinColumn(name = "user_id")
    @JsonBackReference
    private User user;

    // Constructors, getters, and setters
    public Trip() {
    }

    public Trip(Long id, String startLocation, String endLocation, double distance, Mode mode, double co2Output, User user) {
        this.id = id;
        this.startLocation = startLocation;
        this.endLocation = endLocation;
        this.distance = distance;
        this.mode = mode;
        this.co2Output = co2Output;
        this.user = user;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

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

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "Trip{" +
                "id=" + id +
                ", startLocation='" + startLocation + '\'' +
                ", endLocation='" + endLocation + '\'' +
                ", distance=" + distance +
                ", mode=" + mode +
                ", co2Output=" + co2Output +
                ", user=" + user +
                '}';
    }
}
