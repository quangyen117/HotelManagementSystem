/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.ServiceBookingEntity;
import com.mycompany.spring_mvc_project_final.entities.ServiceEntity;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author HMT
 */
@Repository
public interface ServiceRepository extends CrudRepository<ServiceEntity, Integer> {
    
    @Query(value = "select * from service_booking sb "
            + " join service s on sb.service_id = s.id "
            + " where s.id in ?1", nativeQuery = true)
    public ServiceBookingEntity findServiceBookingByServiceId(int serviceId);
}
