/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.enums.BookingStatus;
import com.mycompany.spring_mvc_project_final.service.BookingDetailService;
import com.mycompany.spring_mvc_project_final.service.BookingService;
import com.mycompany.spring_mvc_project_final.service.ServiceBookingService;
import com.mycompany.spring_mvc_project_final.service.ServiceService;
import com.mycompany.spring_mvc_project_final.service.UserService;
import com.mycompany.spring_mvc_project_final.utils.SecurityUtils;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author USER
 */
@Controller
public class InformationController {

    @Autowired
    private BookingService bookingService;

    @Autowired
    private BookingDetailService bookingDetailService;

    @Autowired
    private ServiceBookingService serviceBookingService;

    @Autowired
    private ServiceService serviceService;
    
    @Autowired
    private UserService userService;

    @RequestMapping("/information/view-customer")
    public String viewCustomer(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("user", userService.getUser(username));
        model.addAttribute("roles", SecurityUtils.getRolesOfUser());
        model.addAttribute("bookings", bookingService.getBookings());
        model.addAttribute("statuses", BookingStatus.values());
        return "manager/all_customers";
    }

    @RequestMapping("/information/booking-history")
    public String bookingHistory(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("user", userService.getUser(username));
        model.addAttribute("roles", SecurityUtils.getRolesOfUser());
        model.addAttribute("bookings", bookingService.getBookings());
        model.addAttribute("statuses", BookingStatus.values());
        return "manager/booking_history";
    }

    @RequestMapping(value = "/information/search-by-date", method = RequestMethod.GET)
    public String searchByDate(Model model,
            @RequestParam("date1") String date1,
            @RequestParam("date2") String date2) throws ParseException {
        if (date1 == null || date2 == null) {
            return "redirect:/information/booking-history";
        } else {
            model.addAttribute("bookings", bookingService.searchByDate(new SimpleDateFormat("dd/MM/yyyy").parse(date1), new SimpleDateFormat("dd/MM/yyyy").parse(date2)));
            return "manager/booking_history";
        }
    }

    @RequestMapping("/information/history-detail/{id}")
    public String historyDetail(Model model,
            @PathVariable("id") int id) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("user", userService.getUser(username));
        model.addAttribute("roles", SecurityUtils.getRolesOfUser());
        Date checkOut = bookingService.findBookingById(id).getCheckOut();
        Date checkIn = bookingService.findBookingById(id).getCheckIn();
        long diffInMilliSeconds = checkOut.getTime() - checkIn.getTime();
        int days = (int) (diffInMilliSeconds / (24 * 60 * 60 * 1000));
        model.addAttribute("booking", bookingService.findBookingById(id));
        model.addAttribute("days", days);
        model.addAttribute("services", serviceService.getServices());
        model.addAttribute("statuses", BookingStatus.values());
        model.addAttribute("bookingDetails", bookingDetailService.getBookingDetailsByBookingId(id));
        model.addAttribute("serviceBookings", serviceBookingService.getServiceBookingsByBookingId(id));
        return "manager/history_detail";
    }
    
    
}
