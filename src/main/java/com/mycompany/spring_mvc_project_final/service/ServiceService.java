/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.RoomEntity;
import com.mycompany.spring_mvc_project_final.entities.ServiceEntity;
import com.mycompany.spring_mvc_project_final.enums.RoomStatus;
import com.mycompany.spring_mvc_project_final.repository.ServiceRepository;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author HMT
 */
@Service
public class ServiceService {
    @Autowired
    private ServiceRepository serviceRepository;
    
     public List<ServiceEntity> getService(){
        return (List<ServiceEntity>) serviceRepository.findAll();
    }
     
     public List<ServiceEntity> getServices() {
        return (List<ServiceEntity>) serviceRepository.findAll();
    } 
     
     public ServiceEntity findServiceById(int id){
        Optional <ServiceEntity>optional = serviceRepository.findById(id);
        if(optional.isPresent()){
            return optional.get();
        }
        return new ServiceEntity();
    }
     
    public void save(ServiceEntity service) {
        serviceRepository.save(service);
    }
    
    public boolean deleteService(int id) {
        serviceRepository.deleteById(id);
        return serviceRepository.existsById(id);
    }
     
}
