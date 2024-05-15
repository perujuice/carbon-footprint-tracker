// Goal.java
package com.carbon.server.model;

public class Goal {
    private Long id;
    private double co2Output;
    private Period period;

    // Constructor
    public Goal(Long id, double co2Output, Period period) {
        this.id = id;
        this.co2Output = co2Output;
        this.period = period;
    }

    // Getters and Setters
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

    public Period getPeriod() {
        return period;
    }

    public void setPeriod(Period period) {
        this.period = period;
    }

    @Override
    public String toString() {
        return "Goal{" +
                "id=" + id +
                ", co2Output=" + co2Output +
                ", period=" + period +
                '}';
    }
}
