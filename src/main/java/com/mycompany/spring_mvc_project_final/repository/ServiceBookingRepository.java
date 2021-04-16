/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.ServiceBookingEntity;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author HMT
 */
@Repository
public interface ServiceBookingRepository extends CrudRepository<ServiceBookingEntity, Integer> {
    
    List<ServiceBookingEntity> findBybookingDetailIdLike(int id);
    
    @Query(value = "select * from service_booking sb"
            + " join booking_detail bd on bd.id = sb.booking_detail_id"
            + " join booking b on b.id = bd.booking_id"
            + " where bd.booking_id = ?1", nativeQuery = true)
    List<ServiceBookingEntity> findServiceBookingsByBookingId(int bookingId);
}
