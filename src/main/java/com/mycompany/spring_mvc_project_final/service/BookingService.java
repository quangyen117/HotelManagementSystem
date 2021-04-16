/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.BookingEntity;
import com.mycompany.spring_mvc_project_final.repository.BookingRepository;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author HMT
 */
@Service
public class BookingService {
    @Autowired
    private BookingRepository bookingRepository;
    
     public void save(BookingEntity booking){
       bookingRepository.save(booking);
    }
     
     public BookingEntity getBookingByCode(String code){
         return bookingRepository.findByCodeLike(code);
     }
     
     public List<BookingEntity> getBookingByUserId(int userId){
         return bookingRepository.findByUserIdLike(userId);
     }
     
    public List<BookingEntity> getBookings() {
        return (List<BookingEntity>) bookingRepository.findAll();
    }
    
    public BookingEntity findBookingById(int id) {
        Optional<BookingEntity> optional = bookingRepository.findById(id);
        if(optional.isPresent()){
            return optional.get();
        }
        return new BookingEntity();
    }
    
    public boolean deleteBooking(int id) {
        bookingRepository.deleteById(id);
        return bookingRepository.existsById(id);
    }
    
    public List<BookingEntity> searchByDate(Date date1, Date date2) {
        return bookingRepository.findBByCheckInAndCheckOut(date1, date2);
    } 
}
