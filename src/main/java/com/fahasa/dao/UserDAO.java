package com.fahasa.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

import com.fahasa.model.Favorite;
import com.fahasa.model.User;

public interface UserDAO extends JpaRepository<User, Integer> {
 @Query("SELECT f " +
        "FROM Favorite f " +
        "LEFT JOIN FETCH f.book " +
        "LEFT JOIN FETCH f.schooltool " +
        "WHERE f.user.id = :userId")
List<Favorite> findFavoritesByUserId(@Param("userId") Integer userId);
}
