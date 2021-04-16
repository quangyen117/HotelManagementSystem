/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.entities.RoomTypeEntity;
import com.mycompany.spring_mvc_project_final.entities.UserEntity;
import com.mycompany.spring_mvc_project_final.entities.UserRoleEntity;
import com.mycompany.spring_mvc_project_final.enums.Gender;
import com.mycompany.spring_mvc_project_final.enums.Role;
import com.mycompany.spring_mvc_project_final.enums.RoomStatus;
import com.mycompany.spring_mvc_project_final.enums.UserStatus;
import static com.mycompany.spring_mvc_project_final.main.Main.encrytePassword;
import com.mycompany.spring_mvc_project_final.service.BookingService;
import com.mycompany.spring_mvc_project_final.service.ImageService;
import com.mycompany.spring_mvc_project_final.service.RoomService;
import com.mycompany.spring_mvc_project_final.service.RoomTypeService;
import com.mycompany.spring_mvc_project_final.service.UserRoleService;
import com.mycompany.spring_mvc_project_final.service.UserService;
import com.mycompany.spring_mvc_project_final.utils.SecurityUtils;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.concurrent.TimeUnit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HomeController {
    @Autowired
    private JavaMailSender mailSender;
    
    @Autowired
    private RoomService roomService;
    
    @Autowired
    private RoomTypeService roomTypeService;
   
    @Autowired
    private UserService userService;
    
    @Autowired
    private UserRoleService userRoleService;
    
    @Autowired
    private BCryptPasswordEncoder encoder;
    
    @Autowired
    private BookingService bookingService;
    
    @Autowired
    private ImageService imageService; 
    
    @InitBinder
    public void initBinder(WebDataBinder webDataBinder) {
        StringTrimmerEditor stringTrimerEditor = new StringTrimmerEditor(true);
        webDataBinder.registerCustomEditor(String.class, stringTrimerEditor);

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(true);
        webDataBinder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
    
    @RequestMapping(value = {"/", "/home"}, method = RequestMethod.GET)
    public String welcomePage(Model model) {
//        model.addAttribute("title", "Welcome");
//        model.addAttribute("message", "This is welcome page!");
        List<String> roles = SecurityUtils.getRolesOfUser();
        if (!CollectionUtils.isEmpty(roles) && (roles.contains("ROLE_ADMIN"))) {
             return "redirect:/account/view-account";}
            if (!CollectionUtils.isEmpty(roles) && (roles.contains("ROLE_RECEPTIONIST") 
                    || (roles.contains("ROLE_MANAGER")))) {
                return "redirect:/booking";
            }
        model.addAttribute("userService", userService);
        return "home";
    }
    
    @RequestMapping(value = "/about",method = RequestMethod.GET)
    public String aboutPage(Model model){
        model.addAttribute("userService", userService);
        return "about";
    }
    
    @RequestMapping(value = "/roomType1/{id}",method = RequestMethod.GET)
    public String aboutroomType1(Model model,
            @PathVariable("id") int id){
        model.addAttribute("userService", userService);
        model.addAttribute("roomType", roomTypeService.findRoomTypeById(id));
        return "roomType1";
    }
    
//    *********
     @RequestMapping(value = "/bookingInfo",method = RequestMethod.GET)
    public String adadadd(Model model){
        model.addAttribute("userService", userService);
        return "bookingInfo";
    }
    
    @RequestMapping(value = "/test",method = RequestMethod.GET)
    public String test(Model model){
        model.addAttribute("userService", userService);
        return "test";
    }
    
    @RequestMapping(value = "/roomType3",method = RequestMethod.GET)
    public String aboutroomType3(Model model){
        model.addAttribute("userService", userService);
        return "roomType3";
    }
    
    @RequestMapping(value = "/roomType2",method = RequestMethod.GET)
    public String aboutroomType2(Model model){
        model.addAttribute("userService", userService);
        return "roomType2";
    }
    
    @RequestMapping(value = "/blog",method = RequestMethod.GET)
    public String blogPage(Model model){
        model.addAttribute("userService", userService);
        return "blog";
    }
    
    @RequestMapping(value = "/booknow",method = RequestMethod.GET)
    public String booknowPage(Model model,
            @RequestParam(name = "mes",
                    required = false) String mes){
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String newdate = formatter.format(new Date());
        model.addAttribute("mes", mes);
        model.addAttribute("newdate", newdate);
//        model.addAttribute("roomType", roomTypeService.getRoomTypes());
        model.addAttribute("userService", userService);
        return "booknow";
    }
    
    @RequestMapping(value = "/contact",method = RequestMethod.GET)
    public String contactPage(Model model){
        model.addAttribute("userService", userService);
        return "contact";
    }
    
    @RequestMapping(value = "/rooms",method = RequestMethod.GET)
    public String roomsPage(Model model,
            @RequestParam(name = "searchCheckOut",
                    required = false) String dateOut,
            @RequestParam(name = "searchCheckIn",
                    required = false) String dateIn) throws ParseException{
        
        DateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");

        //Date currentDate = new Date();
              //PLus 24h
              Calendar cal = Calendar.getInstance();
              cal.setTime(new Date());
              cal.add(Calendar.HOUR, 24);

        Date date1 = null;
        Date date2 = null;

   
         // calculating the difference b/w startDate and endDate
         date1 = simpleDateFormat.parse(dateIn);
         date2 = simpleDateFormat.parse(dateOut);
         Date newdate = new Date();

         long getDiff = date2.getTime() - date1.getTime();

         // using TimeUnit class from java.util.concurrent package
         long noDay = TimeUnit.MILLISECONDS.toDays(getDiff);
        for(RoomTypeEntity room: roomTypeService.getRoomTypes()){
            if(roomTypeService.DiscountByDate(room.getId(), newdate)!=null){
                room.setDiscount(roomTypeService.DiscountByDate(room.getId(), newdate));
                roomTypeService.save(room);
            }
            else{
                room.setDiscount(0);
                roomTypeService.save(room);
            }
        }
        model.addAttribute("dateOut",dateOut);
        model.addAttribute("dateIn",dateIn);
        model.addAttribute("noDay",noDay);
         List<Integer> idRoom = roomService.getIdRoomByInOut(date1, date2);
         if(CollectionUtils.isEmpty(idRoom)){
             model.addAttribute("rooms",roomService.getRoomByStatus(RoomStatus.AVAILABLE));
         }
         else{
         model.addAttribute("rooms",roomService.getRoomNotInListId(idRoom, RoomStatus.AVAILABLE));
         }
         model.addAttribute("userService", userService);
         model.addAttribute("imageService", imageService);
         String newDate = simpleDateFormat.format(newdate);
            model.addAttribute("newDate", newDate);     
         return "rooms";       
    }
    
    @RequestMapping(value = "/stayandenjoy",method = RequestMethod.GET)
    public String stayandenjoyPage(Model model){
        model.addAttribute("userService", userService);
        return "stayandenjoy";
    }
    
    @RequestMapping(value = "/blog-single",method = RequestMethod.GET)
    public String blogsinglePage(Model model){
        model.addAttribute("userService", userService);
        return "blog-single";
    }
    
    @RequestMapping(value = "/register",method = RequestMethod.GET)
    public String registerPage(Model model,
            @RequestParam(name = "mes",
                    required = false) String mes){
        model.addAttribute("gender", Gender.values());
        model.addAttribute("status", UserStatus.ACTIVE);
//        model.addAttribute("role", Role.ROLE_USER);
          model.addAttribute("mes", mes);
//          model.addAttribute("user", new UserEntity());
        return "register";
    }
    
    
    @RequestMapping("/login")
    public String loginPage(Model model, @RequestParam(value = "error", required = false) boolean error) {
        if (error) {
            model.addAttribute("message", "Login Fail!!!");
        }
        return "login";
    }

    @RequestMapping("/403")
    public String accessDenied(Model model) {
        return "403Page";
    }
    
    @RequestMapping(value = "/search", method = RequestMethod.POST)
    public String searchRoom(Model model,
            @ModelAttribute("searchCheckIn") String searchCheckIn,
            @ModelAttribute("searchCheckOut") String searchCheckOut) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date checkIn = sdf.parse(searchCheckIn);
        Date checkOut = sdf.parse(searchCheckOut);
        Date newDate = sdf.parse(sdf.format(new Date()));  
        if(newDate.compareTo(checkIn)>0){
            String mes="Arrival Date Invalid";
                model.addAttribute("mes", mes);
                return "redirect:/booknow";
        }
                      
        else{
            if (checkIn.compareTo(checkOut) >= 0){
                String mes="Departure Date Invalid";
                model.addAttribute("mes", mes);
                return "redirect:/booknow";
        }
            
            
                    return "redirect:/rooms";
        }
        
    }
    
//    @RequestMapping(value = "/searchRoomType", method = RequestMethod.POST)
//    public String searchRoomType(Model model,
//            @ModelAttribute("roomTypeId") int idType,
//            @RequestParam(name = "searchCheckOut",
//                    required = false) String dateOut,
//            @RequestParam(name = "searchCheckIn",
//                    required = false) String dateIn) throws ParseException {
//        DateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
//
//        //Date currentDate = new Date();
//              //PLus 24h
//              Calendar cal = Calendar.getInstance();
//              cal.setTime(new Date());
//              cal.add(Calendar.HOUR, 24);
//
//        Date date1 = null;
//        Date date2 = null;
//
//   
//         // calculating the difference b/w startDate and endDate
//         date1 = simpleDateFormat.parse(dateIn);
//         date2 = simpleDateFormat.parse(dateOut);
//
//         long getDiff = date2.getTime() - date1.getTime();
//
//         // using TimeUnit class from java.util.concurrent package
//         long noDay = TimeUnit.MILLISECONDS.toDays(getDiff);
////        int idType = Integer.parseInt(idRoomType);
//        model.addAttribute("dateOut",dateOut);
//        model.addAttribute("dateIn",dateIn);
//        model.addAttribute("noDay",noDay);
//        model.addAttribute("roomType",roomTypeService.getRoomTypes());    
//        model.addAttribute("rooms", roomService.findRoomsByRoomTypeId(idType,RoomStatus.AVAILABLE));
//        return "rooms";
//    }
    
    @RequestMapping(value = "/newAccount", method = RequestMethod.POST)
    public String newAccount(Model model,
             @RequestParam(name = "fullName",
                    required = false) String fullName,
             @RequestParam(name = "email",
                    required = false) String email,
             @RequestParam(name = "password",
                    required = false) String password,
             @RequestParam(name = "phoneNumber",
                    required = false) String phoneNumber,
             @RequestParam(name = "address",
                    required = false) String address,
             @RequestParam(name = "birthDate",
                    required = false) Date birthDate,
             @RequestParam(name = "gender",
                    required = false) String gender)
    {
        UserEntity user = new UserEntity();
        
        if(userService.getUserByEmail(email)== null){
            user.setAddress(address);
            user.setFullName(fullName);
            user.setEmail(email);
            user.setStatus(UserStatus.ACTIVE);
            user.setGender(Gender.valueOf(gender));
            user.setBirthDate(birthDate);
            user.setPhoneNumber(phoneNumber);
        
            user.setPassword(encrytePassword(password));
            
            Set<UserRoleEntity> roles = new HashSet<>();
            UserRoleEntity role = userRoleService.getRoleByStatus(Role.ROLE_USER);
            roles.add(role);
            user.setUserRoles(roles);
            
            userService.save(user);
             //send bill to email
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(user.getEmail());
            message.setSubject("Luxury Hotel");
            message.setText("Hi,\n" 
                    +user.getEmail()
                    + ",\n"
                    + "You have just logged in on Luxury Hotel for the first time - the leading online hotel booking website in Vietnam.\n"
                    + "Account information:\n"
                    + "Login email: \n"
                    + user.getEmail()
                    +"\n"
                    + "Password:\n"
                    + password
                    + "\n"
                    + "Thank you for using our hotel services – Luxury Hotel.\n ");
            mailSender.send(message);
            return "redirect:/home";}
        else{
            String mes="Email exists";
            model.addAttribute("mes", mes);
            return "redirect:/register";
        }
    }
            
            @RequestMapping(value = "/profile",method = RequestMethod.GET)
    public String profilePage(Model model){
        //username
        
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }

        model.addAttribute("gender", Gender.values());

        model.addAttribute("user", userService.getUserEmail(username));
        model.addAttribute("userService", userService);
        return "user/profile";
    }
    
            
            @RequestMapping(value = "/editUser", method = RequestMethod.POST)
    public String newAccount(Model model,
             @ModelAttribute ("userEntity") UserEntity userEntity)
    {
        UserEntity user = userService.getUserEmail(userEntity.getEmail());
            user.setAddress(userEntity.getAddress());
            user.setFullName(userEntity.getFullName());
            user.setGender(userEntity.getGender());
            user.setBirthDate(userEntity.getBirthDate());
            user.setPhoneNumber(userEntity.getPhoneNumber());
        
            userService.save(user);
            
            int mesType=1;
            String mes = "Success! Your Profile has been updated.";
            model.addAttribute("mes", mes);
            model.addAttribute("mesType", mesType);
            model.addAttribute("userService", userService);
       return "Mess";
    }
    
     @RequestMapping(value = "/changePass",method = RequestMethod.GET)
    public String changePassPage(Model model,
            @RequestParam(name = "mes",
                    required =false ) String mes
            ){
//        //username
//        
//        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//        String username = principal.toString();
//        if (principal instanceof UserDetails) {
//            username = ((UserDetails) principal).getUsername();
//        }

//        model.addAttribute("user", userService.getUserByEmail(username));
        model.addAttribute("mes", mes);
        model.addAttribute("userService", userService);
        return "user/changePass";
    }
    
    
         @RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
    public String newAccount(Model model,
             @RequestParam(name = "nowpassword",
                    required = false) String nowpassword,
              @RequestParam(name = "newpassword",
                    required = false) String newpassword)
    {   
        //username
        
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        UserEntity user = userService.getUserByEmail(username);
        
        
         
        if(encoder.matches(nowpassword, user.getPassword())){
            user.setPassword(encoder.encode(newpassword));
            userService.save(user);
            
             //send bill to email
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(user.getEmail());
            message.setSubject("Luxury Hotel");
            message.setText("Hi,\n" 
                    +user.getEmail()
                    + ",\n"
                    + "Your Password has been updated in on Luxury Hotel - the leading online hotel booking website in Vietnam.\n"
                    + "Account information:\n"
                    + "Login email: \n"
                    + user.getEmail()
                    +"\n"
                    + "Password:\n"
                    + newpassword
                    + "\n"
                    + "Thank you for using our hotel services – Luxury Hotel.\n ");
            mailSender.send(message);
            
            int mesType=1;
            String mes = "Success! Your Password has been updated.";
            model.addAttribute("mes", mes);
            model.addAttribute("mesType", mesType);
            model.addAttribute("userService", userService);
       return "Mess";
        }
        else{
            String mes="Incorrect Current Password.";
            model.addAttribute("mes", mes);
        return "redirect:/changePass";    
        }       
    }
    
    @RequestMapping(value = "/bookingHistory", method = RequestMethod.GET)
    public String bookingHistoryPage(Model model
            ){
         model.addAttribute("booking",bookingService.getBookingByUserId(userService.getUserNow().getId()));
         model.addAttribute("userService", userService);
         return "user/bookingHistory";
    }
    
}