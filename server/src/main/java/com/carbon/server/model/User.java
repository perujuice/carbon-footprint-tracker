package com.carbon.server.model;

public class User {
    private Long id;
    private String name;
    private Goal goal;
    private Trip trip;

    // Constructor
    public User() {
    }

    public User(Long id, String name, Goal goal, Trip trip) {
        this.id = id;
        this.name = name;
        this.goal = goal;
        this.trip = trip;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Goal getGoal() {
        return goal;
    }

    public void setGoal(Goal goal) {
        this.goal = goal;
    }

    public Trip getTrip() {
        return trip;
    }

    public void setTrip(Trip trip) {
        this.trip = trip;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", goal=" + goal +
                ", trip=" + trip +
                '}';
    }
}
