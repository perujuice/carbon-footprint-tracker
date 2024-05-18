package com.carbon.server.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import jakarta.persistence.*;

@Entity
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")

public class Goal {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "goal_id")

    private Long id;

    private double co2Output;
    private String targetDate;

    @OneToOne(mappedBy = "goal", cascade = CascadeType.ALL)
    @JsonBackReference
    private User user;

    // Constructors, getters, and setters
    public Goal() {
    }

    public Goal(Long id, double co2Output, String targetDate, User user) {
        this.id = id;
        this.co2Output = co2Output;
        this.targetDate = targetDate;
        this.user = user;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public double getCo2Output() {
        return co2Output;
    }

    public void setCo2Output(double co2Output) {
        this.co2Output = co2Output;
    }

    public String getTargetDate() {
        return targetDate;
    }

    public void setPeriod(String targetDate) {
        this.targetDate = targetDate;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "Goal{" +
                "id=" + id +
                ", co2Output=" + co2Output +
                ", period='" + targetDate + '\'' +
                ", user=" + user +
                '}';
    }
}
