/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.RoomEntity;
import com.mycompany.spring_mvc_project_final.enums.BookingStatus;
import com.mycompany.spring_mvc_project_final.enums.RoomStatus;
import com.mycompany.spring_mvc_project_final.repository.RoomRepository;
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
public class RoomService {

    @Autowired
    private RoomRepository roomRepository;

    public void save(RoomEntity room) {
        roomRepository.save(room);
    }

    public List<RoomEntity> findRoomsByRoomTypeId(int id, RoomStatus roomStatus) {
        return roomRepository.findByRoomTypeIdLikeAndStatusLike(id, roomStatus);
    }

    public List<RoomEntity> getRoomByStatus(RoomStatus roomStatus) {
        return (List<RoomEntity>) roomRepository.findByStatusLike(roomStatus);
    }

    public List<Integer> getIdRoomByInOut(Date dateIn, Date dateOut) {
        return roomRepository.findRoomByDateInAndDateOut(dateIn, dateOut);
    }

    public List<RoomEntity> getRoomNotInListId(List<Integer> id, RoomStatus roomStatus) {
        return roomRepository.findByIdNotInAndStatusLike(id, roomStatus);
    }

    public RoomEntity findRoomById(int id) {
        Optional<RoomEntity> optional
                = roomRepository.findById(id);
        if (optional.isPresent()) {
            return optional.get();
        }
        return new RoomEntity();
    }

    public boolean checkRoom(int id) {
        return roomRepository.existsById(id);
    }

    public void changeStatus(RoomEntity roomEntity) {
        roomRepository.save(roomEntity);
    }

    public List<RoomEntity> getRooms() {
        return (List<RoomEntity>) roomRepository.findAll();
    }
    
    public List<RoomEntity> findRoomInImageById(int id) {
        return roomRepository.findByIdLike(id);
    }
    
    public boolean deleteRoom(int id) {
        roomRepository.deleteById(id);
        return roomRepository.existsById(id);
    }
}
