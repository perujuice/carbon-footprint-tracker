
package com.carbon.server.repos;

import com.carbon.server.model.Goal;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface GoalRepository extends CrudRepository<Goal, Long> {
    // Additional query methods can be defined here if needed
}

