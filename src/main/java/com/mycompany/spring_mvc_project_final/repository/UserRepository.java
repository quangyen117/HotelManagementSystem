/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.UserEntity;
import com.mycompany.spring_mvc_project_final.enums.UserStatus;
import java.util.Set;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends CrudRepository<UserEntity, Integer> {

    UserEntity findByEmailLikeAndStatusLike(String email,
            UserStatus status);
    
    UserEntity findByEmailLike (String email);
    
    @Query(value = "select ur.id from user_role ur"
            + " join user_role_relationship urr on urr.role_id = ur.id "
            + " join `user` u on u.id = urr.user_id "
            + " where u.id = ?1", nativeQuery = true)
    Set<Integer> findAccRoleIdsInRelationByAccountId(int accountId);
    
    @Query(value = "select ur.role from user_role ur"
            + " join user_role_relationship urr on urr.role_id = ur.id "
            + " join `user` u on u.id = urr.user_id "
            + " where u.id = ?1", nativeQuery = true)
    Set<String> findAccRoleNamesInRelationByAccountId(int accountId);
}
