/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.UserRoleEntity;
import java.util.List;
import java.util.Set;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRoleRepository extends CrudRepository<UserRoleEntity, Integer> {

    Set<UserRoleEntity> findByUsers_Email(String email);
    
    public UserRoleEntity findByRoleLike(Enum status);
    
    @Query(value = "select * from user_role ur"
            + " where ur.id in ?1", nativeQuery = true)
    Set<UserRoleEntity> findAccRolesByAccRoleIds(List<Integer> accRoleIds);
}
