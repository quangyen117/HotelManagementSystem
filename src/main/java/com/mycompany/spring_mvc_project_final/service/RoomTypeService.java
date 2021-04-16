/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.RoomTypeEntity;
import com.mycompany.spring_mvc_project_final.repository.RoomTypeRepository;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author HMT
 */
@Service
public class RoomTypeService {
    @Autowired
    private RoomTypeRepository roomTypeRepository;
    
    public List<RoomTypeEntity> getRoomTypes(){
        return (List<RoomTypeEntity>) roomTypeRepository.findAll();
    }
    
    public RoomTypeEntity findRoomTypeById(int id){
        Optional <RoomTypeEntity>optional 
                = roomTypeRepository.findById(id);
        if(optional.isPresent()){
            return optional.get();
        }
        return new RoomTypeEntity();
    }
    
    public RoomTypeEntity findByname(String name){
        return roomTypeRepository.findByNameLike(name);
    }
    
    public Integer DiscountByDate(int id, Date date){
        return roomTypeRepository.getDiscount(id, date);
    }
    
    public void save(RoomTypeEntity roomType){
        roomTypeRepository.save(roomType);
    }
    
    public Set<RoomTypeEntity> findRoomTypeInImageById(int id) {
        return roomTypeRepository.findByIdLike(id);
    }
    
    public Set<Integer> getConvenienceIdsInRelationByRoomTypeId(int roomTypeId) {
        return roomTypeRepository.findConvenienceIdsInRelationByRoomTypeId(roomTypeId);
    }
    
    public Set<String> getConveniencesInRelationByRoomTypeId(int roomTypeId) {
        return roomTypeRepository.findConveniencesInRelationByRoomTypeId(roomTypeId);
    }
    
    public Set<RoomTypeEntity> getRoomTypesByRoomTypeIds(List<Integer> roomTypeIds) {
        return roomTypeRepository.findRoomTypesByRoomTypeIds(roomTypeIds);
    }
}
