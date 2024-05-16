package com.carbon.server.repos;

import com.carbon.server.model.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends CrudRepository<User, Long> {
    // Additional query methods can be defined here if needed
}
