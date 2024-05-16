package com.carbon.server.repos;

import com.carbon.server.model.Trip;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TripRepository extends CrudRepository<Trip, Long> {
    // Additional query methods can be defined here if needed
}
