/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.RoomTypeEntity;
import com.mycompany.spring_mvc_project_final.entities.UserEntity;
import com.mycompany.spring_mvc_project_final.enums.UserStatus;
import com.mycompany.spring_mvc_project_final.repository.RoomTypeRepository;
import com.mycompany.spring_mvc_project_final.repository.UserRepository;
import com.mycompany.spring_mvc_project_final.repository.UserRoleRepository;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

/**
 *
 * @author HMT
 */
@Service
public class UserService {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private RoomTypeRepository roomTypeRepository;
    
    public void save(UserEntity user){
       userRepository.save(user);
    }
     public UserEntity getUserByEmail(String email){
         return userRepository.findByEmailLikeAndStatusLike(email, UserStatus.ACTIVE);
     }
     
     public List<RoomTypeEntity> userGetRoomTypes(){
        return (List<RoomTypeEntity>) roomTypeRepository.findAll();
    }
     
      public UserEntity getUserEmail(String email){
          return userRepository.findByEmailLike(email);
      }
      public String getUserFullName(){
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        UserEntity user = userRepository.findByEmailLike(username);
        return user.getFullName();}
      
      public UserEntity getUserNow(){
          Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        UserEntity user = userRepository.findByEmailLike(username);
        return user;
      }
      
    public List<UserEntity> getAccounts() {
        return (List<UserEntity>) userRepository.findAll();
    }
    
    public UserEntity findUserById(int id) {
        Optional<UserEntity> optional = userRepository.findById(id);
        if(optional.isPresent()){
            return optional.get();
        }
        return new UserEntity();
    }
    
    public UserEntity getUser(String username) {
        return userRepository.findByEmailLike(username);
    }
    
    public Set<Integer> getAccRoleIdsByAccountId(int accountId) {
        return userRepository.findAccRoleIdsInRelationByAccountId(accountId);
    }
    
    public Set<String> getAccRoleNamesByAccountId(int accountId) {
        return userRepository.findAccRoleNamesInRelationByAccountId(accountId);
    }  
}
