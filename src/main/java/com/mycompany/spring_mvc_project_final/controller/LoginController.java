/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.entities.UserEntity;
import com.mycompany.spring_mvc_project_final.service.UserService;
import com.mycompany.spring_mvc_project_final.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author USER
 */
@Controller
public class LoginController {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private BCryptPasswordEncoder encoder;
    
    @RequestMapping(value = "/userProfile/change-password", method = RequestMethod.POST)
    public String changePasswordProfile(Model model,
            @RequestParam("oldPass") String oldPass,
            @RequestParam("newPass") String newPass) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        UserEntity account = userService.getUser(username);
        if (encoder.matches(oldPass, account.getPassword())) {
            account.setPassword(encoder.encode(newPass));
            userService.save(account);
            return "redirect:/login";
        } else {
            model.addAttribute("active2", "active");
            model.addAttribute("mes", "Your Current Password is incorrect");
            model.addAttribute("user", userService.getUser(username));
            model.addAttribute("roles", SecurityUtils.getRolesOfUser());
            return "profile";
        }
    }
    
     @RequestMapping("/userProfile")
    public String profile(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("user", userService.getUser(username));
        model.addAttribute("roles", SecurityUtils.getRolesOfUser());
        model.addAttribute("active1", "active");
        return "profile";
    }
    
}
