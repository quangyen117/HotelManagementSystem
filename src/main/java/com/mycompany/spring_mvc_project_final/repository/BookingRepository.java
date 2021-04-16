/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.BookingEntity;
import java.util.Date;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

/**
 *
 * @author HMT
 */
@Repository
public interface BookingRepository extends CrudRepository< BookingEntity, Integer> {
    
    BookingEntity findByCodeLike(String code);
    
    List<BookingEntity> findByUserIdLike(int userId);
    
    @Query(value = "select * from booking b"
            + " where b.check_in and b.check_out between :date1  and :date2 ", nativeQuery = true)
    List<BookingEntity> findBByCheckInAndCheckOut(@Param("date1") Date date1, @Param("date2") Date date2);
}
