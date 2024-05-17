package com.carbon.server.controllers;

import com.carbon.server.model.Trip;
import com.carbon.server.repos.TripRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;
import java.util.List;


@RestController
@RequestMapping("/trips")
public class TripController {

    @Autowired
    private TripRepository tripRepository;

    @GetMapping
    public Iterable<Trip> getAllTrips() {
        return tripRepository.findAll();
    }


    @GetMapping("/{id}")
    public Optional<Trip> getTripById(@PathVariable Long id) {
        return tripRepository.findById(id);
    }

    @PostMapping
    public Trip addTrip(@RequestBody Trip trip) {
        return tripRepository.save(trip);
    }

    @PostMapping("/all")
    public Iterable<Trip> addTrips(@RequestBody List<Trip> trips) {
        return tripRepository.saveAll(trips);
    }
}
