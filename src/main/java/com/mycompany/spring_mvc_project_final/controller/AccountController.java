/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.entities.UserEntity;
import com.mycompany.spring_mvc_project_final.entities.UserRoleEntity;
import com.mycompany.spring_mvc_project_final.enums.Gender;
import com.mycompany.spring_mvc_project_final.enums.UserStatus;
import com.mycompany.spring_mvc_project_final.service.UserRoleService;
import com.mycompany.spring_mvc_project_final.service.UserService;
import com.mycompany.spring_mvc_project_final.utils.SecurityUtils;
import java.util.List;
import java.util.Set;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author USER
 */
@Controller
public class AccountController {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private UserRoleService userRoleService;
    
    @Autowired
    private BCryptPasswordEncoder encoder;
    
    @RequestMapping("/account/view-account")
    public String viewAccount(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("user", userService.getUser(username));
        model.addAttribute("roles", SecurityUtils.getRolesOfUser());
        model.addAttribute("accounts", userService.getAccounts());
        model.addAttribute("userService", userService);
        model.addAttribute("action", "view");
        return "manager/all_accounts";
    }
    
    @RequestMapping("/account/add-account")
    public String addAccount(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("user", userService.getUser(username));
        model.addAttribute("roles", SecurityUtils.getRolesOfUser());
        model.addAttribute("account", new UserEntity());
        model.addAttribute("userService", userService);
        model.addAttribute("statuses", UserStatus.values());
        model.addAttribute("accRoles", userRoleService.getAccRoles());
        model.addAttribute("gender", Gender.values());
        model.addAttribute("action", "add");
        return "manager/add_account";
    }
    
    @RequestMapping("/account/edit-account/{id}")
    public String addAccount(Model model,
            @PathVariable("id") int id) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("user", userService.getUser(username));
        model.addAttribute("roles", SecurityUtils.getRolesOfUser());
        model.addAttribute("userService", userService);
        model.addAttribute("account", userService.findUserById(id));
        model.addAttribute("statuses", UserStatus.values());
        model.addAttribute("accRoles", userRoleService.getAccRoles());
        model.addAttribute("gender", Gender.values());
        model.addAttribute("action", "edit");
        return "manager/add_account";
    }
    
    @RequestMapping(value = "/account/{action}", method = RequestMethod.POST)
    public String resultAccount(Model model,
            @Valid @ModelAttribute("account") UserEntity account,
            BindingResult result,
            @RequestParam("action") String action,
            @RequestParam(value = "accRoleIds", required = false) List<Integer> accRoleIds) {
        if (action.equals("edit")) {
            account.setPassword(userService.findUserById(account.getId()).getPassword());
        }
        userService.save(account);
        if (action.equals("add")) {
            account.setPassword(encoder.encode(account.getPassword()));
        }
        account.setUserRoles(userRoleService.getAccRolesByAccRoleIds(accRoleIds));
        userService.save(account);
        return "redirect:/account/view-account";
    }
    
    @RequestMapping("/account/change-password")
    public String changePasswordIndex(Model model) {
        model.addAttribute("accounts", userService.getAccounts());
        model.addAttribute("userService", userService);
        model.addAttribute("action", "changePass");
        return "manager/all_accounts";
    }
    
    @RequestMapping("/account/change-password/{id}")
    public String changePasswordPage(Model model,
            @PathVariable("id") int id) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("user", userService.getUser(username));
        model.addAttribute("roles", SecurityUtils.getRolesOfUser());
        model.addAttribute("account", userService.findUserById(id));
        return "manager/change_pass";        
    }
    
    @RequestMapping(value = "/account/change-password", method = RequestMethod.POST)
    public String changePasswordResult(Model model,
            @RequestParam("accountId") String accountId,
            @RequestParam("newPass") String newPass) {
        UserEntity account = userService.findUserById(Integer.parseInt(accountId));
        account.setPassword(encoder.encode(newPass));
        userService.save(account);
        return "redirect:/account/change-password";
    }
    
    @RequestMapping("/account/change-status/{id}")
    public String changeStatus(Model model,
            @PathVariable("id") int id) {
        UserEntity account = userService.findUserById(id);
        if (account.getStatus() == UserStatus.UNACTIVE) {
            account.setStatus(UserStatus.ACTIVE);
        } else {
            account.setStatus(UserStatus.UNACTIVE);
        }
        userService.save(account);
        return "redirect:/account/view-account";
    }
}
