/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.ImageEntity;
import com.mycompany.spring_mvc_project_final.entities.RoomEntity;
import com.mycompany.spring_mvc_project_final.entities.RoomTypeEntity;
import com.mycompany.spring_mvc_project_final.repository.ImageRepository;
import java.util.List;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author HMT
 */
@Service
public class ImageService {
    @Autowired
    private ImageRepository imageRepository;
    
    public String getNameImageByRoomType(int id){
        return imageRepository.getImageByRoomType(id);
    }
    
    public void saveImage(ImageEntity image) {
        imageRepository.save(image);
    }
    
    public Set<ImageEntity> findImageByRoomType(Set<RoomTypeEntity> roomType) {
        return imageRepository.findByRoomTypeIn(roomType);
    }
    
    public void deleteImageByRoomType(Set<RoomTypeEntity> roomType) {
        imageRepository.deleteAll(findImageByRoomType(roomType));
    }
    
    public Set<ImageEntity> getImageNames(String name){
        return imageRepository.findByNameLike(name);
    } 
}
