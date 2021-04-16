/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.BookingDetailEntity;
import com.mycompany.spring_mvc_project_final.entities.ServiceBookingEntity;
import com.mycompany.spring_mvc_project_final.repository.BookingDetailRepository;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author HMT
 */
@Service
public class BookingDetailService {
    @Autowired
    private BookingDetailRepository bookingDetailRepository;
    
    public void save(BookingDetailEntity booking){
       bookingDetailRepository.save(booking);
    }
    
    public List<BookingDetailEntity> getBookingDetailByBooking(int id){
        return bookingDetailRepository.findByBookingIdLike(id);
    }
    
    public void delete(BookingDetailEntity bookingdetail){
        bookingDetailRepository.delete(bookingdetail);
    }
    
    public List<BookingDetailEntity> getBookingDetails() {
        return (List<BookingDetailEntity>) bookingDetailRepository.findAll();
    }
    
    public BookingDetailEntity findBookingDetailById(int id) {
        Optional<BookingDetailEntity> optional = bookingDetailRepository.findById(id);
        if(optional.isPresent()){
            return optional.get();
        }
        return new BookingDetailEntity();
    }
    
    public boolean deleteBookingDetail(int id) {
        bookingDetailRepository.deleteById(id);
        return bookingDetailRepository.existsById(id);
    }
    
    public void deleteBookingDetailByBookingId(int id) {
        bookingDetailRepository.deleteAll(getBookingDetailsByBookingId(id));
    }
    
    public List<BookingDetailEntity> getBookingDetailsByBookingId(int bookingId) {
        return bookingDetailRepository.findBookindDetailsByBookingIdIn(bookingId);
    }
    
    public List<ServiceBookingEntity> getServiceBookingsByBookingDetailIds(List<Integer> bookingDetailIds) {
        return bookingDetailRepository.findServiceBookingsByBookingDetailIds(bookingDetailIds);
    }
}
