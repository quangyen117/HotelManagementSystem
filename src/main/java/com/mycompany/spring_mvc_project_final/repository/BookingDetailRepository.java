/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.BookingDetailEntity;
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
public interface BookingDetailRepository extends CrudRepository<BookingDetailEntity, Integer>  {
    
    List<BookingDetailEntity> findByBookingIdLike(int id);
    
    @Query("select bd from BookingDetailEntity bd"
            + " where bd.booking.id = ?1")
    List<BookingDetailEntity> findBookindDetailsByBookingIdIn(int bookingId);
    
    @Query(value = "select * from service_booking sb "
            + " join booking_detail bd on bd.id = sb.booking_detail_id "
            + " where bd.id in ?1", nativeQuery = true)
    public List<ServiceBookingEntity> findServiceBookingsByBookingDetailIds(List<Integer> bookingDetailIds);
}
