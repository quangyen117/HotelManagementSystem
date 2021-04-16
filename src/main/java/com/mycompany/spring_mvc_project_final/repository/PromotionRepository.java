/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.PromotionEntity;
import com.mycompany.spring_mvc_project_final.entities.RoomTypeEntity;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author HMT
 */
@Repository
public interface PromotionRepository extends CrudRepository<PromotionEntity, Integer> {
    
    @Query(value = "select rt.id from room_type rt"
            + " join room_type_promotion_relationship prt on prt.room_type_id = rt.id"
            + " join promotion p on p.id = prt.promotion_id"
            + " where p.id = ?1", nativeQuery = true)
    List<Integer> findRoomTypeIdsInRelationByPromotionId(int promotionId);
    
    @Query(value = "select rt.name from room_type rt"
            + " join room_type_promotion_relationship prt on prt.room_type_id = rt.id"
            + " join  promotion p on p.id = prt.promotion_id"
            + " where p.id = ?1", nativeQuery = true)
    List<String> findRoomTypesInRelationByPromotionId(int promotionId);
}
