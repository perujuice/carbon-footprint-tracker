package com.carbon.server.controllers;

import com.carbon.server.model.Trip;
import com.carbon.server.model.User;
import com.carbon.server.repos.TripRepository;
import com.carbon.server.repos.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private TripRepository tripRepository;

    @GetMapping
    public Iterable<User> getAllUsers() {
        return userRepository.findAll();
    }

    @PostMapping
    public User addUser(@RequestBody User user) {
        return userRepository.save(user);
    }

    @GetMapping("/{userId}/trips")
    public List<Trip> getTripsByUserId(@PathVariable Long userId) {
        Optional<User> user = userRepository.findById(userId);
        return user.map(User::getTrips).orElse(null);
    }

    @PostMapping("/{userId}/trips")
    public Trip addTripForUser(@PathVariable Long userId, @RequestBody Trip trip) {
        Optional<User> userOptional = userRepository.findById(userId);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            trip.setUser(user);
            return tripRepository.save(trip);
        } else {
            return null;
        }
    }

    @PostMapping("/{userId}/trips/all")
    public List<Trip> addTripsForUser(@PathVariable Long userId, @RequestBody List<Trip> trips) {
        Optional<User> userOptional = userRepository.findById(userId);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            for (Trip trip : trips) {
                trip.setUser(user);
            }
            return (List<Trip>) tripRepository.saveAll(trips);
        } else {
            return null;
        }
    }
}

