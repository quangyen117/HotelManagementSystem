/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.UserRoleEntity;
import com.mycompany.spring_mvc_project_final.repository.UserRepository;
import com.mycompany.spring_mvc_project_final.repository.UserRoleRepository;
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
public class UserRoleService {

    @Autowired
    private UserRoleRepository userRoleRepository;
    
    public UserRoleEntity getUserRoleById(int id){
         Optional <UserRoleEntity>optional 
                = userRoleRepository.findById(id);
        if(optional.isPresent()){
            return optional.get();
        }
        return new UserRoleEntity();
    }
    
      public void save(UserRoleEntity userRole){
          userRoleRepository.save(userRole);
      } 
      
      public UserRoleEntity getRoleByStatus(Enum status){
          return userRoleRepository.findByRoleLike(status);
      }
      
      public List<UserRoleEntity> getAccRoles() {
        return (List<UserRoleEntity>) userRoleRepository.findAll();
    }
    
    public Set<UserRoleEntity> getAccRolesByAccRoleIds(List<Integer> accRoleIds) {
        return userRoleRepository.findAccRolesByAccRoleIds(accRoleIds);
    }
}
