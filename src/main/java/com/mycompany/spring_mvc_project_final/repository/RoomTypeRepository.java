/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.RoomTypeEntity;
import com.mycompany.spring_mvc_project_final.enums.RoomTypeStatus;
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
public interface RoomTypeRepository extends CrudRepository<RoomTypeEntity, Integer> {
      RoomTypeEntity  findByNameLike(String name);
      
      @Query(value ="select discount from promotion p"
              + " join  room_type_promotion_relationship rp on  p.id = rp.promotion_id"
              + " where rp.room_Type_id = ?1 and ?2 between p.start_date and p.end_date"
              + " and p.status like 'AVAILABLE'"
              + " limit 1", nativeQuery = true)
      Integer getDiscount(int id, Date date);

      @Query(value = "select c.id from convenience c"
            + " join room_type_convenience_relationship rtc on rtc.convenience_id = c.id"
            + " join room_type rt on rt.id = rtc.room_type_id"
            + " where rt.id = ?1", nativeQuery = true)
    Set<Integer> findConvenienceIdsInRelationByRoomTypeId(int roomTypeId);
    
    @Query(value = "select c.name from convenience c"
            + " join room_type_convenience_relationship rtc on rtc.convenience_id = c.id"
            + " join room_type rt on rt.id = rtc.room_type_id"
            + " where rt.id = ?1", nativeQuery = true)
    Set<String> findConveniencesInRelationByRoomTypeId(int roomTypeId);
    
    @Query(value = "select * from room_type rt"
            + " where rt.id in ?1", nativeQuery = true)
    Set<RoomTypeEntity> findRoomTypesByRoomTypeIds(List<Integer> roomTypeIds);
    
    Set<RoomTypeEntity> findByIdLike(int id);
}
