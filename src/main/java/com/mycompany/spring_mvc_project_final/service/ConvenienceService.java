/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.ConvenienceEntity;
import com.mycompany.spring_mvc_project_final.repository.ConvenienceRepository;
import java.util.List;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author HMT
 */
@Service
public class ConvenienceService {
    @Autowired
    private ConvenienceRepository convenienceRepository;
    
    public List<ConvenienceEntity> getConveniences() {
        return (List<ConvenienceEntity>) convenienceRepository.findAll();
    }
    
    public void save(ConvenienceEntity convenience) {
        convenienceRepository.save(convenience);
    }
    
    public Set<ConvenienceEntity> findByIdList(List<String> convenienceIds){
        return convenienceRepository.findAllByIdIn(convenienceIds);
    }
    
    public Set<ConvenienceEntity> getConveniencesByConvenienceIds(List<Integer> convenienceIds) {
        return convenienceRepository.findConveniencesByConvenienceIds(convenienceIds);
    }
}
