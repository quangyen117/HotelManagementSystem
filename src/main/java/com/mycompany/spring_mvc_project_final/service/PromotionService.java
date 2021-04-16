/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.PromotionEntity;
import com.mycompany.spring_mvc_project_final.repository.PromotionRepository;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author HMT
 */
@Service
public class PromotionService {
    @Autowired
    private PromotionRepository promotionRepository;
    
    public List<Integer> getRoomTypeIdsInRelationByPromotionId(int promotionId) {
        return promotionRepository.findRoomTypeIdsInRelationByPromotionId(promotionId);
    }
    
    public List<String> getRoomTypesInRelationByPromotionId(int promotionId) {
        return promotionRepository.findRoomTypesInRelationByPromotionId(promotionId);
    }
    
    public List<PromotionEntity> getPromotions() {
        return (List<PromotionEntity>) promotionRepository.findAll();
    }
    
    public void save(PromotionEntity promotion) {
        promotionRepository.save(promotion);
    }
    
    public PromotionEntity findPromotionById(int id) {
        Optional<PromotionEntity> optional = promotionRepository.findById(id);
        if(optional.isPresent()){
            return optional.get();
        }
        return new PromotionEntity();
    }
}
