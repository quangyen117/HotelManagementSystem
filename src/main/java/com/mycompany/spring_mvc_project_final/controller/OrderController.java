/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.entities.BookingDetailEntity;
import com.mycompany.spring_mvc_project_final.entities.BookingEntity;
import com.mycompany.spring_mvc_project_final.entities.CreditCardEntity;
import com.mycompany.spring_mvc_project_final.entities.PaymentEntity;
import com.mycompany.spring_mvc_project_final.entities.RoomEntity;
import com.mycompany.spring_mvc_project_final.entities.ServiceBookingEntity;
import com.mycompany.spring_mvc_project_final.entities.ServiceEntity;
import com.mycompany.spring_mvc_project_final.enums.BookingStatus;
import com.mycompany.spring_mvc_project_final.enums.Gender;
import com.mycompany.spring_mvc_project_final.enums.PaymentStatus;
import com.mycompany.spring_mvc_project_final.enums.RoomStatus;
import com.mycompany.spring_mvc_project_final.enums.ServiceBookingStatus;
import com.mycompany.spring_mvc_project_final.service.BookingDetailService;
import com.mycompany.spring_mvc_project_final.service.BookingService;
import com.mycompany.spring_mvc_project_final.service.CreditCardService;
import com.mycompany.spring_mvc_project_final.service.PaymentService;
import com.mycompany.spring_mvc_project_final.service.RoomService;
import com.mycompany.spring_mvc_project_final.service.RoomTypeService;
import com.mycompany.spring_mvc_project_final.service.ServiceBookingService;
import com.mycompany.spring_mvc_project_final.service.ServiceService;
import com.mycompany.spring_mvc_project_final.service.UserService;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
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
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

/**
 *
 * @author HMT
 */
@SessionAttributes("cart")
@Controller
public class OrderController {
    
    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private RoomTypeService roomTypeService;

    @Autowired
    private RoomService roomService;

    @Autowired
    private BookingDetailService bookingDetailService;

    @Autowired
    private BookingService bookingService;

    @Autowired
    private ServiceService serviceService;

    @Autowired
    private ServiceBookingService serviceBookingService;
    
    @Autowired
    private CreditCardService creditCardService;
    
    @Autowired
    private PaymentService paymentService; 
    
    @Autowired
    private UserService userService; 

    @InitBinder
    public void initBinder(WebDataBinder webDataBinder) {
        StringTrimmerEditor stringTrimerEditor = new StringTrimmerEditor(true);
        webDataBinder.registerCustomEditor(String.class, stringTrimerEditor);

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(true);
        webDataBinder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    @ModelAttribute("cart")
    public HashMap<Integer, BookingDetailEntity> setCart() {
        return new HashMap<>();
    }

    @RequestMapping(value = "/order-rooms", method = RequestMethod.GET)
    public String orderRoomsPage(Model model,
            @ModelAttribute("cart") HashMap<Integer, BookingDetailEntity> bookingRooms,
            @RequestParam(name = "noDay",
                    required = false) String noDay,
            @RequestParam(name = "dateIn",
                    required = false) String dateIn,
            @RequestParam(name = "dateOut",
                    required = false) String dateOut) {
        model.addAttribute("noDay", noDay);
        model.addAttribute("dateIn", dateIn);
        model.addAttribute("dateOut", dateOut);
        model.addAttribute("cart", bookingRooms);
        model.addAttribute("userService", userService);
        DateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String newDate = simpleDateFormat.format(new Date());
            model.addAttribute("newDate", newDate);
        return "order-rooms";
    }

    @RequestMapping(value = "/choose/{id}", method = RequestMethod.GET)
    public String orderRoom(
            Model model,
            @ModelAttribute("cart") HashMap<Integer, BookingDetailEntity> bookingRooms,
            @PathVariable("id") int id,
            @ModelAttribute("dateIn") String dateIn,
            @ModelAttribute("dateOut") String dateOut,
            @ModelAttribute("noDay") String noDay) {

        if (CollectionUtils.isEmpty(bookingRooms)) {
            bookingRooms = new HashMap<>();
        }
        RoomEntity room = roomService.findRoomById(id);
        if (roomService.checkRoom(id)) {
            BookingDetailEntity bookingRoom = new BookingDetailEntity();
            bookingRoom.setRoom(room);
            bookingRooms.put(id, bookingRoom);
        }
        roomService.changeStatus(
                new RoomEntity(id,
                        roomService.findRoomById(id).getRoomNumber(),
                        roomService.findRoomById(id).getPrice(),
                        roomService.findRoomById(id).getNumberOfBed(),
                        RoomStatus.INPROGRESS,
                        roomService.findRoomById(id).getRoomType(),
                        roomService.findRoomById(id).getBookingDetails()));

        model.addAttribute("cart", bookingRooms);

        return "redirect:/order-rooms";
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    public String removeCartItem(
            Model model,
            @ModelAttribute("cart") HashMap<Integer, BookingDetailEntity> bookingRooms,
            @PathVariable("id") int id,
            @ModelAttribute("dateIn") String dateIn,
            @ModelAttribute("dateOut") String dateOut,
            @ModelAttribute("noDay") String noDay) {
        roomService.changeStatus(
                new RoomEntity(id,
                        roomService.findRoomById(id).getRoomNumber(),
                        roomService.findRoomById(id).getPrice(),
                        roomService.findRoomById(id).getNumberOfBed(),
                        RoomStatus.AVAILABLE,
                        roomService.findRoomById(id).getRoomType(),
                        roomService.findRoomById(id).getBookingDetails()));
        bookingRooms.remove(id);
        model.addAttribute("cart", bookingRooms);
        return "redirect:/order-rooms";
    }
    
    @RequestMapping(value = "/deleteService/{id}/{serviceId}", method = RequestMethod.GET)
    public String removeServiceItem(
            Model model,
            @ModelAttribute("cart") HashMap<Integer, BookingDetailEntity> bookingRooms,
            @PathVariable("id") int id,
            @ModelAttribute("dateIn") String dateIn,
            @ModelAttribute("dateOut") String dateOut,
            @ModelAttribute("noDay") String noDay,
            @PathVariable("serviceId")int serviceId) {
        List<ServiceEntity> list= bookingRooms.get(id).getServiceEntity();
        if(list.size()!=1){
        List<ServiceEntity> list2= new ArrayList<>();
            for(ServiceEntity sv: list){
            if(sv.getId()!=serviceId){
                list2.add(sv);
                }
            }
        BookingDetailEntity bookingRoom=new BookingDetailEntity(roomService.findRoomById(id), list2);
        bookingRooms.put(id, bookingRoom);
        }
        else{
             BookingDetailEntity bookingRoom = new BookingDetailEntity();
            bookingRoom.setRoom(roomService.findRoomById(id));
            bookingRooms.put(id, bookingRoom);
        }
        model.addAttribute("cart", bookingRooms);
        return "redirect:/order-rooms";
    }
    
    @RequestMapping(value = "/addService/{id}", method = RequestMethod.GET)
    public String addService(
            Model model,
            @PathVariable("id") int id,
            @RequestParam(name = "noDay",
                    required = false) String noDay,
            @RequestParam(name = "dateIn",
                    required = false) String dateIn,
            @RequestParam(name = "dateOut",
                    required = false) String dateOut) {
        model.addAttribute("bookingDetail", new BookingDetailEntity());
        model.addAttribute("service", serviceService.getService());
        model.addAttribute("noDay", noDay);
        model.addAttribute("dateIn", dateIn);
        model.addAttribute("dateOut", dateOut);
        model.addAttribute("userService", userService);
        DateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String newDate = simpleDateFormat.format(new Date());
            model.addAttribute("newDate", newDate);
        return "addService";
    }

    @RequestMapping(value = "/addSer", method = RequestMethod.POST)
    public String addSer(Model model,
            @ModelAttribute("id_rooms") int id,
            @ModelAttribute("bookingDetail") BookingDetailEntity bookingDetail,
            @ModelAttribute("cart") HashMap<Integer, BookingDetailEntity> bookingRooms,
            @ModelAttribute("dateIn") String dateIn,
            @ModelAttribute("dateOut") String dateOut,
            @ModelAttribute("noDay") String noDay) {
            RoomEntity room = roomService.findRoomById(id);
            
        
            List<ServiceEntity> list = new ArrayList<>();
            for(Integer sv: bookingDetail.getServices()){
                list.add(serviceService.findServiceById(sv));
            }
            BookingDetailEntity bookingRoom=new BookingDetailEntity(room, list);
            bookingRooms.put(id, bookingRoom);
         model.addAttribute("cart", bookingRooms);
         model.addAttribute("noDay", noDay);
        model.addAttribute("dateIn", dateIn);
        model.addAttribute("dateOut", dateOut);
        return "redirect:/order-rooms";
    }
    
    @RequestMapping(value = "/confirm", method = RequestMethod.GET)
    public String confirmBookingPage(Model model,
            @ModelAttribute("cart") HashMap<Integer, BookingDetailEntity> bookingRooms,
            @RequestParam(name = "noDay",
                    required = false) String noDay,
            @RequestParam(name = "dateIn",
                    required = false) String dateIn,
            @RequestParam(name = "dateOut",
                    required = false) String dateOut) {
        if (CollectionUtils.isEmpty(bookingRooms)) {
             model.addAttribute("noDay", noDay);
            model.addAttribute("dateIn", dateIn);
             model.addAttribute("dateOut", dateOut); 
            return "redirect:/order-rooms";}
        else{
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String newdate = formatter.format(new Date());
        model.addAttribute("newdate", newdate);
        model.addAttribute("noDay", noDay);
        model.addAttribute("dateIn", dateIn);
        model.addAttribute("dateOut", dateOut);
        model.addAttribute("cart", bookingRooms);
        model.addAttribute("bookingStatus", BookingStatus.INPROGRESS);
        model.addAttribute("code", RandomStringUtils.randomNumeric(4));
        model.addAttribute("gender", Gender.values());
        model.addAttribute("userService", userService);
        return "confirm";}
    }
    
     @RequestMapping(value = "/creditCard",method = RequestMethod.GET)
    public String creditCardPage(Model model,
            @RequestParam(name = "code",
                    required =true ) String code,
            @RequestParam(name = "mes",
                    required =false ) String mes
            ){
         model.addAttribute("code", code);
         model.addAttribute("mes", mes);
         model.addAttribute("userService", userService);
        return "creditCard";
    }
    
    @RequestMapping(value = "/form", method = RequestMethod.POST)
     public String formConfirm (Model model,
             @ModelAttribute("booking") BookingEntity booking
             
             )
     {
         bookingService.save(booking);
         model.addAttribute("code", booking.getCode());
         
         return "redirect:/creditCard";
     }
     
    @RequestMapping(value = "/pay", method = RequestMethod.POST)
    public String formConfirm (Model model,
             @RequestParam(name = "name",
                    required = false) String name,
             @RequestParam(name = "cardNumber",
                    required = false) String cardNumber,
             @RequestParam(name = "monthExp",
                    required = false) String monthExp,
             @RequestParam(name = "yearExp",
                    required = false) String yearExp,
             @RequestParam(name = "cvcCode",
                    required = false) int cvcCode,
               @SessionAttribute("cart") HashMap<Integer, BookingDetailEntity> bookingRooms,
               @RequestParam(name = "code",
                    required = false) String code,
              SessionStatus sessionStatus
                
             ) throws ParseException
    {   
        String mes = new String();
        CreditCardEntity credit = new CreditCardEntity();
        credit.setCardNumber(cardNumber);
        credit.setName(name);
        credit.setCvcCode(cvcCode);
        DateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date expDate = simpleDateFormat.parse(yearExp.concat("-").concat(monthExp).concat("-01"));
        credit.setExpDate(expDate);
        if(creditCardService.checkCardNumber(credit.getCardNumber())){
            CreditCardEntity crd = creditCardService.getCreditCardByCardNumber(credit.getCardNumber());
            if(!crd.getName().equals(credit.getName())){
                mes="CreditCard is invalid!1";
                model.addAttribute("mes", mes);
                model.addAttribute("code", code);
                return "redirect:/creditCard";
            }
            if(!crd.getExpDate().equals(credit.getExpDate())){
                mes="CreditCard is invalid!2";
                model.addAttribute("mes", mes);
                model.addAttribute("code", code);
                return "redirect:/creditCard";
            }
            if(crd.getCvcCode()!=(credit.getCvcCode())){
                mes="CreditCard is invalid!3";
                    model.addAttribute("mes", mes);
                    model.addAttribute("code", code);
                    return "redirect:/creditCard";
            }
            
            
            BookingEntity booking = bookingService.getBookingByCode(code);
            
            if(crd.getBalance()< booking.getTotalPrice()){
                mes="Your Balance isn't enough !";
                model.addAttribute("code", code);
                model.addAttribute("mes", mes);
                    return "redirect:/creditCard";
            }
            booking.setStatus(BookingStatus.BOOKED);
            bookingService.save(booking);
            creditCardService.changeBalance(booking.getTotalPrice(), crd);
            PaymentEntity payment = new PaymentEntity();
            payment.setAmount(booking.getTotalPrice());
            Date newdate = new Date();
            payment.setPaymentDate(newdate);
            payment.setStatus(PaymentStatus.COMPLETED);
            payment.setBooking(booking);
            payment.setCreditCard(crd);
            paymentService.save(payment);
            
            
            for (Map.Entry<Integer, BookingDetailEntity> entry : bookingRooms.entrySet()) {

                BookingDetailEntity bookingDetail = new BookingDetailEntity();
                bookingDetail.setBooking(booking);
                bookingDetail.setPrice(entry.getValue().getRoom().getPrice());
                bookingDetail.setDiscount(entry.getValue().getRoom().getRoomType().getDiscount());
                bookingDetail.setRoom(entry.getValue().getRoom());
                bookingDetail.setServiceEntity(entry.getValue().getServiceEntity());
                bookingDetailService.save(bookingDetail);
                RoomEntity room = entry.getValue().getRoom();
                room.setStatus(RoomStatus.AVAILABLE);
                roomService.save(room);
                
                if(entry.getValue().getServiceEntity()!=null){
                    for(ServiceEntity sr: entry.getValue().getServiceEntity()){
                        ServiceBookingEntity serviceBooking = new ServiceBookingEntity();
                        serviceBooking.setServiceBookingDate(booking.getBookingDate());
                        serviceBooking.setBookingDetail(bookingDetail);
                        serviceBooking.setQuantity(bookingDetail.getRoom().getRoomType().getCapacity());
                        serviceBooking.setService(sr);
                        serviceBooking.setPrice(sr.getPrice());
                        serviceBooking.setStatus(ServiceBookingStatus.PAID);
                        serviceBookingService.save(serviceBooking);
                        }
                    
                }
                
            }
            sessionStatus.setComplete();
            
            
            model.addAttribute("booking", booking );
            model.addAttribute("bookingDetail",bookingDetailService.getBookingDetailByBooking(booking.getId()));
            model.addAttribute("serviceBookingService", serviceBookingService);
            
            
             //send bill to email
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(booking.getEmail());
            message.setSubject("Luxury Hotel");
            message.setText("Dear\n" 
                    + booking.getFullName()
                    + ",\n"
                    + "Thank you for using our hotel service – Luxury Hotel.\n"
                    + "This is your Booking :"
                    + "http://localhost:8080/Spring_MVC_Project_Final/Bill/"
                    + booking.getCode() +"\n"
                    + "Hope to see you at our hotel\n"
                    + "Yours sincerely.");
            mailSender.send(message);
            model.addAttribute("userService", userService);
            return "bookingInfo";
         
        }
        mes="Card number is invalid!";
        model.addAttribute("mes", mes);
        model.addAttribute("code", code);
        model.addAttribute("userService", userService);
        return "redirect:/creditCard";
    }
    @RequestMapping(value = "/Bill/{code}", method = RequestMethod.GET)
    public String billPage(
            Model model,
            @PathVariable("code") String code
    ) {
        
        BookingEntity booking = bookingService.getBookingByCode(code);
         model.addAttribute("booking", booking );
         model.addAttribute("bookingDetail",bookingDetailService.getBookingDetailByBooking(booking.getId()));
         model.addAttribute("serviceBookingService", serviceBookingService);
         model.addAttribute("userService", userService);
        return "Bill";
    }
    
    @RequestMapping(value = "/cancel-booking/{code}", method = RequestMethod.GET)
    public String deleteBooking(
            Model model,
            @PathVariable("code") String code
            ) throws ParseException{
        
        BookingEntity booking = bookingService.getBookingByCode(code);
        int mesType;
        String mes=new String();
        
        DateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");

        //Date currentDate = new Date();
              //PLus 24h
              Calendar cal = Calendar.getInstance();
              cal.setTime(new Date());
              cal.add(Calendar.HOUR, 24);

        Date newDate = simpleDateFormat.parse(simpleDateFormat.format(new Date())); 
        Date dateCheckIn = simpleDateFormat.parse(simpleDateFormat.format(booking.getCheckIn())); 
        Date dateBooking = simpleDateFormat.parse(simpleDateFormat.format(booking.getBookingDate())); 
        
//        checkin quá hạng
        if(dateCheckIn.getTime() - newDate.getTime()<0){
            mesType=0;
            mes = "Your Booking is out of date to cancel.";
            model.addAttribute("mes", mes);
            model.addAttribute("mesType", mesType);
            model.addAttribute("userService", userService);
            return "Mess";
        }
//           checkin dưới 3 ngày
        if(dateCheckIn.getTime() - newDate.getTime()<3*24*60*60*1000){
//            bookingdate quá 24h
            if(newDate.getTime() - dateBooking.getTime() > 24*60*60*1000){
            mesType=0;
            mes = "Your Booking is out of date to cancel.";
            model.addAttribute("mes", mes);
            model.addAttribute("mesType", mesType);
            model.addAttribute("userService", userService);
            return "Mess";
            }
            else{
                if(!booking.getStatus().equals(BookingStatus.BOOKED)){
                mesType=0;
                mes = "Your Booking can't cancel.";
                model.addAttribute("mes", mes);
                model.addAttribute("mesType", mesType);
                 model.addAttribute("userService", userService);
                return "Mess";}
                else{
                        for(BookingDetailEntity bkd: bookingDetailService.getBookingDetailByBooking(booking.getId()))
                        {    
                            if(!CollectionUtils.isEmpty(serviceBookingService.getServiceBookingByBookingDetail(bkd.getId()))){
                            for(ServiceBookingEntity svb: serviceBookingService.getServiceBookingByBookingDetail(bkd.getId())){
                                svb.setStatus(ServiceBookingStatus.CANCEL);
                                serviceBookingService.save(svb);
                            }
                            }
                        }
                        booking.setStatus(BookingStatus.CANCEL);
                        bookingService.save(booking);

                        PaymentEntity payment= paymentService.getPaymentByBooking(code);
                        payment.setStatus(PaymentStatus.REFUND);
                        paymentService.save(payment);

                        CreditCardEntity credit= creditCardService.getCreditCardByPayment(payment.getId());
                        credit.setBalance(credit.getBalance()+ (payment.getAmount()*90/100));
                         creditCardService.save(credit);

                             mesType=1;
                             mes = "Success! Your Booking has been cancelled.";
                             model.addAttribute("mes", mes);
                             model.addAttribute("mesType", mesType);
                             model.addAttribute("userService", userService);
                             
                             SimpleMailMessage message = new SimpleMailMessage();
                             
                             Locale localeVN = new Locale("vi", "VN");
                            NumberFormat currencyVN = NumberFormat.getCurrencyInstance(localeVN);
                            String str = currencyVN.format(booking.getTotalPrice()*0.9);
                            String priceRefund = str.replace(str.substring(str.length()-1), "");
                             
                            message.setTo(booking.getEmail());
                            message.setSubject("Luxury Hotel");
                            message.setText("Dear\n" 
                                    + booking.getFullName()
                                    + ",\n"
                                    + "Thank you for using our hotel services – Luxury Hotel.\n"
                                    + "The Booking Code " + booking.getCode() 
                                    + " was successfully canceled.\n"
                                    + "You will be refunded 90% of the total amount of your booking is: "
                                    + priceRefund
                                    + "VND.\n"
                                    + "We hope to see you again");
                            mailSender.send(message);
                        return "Mess";
                    }    
                }
            }    
        else{
            if(!booking.getStatus().equals(BookingStatus.BOOKED)){
                mesType=0;
                mes = "Your Booking can't cancel.";
                model.addAttribute("mes", mes);
                model.addAttribute("mesType", mesType);
                 model.addAttribute("userService", userService);
                return "Mess";}
            else{
                for(BookingDetailEntity bkd: bookingDetailService.getBookingDetailByBooking(booking.getId()))
                {    
                    if(!CollectionUtils.isEmpty(serviceBookingService.getServiceBookingByBookingDetail(bkd.getId()))){
                    for(ServiceBookingEntity svb: serviceBookingService.getServiceBookingByBookingDetail(bkd.getId())){
                        svb.setStatus(ServiceBookingStatus.CANCEL);
                        serviceBookingService.save(svb);
                    }
                    }
                }
                booking.setStatus(BookingStatus.CANCEL);
                bookingService.save(booking);

                PaymentEntity payment= paymentService.getPaymentByBooking(code);
                payment.setStatus(PaymentStatus.REFUND);
                paymentService.save(payment);

                CreditCardEntity credit= creditCardService.getCreditCardByPayment(payment.getId());
                credit.setBalance(credit.getBalance()+ (payment.getAmount()*90/100));
                 creditCardService.save(credit);

                     mesType=1;
                     mes = "Success! Your Booking has been cancelled.";
                     model.addAttribute("mes", mes);
                     model.addAttribute("mesType", mesType);
                     model.addAttribute("userService", userService);
                     
                     
                     SimpleMailMessage message = new SimpleMailMessage();
                            message.setTo(booking.getEmail());
                            message.setSubject("Luxury Hotel");
                            message.setText("Dear\n" 
                                    + booking.getFullName()
                                    + ",\n"
                                    + "Thank you for using our hotel services – Luxury Hotel.\n"
                                    + "The Booking Code " + booking.getCode() 
                                    + " was successfully canceled.\n"
                                    + "You will be refunded 90% of the total amount of your booking is: "
                                    + booking.getTotalPrice()*0.9
                                    + "VND.\n"
                                    + "We hope to see you again \n."
                                    + "Thank you very much.");
                            mailSender.send(message);
                return "Mess";
                }
        }
    }
    
//    @RequestMapping(value = "/Mess",method = RequestMethod.GET)
//    public String messPage(Model model)
//            {
//                return "Mess";
//    }
    
       @RequestMapping(value = "/confirm1", method = RequestMethod.GET)
    public String confirmBookingUserPage(Model model,
            @ModelAttribute("cart") HashMap<Integer, BookingDetailEntity> bookingRooms,
            @RequestParam(name = "noDay",
                    required = false) String noDay,
            @RequestParam(name = "dateIn",
                    required = false) String dateIn,
            @RequestParam(name = "dateOut",
                    required = false) String dateOut) {
        if (CollectionUtils.isEmpty(bookingRooms)) {
             model.addAttribute("noDay", noDay);
            model.addAttribute("dateIn", dateIn);
             model.addAttribute("dateOut", dateOut); 
            return "redirect:/order-rooms";}
        else{
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String newdate = formatter.format(new Date());
        model.addAttribute("newdate", newdate);
        model.addAttribute("noDay", noDay);
        model.addAttribute("dateIn", dateIn);
        model.addAttribute("dateOut", dateOut);
        model.addAttribute("cart", bookingRooms);
        model.addAttribute("bookingStatus", BookingStatus.INPROGRESS);
        model.addAttribute("code", RandomStringUtils.randomNumeric(4));
        model.addAttribute("gender", Gender.values());
               //username
        
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
       String username = principal.toString();
      if (principal instanceof UserDetails) {
           username = ((UserDetails) principal).getUsername();
       }

       model.addAttribute("user", userService.getUserByEmail(username));
       model.addAttribute("userService", userService);
        return "user/confirm";
        }
    }
}
