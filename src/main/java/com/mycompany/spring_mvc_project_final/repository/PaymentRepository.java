/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.PaymentEntity;
import com.mycompany.spring_mvc_project_final.enums.PaymentStatus;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author HMT
 */
@Repository
public interface PaymentRepository extends CrudRepository<PaymentEntity, Integer> {
    
    @Query(value = "select * from payment p " 
            + " where booking_id = ?1 and status = ?2 ",nativeQuery = true)
    PaymentEntity findPaymentByBookingIdAndStatus(int id, String status);
    
    PaymentEntity findByBookingCodeLike(String code);
}
