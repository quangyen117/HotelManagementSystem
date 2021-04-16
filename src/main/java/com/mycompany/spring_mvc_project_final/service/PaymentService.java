/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.PaymentEntity;
import com.mycompany.spring_mvc_project_final.repository.PaymentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author HMT
 */
@Service
public class PaymentService {
    
    @Autowired
    private PaymentRepository paymentRepository;
    
    public void save(PaymentEntity payment){
        paymentRepository.save(payment);
    }
    
    public PaymentEntity getPaymentByBooking(String code){
       return paymentRepository.findByBookingCodeLike(code);
        
    }
    
    public PaymentEntity getPaymentByBookingIdAndStatus(int id, String status) {
        return paymentRepository.findPaymentByBookingIdAndStatus(id, status);
    }
}
