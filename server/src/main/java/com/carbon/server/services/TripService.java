// TripService.java
package main.java.com.carbon.server.services;

import com.carbon.server.model.Trip;
import com.carbon.server.repository.TripRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TripService {
    @Autowired
    private TripRepository tripRepository;

    public List<Trip> getAllTrips() {
        return tripRepository.findAll();
    }
}

// Repeat similar structure for User, Vehicle, Route, Station
