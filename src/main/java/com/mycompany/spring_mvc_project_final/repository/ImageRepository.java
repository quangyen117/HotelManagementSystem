/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.ImageEntity;
import com.mycompany.spring_mvc_project_final.entities.RoomEntity;
import com.mycompany.spring_mvc_project_final.entities.RoomTypeEntity;
import java.util.Date;
import java.util.List;
import java.util.Set;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author HMT
 */
@Repository
public interface ImageRepository extends CrudRepository<ImageEntity, Integer> {
    
    @Query(value ="select name from image i"
              + " where room_type_id = ?1"
              + " limit 1", nativeQuery = true)
      String getImageByRoomType(int id);
    
    Set<ImageEntity> findByNameLike(String name);
    
    Set<ImageEntity> findByRoomTypeIn(Set<RoomTypeEntity> roomType);
}
