/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.RoomEntity;
import com.mycompany.spring_mvc_project_final.enums.BookingStatus;
import com.mycompany.spring_mvc_project_final.enums.RoomStatus;
import java.util.Date;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author HMT
 */
@Repository
public interface RoomRepository extends CrudRepository<RoomEntity, Integer> {
    List<RoomEntity> findByRoomTypeIdLikeAndStatusLike(int id, RoomStatus roomStatus);
    
    List<RoomEntity> findByStatusLike(RoomStatus roomStatus);
    
    
//    @Query(value ="select * from room r where r.id not in("
//            + "	select bd.room_id from booking_detail bd where bd.booking_id in ("
//            + "		select b.id from booking b "
//            + "		where (b.check_in >= ?1 and b.check_in < ?2)"
//            + "		Or (b.check_out > ?1 and b.check_out <= ?2)"
//            + "		or(b.check_in<=?1 and b.check_out >=?2)"
//            + ""
//            + "	))"
//            + " And r.status = ?3"  , nativeQuery = true)
//    List<RoomEntity> findRoomByDateInAndDateOut(Date dateIn, Date dateOut,RoomStatus roomStatus );
//  
    
    @Query(value ="select r.id from room r"
            + " join booking_detail bd on r.id=bd.room_id"
            + " join booking b on b.id = bd.booking_id"
            + " where"
            + " b.status not like 'CANCEL'"
            + " And ((b.check_in >= ?1 and b.check_in < ?2)"
            + "	Or (b.check_out > ?1 and b.check_out <= ?2)"
            + "	or(b.check_in<= ?1 and b.check_out >= ?2))", nativeQuery = true)
    List<Integer> findRoomByDateInAndDateOut(Date dateIn, Date dateOut);
    
    List<RoomEntity>findByIdNotInAndStatusLike(List<Integer> id,RoomStatus roomStatus);
    
    List<RoomEntity> findByIdLike(int id);
}
