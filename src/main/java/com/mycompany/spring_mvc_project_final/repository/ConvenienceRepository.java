/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.ConvenienceEntity;
import java.util.List;
import java.util.Set;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author HMT
 */
@Repository
public interface ConvenienceRepository extends CrudRepository<ConvenienceEntity, Integer>, JpaRepository<ConvenienceEntity, Integer> {
    
    @Query(value = "select * from convenience c"
            + " where c.id in ?1", nativeQuery = true)
    public Set<ConvenienceEntity> findConveniencesByConvenienceIds(List<Integer> convenienceIds);
    
    Set<ConvenienceEntity> findAllByIdIn(List<String> convenienceIds);
}
