package com.carbon.server.controllers;

import com.carbon.server.model.Trip;
import com.carbon.server.model.User;
import com.carbon.server.model.Goal;
import com.carbon.server.repos.TripRepository;
import com.carbon.server.repos.UserRepository;
import com.carbon.server.repos.GoalRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.Map;

@RestController
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private TripRepository tripRepository;

    @Autowired
    private GoalRepository goalRepository;

    /**
     * Get all users.
     * Test in browser: http://localhost:8080/users
     */
    @GetMapping
    public Iterable<User> getAllUsers() {
        return userRepository.findAll();
    }

    /**
     * Add a new user with just the name attribute.
     * Test in terminal:
     * curl -X POST -H "Content-Type: application/json" -d '{"name": "userMartein"}' http://localhost:8080/users/adduser
     * Body: { "name": "userName" }
     */
    @PostMapping("/adduser")
    public User addUser(@RequestBody Map<String, String> userMap) {
        User user = new User();
        user.setName(userMap.get("name"));
        user.setPasswordHash(userMap.get("password")); // storing password directly, not recommended
        return userRepository.save(user);
    }


    @PostMapping("/login")
    public ResponseEntity<User> loginUser(@RequestBody Map<String, String> userMap) {
        String name = userMap.get("name");
        String password = userMap.get("password");

        // Find the user by name
        Optional<User> userOptional = userRepository.findByName(name);

        if (userOptional.isPresent()) {
            User user = userOptional.get();

            // Compare the plain text password with the stored password
            if (password.equals(user.getPasswordHash())) {
                // If the passwords match, return the user
                return new ResponseEntity<>(user, HttpStatus.OK);
            }
        }

        // If the user is not found or the passwords don't match, return an unauthorized status
        return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
    }


    /**
     * Get all trips for a user by user ID.
     * Test in browser: http://localhost:8080/users/{userId}/trips
     */
    @GetMapping("/{userId}/trips")
    public List<Trip> getTripsByUserId(@PathVariable Long userId) {
        Optional<User> user = userRepository.findById(userId);
        return user.map(User::getTrips).orElse(null);
    }

    /**
     * Add a trip for a user by user ID.
     * Test in browser using Postman or similar tool:
     * POST http://localhost:8080/users/{userId}/trips
     * Body: { "tripDetails": "details here" }
     */
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

    /**
     * Add multiple trips for a user by user ID.
     * Test in browser using Postman or similar tool:
     * POST http://localhost:8080/users/{userId}/trips/all
     * Body: [ { "tripDetails": "details here" }, { "tripDetails": "details here" } ]
     */
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

    /**
     * Set a goal for a user by user ID.
     * Test in browser using Postman or similar tool:
     * POST http://localhost:8080/users/{userId}/goal
     * Body: { "co2Output": 50.0, "period": "21-08-24, 25-08-24" }
     *
     * cURL command:
     * curl -X POST -H "Content-Type: application/json" -d '{"co2Output": 50.0, "period": "21-08-24, 25-08-24"}' http://localhost:8080/users/{userId}/goal
     */
    @PostMapping("/{userId}/goal")
    public Goal setGoalForUser(@PathVariable Long userId, @RequestBody Goal goal) {
        Optional<User> userOptional = userRepository.findById(userId);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            goal.setUser(user);
            Goal savedGoal = goalRepository.save(goal);
            user.setGoal(savedGoal);
            userRepository.save(user);
            return savedGoal;
        } else {
            return null;
        }
    }
}
