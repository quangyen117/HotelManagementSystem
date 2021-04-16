/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.ServiceBookingEntity;
import com.mycompany.spring_mvc_project_final.repository.ServiceBookingRepository;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author HMT
 */
@Service
public class ServiceBookingService {
    @Autowired
    private ServiceBookingRepository serviceBookingRepository;
    
    public void save (ServiceBookingEntity serviceBookingEntity){
        serviceBookingRepository.save(serviceBookingEntity);
    }
    
    public List<ServiceBookingEntity> getServiceBookingByBookingDetail(int id){
        return serviceBookingRepository.findBybookingDetailIdLike(id);
    }
    
    public void delete(ServiceBookingEntity serviceBooking){
        serviceBookingRepository.delete(serviceBooking);
    }
    
    public List<ServiceBookingEntity> getServiceBookingsByBookingId(int bookingId) {
        return serviceBookingRepository.findServiceBookingsByBookingId(bookingId);
    }
    
    public ServiceBookingEntity findServiceBookingById(int id) {
        Optional<ServiceBookingEntity> optional = serviceBookingRepository.findById(id);
        if(optional.isPresent()){
            return optional.get();
        }
        return new ServiceBookingEntity();
    }
    
    public List<ServiceBookingEntity> findServiceBookingsByBookingId(int bookingId) {
        return serviceBookingRepository.findServiceBookingsByBookingId(bookingId);
    }
    
    public void saveAll(List<ServiceBookingEntity> bookingServices) {
        serviceBookingRepository.saveAll(bookingServices);
    }
    
    public void deleteById(int id) {
        serviceBookingRepository.deleteById(id);
    }
    
    public void deleteServiceBookingByBookingId(int id) {
        serviceBookingRepository.deleteAll(getServiceBookingsByBookingId(id));
    }
}
