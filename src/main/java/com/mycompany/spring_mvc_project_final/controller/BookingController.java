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
import com.mycompany.spring_mvc_project_final.entities.ServiceBookingEntity;
import com.mycompany.spring_mvc_project_final.entities.ServiceEntity;
import com.mycompany.spring_mvc_project_final.enums.BookingStatus;
import com.mycompany.spring_mvc_project_final.enums.PaymentStatus;
import com.mycompany.spring_mvc_project_final.enums.ServiceBookingStatus;
import com.mycompany.spring_mvc_project_final.service.BookingDetailService;
import com.mycompany.spring_mvc_project_final.service.BookingService;
import com.mycompany.spring_mvc_project_final.service.CreditCardService;
import com.mycompany.spring_mvc_project_final.service.PaymentService;
import com.mycompany.spring_mvc_project_final.service.RoomService;
import com.mycompany.spring_mvc_project_final.service.ServiceBookingService;
import com.mycompany.spring_mvc_project_final.service.ServiceService;
import com.mycompany.spring_mvc_project_final.service.UserService;
import com.mycompany.spring_mvc_project_final.utils.SecurityUtils;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
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
public class BookingController {

    @Autowired
    private JavaMailSender mailSender;
    
    @Autowired
    private BookingService bookingService;

    @Autowired
    private BookingDetailService bookingDetailService;

    @Autowired
    private ServiceBookingService serviceBookingService;

    @Autowired
    private ServiceService serviceService;

    @Autowired
    private RoomService roomService;

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private CreditCardService creditCardService;
    
    @Autowired
    private UserService userService;

    @InitBinder
    public void initBinder(WebDataBinder webDataBinder) {
        StringTrimmerEditor stringTrimerEditor = new StringTrimmerEditor(true);
        webDataBinder.registerCustomEditor(String.class, stringTrimerEditor);
    }

    @RequestMapping(value = {"/booking"}, method = RequestMethod.GET)
    public String bookingPage(Model model,
            @RequestParam(name = "mes", required = false) String mes,
            @RequestParam(name = "mesType", required = false) String mesType) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("user", userService.getUser(username));
        model.addAttribute("roles", SecurityUtils.getRolesOfUser());
        model.addAttribute("mes", mes);
        model.addAttribute("mesType", mesType);
        model.addAttribute("bookings", bookingService.getBookings());
        model.addAttribute("rooms", roomService.getRooms());
        model.addAttribute("statuses", BookingStatus.values());
        return "manager/booking";
    }

    @RequestMapping("/booking/booking-detail/{id}")
    public String bookingDetail(Model model,
            @PathVariable("id") int id) {
        Date checkOut = bookingService.findBookingById(id).getCheckOut();
        Date checkIn = bookingService.findBookingById(id).getCheckIn();
        Date now = new Date();
        long diffInMilliSeconds1 = checkOut.getTime() - checkIn.getTime();
        long diffInMilliSeconds2 = checkIn.getTime() - now.getTime();
        int days1 = (int) (diffInMilliSeconds1 / (24 * 60 * 60 * 1000));
        int days2 = (int) (diffInMilliSeconds2 / (24 * 60 * 60 * 1000));
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("user", userService.getUser(username));
        model.addAttribute("roles", SecurityUtils.getRolesOfUser());
        model.addAttribute("booking", bookingService.findBookingById(id));
        model.addAttribute("days", days1);
        model.addAttribute("check", days2);
        model.addAttribute("services", serviceService.getServices());
        model.addAttribute("statuses", BookingStatus.values());
        model.addAttribute("bookingDetails", bookingDetailService.getBookingDetailsByBookingId(id));
        model.addAttribute("serviceBookings", serviceBookingService.getServiceBookingsByBookingId(id));
        return "manager/booking_detail";
    }

    @RequestMapping(value = "/booking/add-service", method = RequestMethod.POST)
    public String addService(Model model,
            @ModelAttribute("bookingDetail") BookingDetailEntity bookingDetailEntity,
            @RequestParam(value = "bookingDetailId", required = false) int bookingDetailId,
            @RequestParam(value = "quantity", required = false) int quantity,
            @RequestParam(value = "serviceBookingDate", required = false) String date) throws ParseException {
        List<ServiceBookingEntity> serviceBookings = new ArrayList<>();
        ServiceBookingEntity sB = new ServiceBookingEntity();
        BookingDetailEntity bookingDetail = bookingDetailService.findBookingDetailById(bookingDetailId);
        for (int id : bookingDetailEntity.getServiceIds()) {
            ServiceEntity service = serviceService.findServiceById(id);
            ServiceBookingEntity serviceBooking = new ServiceBookingEntity();
            serviceBooking.setBookingDetail(bookingDetail);
            serviceBooking.setService(service);
            serviceBooking.setPrice(service.getPrice());
            serviceBooking.setServiceBookingDate(new SimpleDateFormat("dd/MM/yyyy").parse(date));
            serviceBooking.setQuantity(quantity);
            serviceBooking.setStatus(ServiceBookingStatus.UNPAID);
            for (ServiceBookingEntity sb : serviceBookingService.getServiceBookingsByBookingId(bookingDetail.getBooking().getId())) {
                if (serviceBooking.getService().getId() == sb.getService().getId() && serviceBooking.getBookingDetail().getId() == sb.getBookingDetail().getId() && serviceBooking.getServiceBookingDate().equals(sb.getServiceBookingDate()) && serviceBooking.getStatus() == ServiceBookingStatus.UNPAID) {
                    serviceBooking = sb;
                    serviceBooking.setQuantity(serviceBooking.getQuantity() + quantity);
                    sB = serviceBooking;
                } else {
                    sB = serviceBooking;
                }
            }
            serviceBookings.add(sB);
        }
        serviceBookingService.saveAll(serviceBookings);
        return "redirect:/booking/booking-detail/" + bookingDetail.getBooking().getId();
    }

    @RequestMapping(value = "/booking/search-by-date", method = RequestMethod.GET)
    public String searchByDate(Model model,
            @RequestParam("date1") String date1,
            @RequestParam("date2") String date2) throws ParseException {
        if (date1 == null || date2 == null) {
            return "redirect:/booking";
        } else {
            model.addAttribute("bookings", bookingService.searchByDate(new SimpleDateFormat("dd/MM/yyyy").parse(date1), new SimpleDateFormat("dd/MM/yyyy").parse(date2)));
            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            String username = principal.toString();
            if (principal instanceof UserDetails) {
                username = ((UserDetails) principal).getUsername();
            }
            model.addAttribute("user", userService.getUser(username));
            model.addAttribute("roles", SecurityUtils.getRolesOfUser());
            model.addAttribute("rooms", roomService.getRooms());
            return "manager/booking";
        }
    }

    @RequestMapping("/booking/delete-service/{sbId}/{bookingId}")
    public String deleteService(Model model,
            @PathVariable("sbId") int sbId,
            @PathVariable("bookingId") int bookingId) {
        serviceBookingService.deleteById(sbId);
        return "redirect:/booking/booking-detail/" + bookingId;
    }

    @RequestMapping("/booking/cancel-booking/{id}")
    public String cancelBooking(Model model,
            @PathVariable("id") int id,
            @RequestParam(name = "mes", required = false) String mes,
            @RequestParam(name = "mesType", required = false) String mesType) {
        Date checkOut = bookingService.findBookingById(id).getCheckOut();
        Date checkIn = bookingService.findBookingById(id).getCheckIn();
        long diffInMilliSeconds1 = checkOut.getTime() - checkIn.getTime();
        int days1 = (int) (diffInMilliSeconds1 / (24 * 60 * 60 * 1000));
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("user", userService.getUser(username));
        model.addAttribute("roles", SecurityUtils.getRolesOfUser());
        model.addAttribute("booking", bookingService.findBookingById(id));
        model.addAttribute("days", days1);
        model.addAttribute("services", serviceService.getServices());
        model.addAttribute("statuses", BookingStatus.values());
        model.addAttribute("creditCardService", creditCardService);
        model.addAttribute("mes", mes);
        model.addAttribute("mesType", mesType);
        model.addAttribute("bookingDetails", bookingDetailService.getBookingDetailsByBookingId(id));
        model.addAttribute("serviceBookings", serviceBookingService.getServiceBookingsByBookingId(id));
        model.addAttribute("action", "refund");
        return "manager/confirm_payment";
    }

    @RequestMapping("/booking/confirm-payment/{id}")
    public String confirmPayment(Model model,
            @PathVariable("id") int id,
            @RequestParam(name = "mes", required = false) String mes,
            @RequestParam(name = "mesType", required = false) String mesType) {
        BookingEntity booking = bookingService.findBookingById(id);
        booking.setStatus(BookingStatus.CHECKOUT);
        bookingService.save(booking);
        Date checkOut = bookingService.findBookingById(id).getCheckOut();
        Date checkIn = bookingService.findBookingById(id).getCheckIn();
        long diffInMilliSeconds1 = checkOut.getTime() - checkIn.getTime();
        int days1 = (int) (diffInMilliSeconds1 / (24 * 60 * 60 * 1000));
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("user", userService.getUser(username));
        model.addAttribute("roles", SecurityUtils.getRolesOfUser());
        model.addAttribute("booking", bookingService.findBookingById(id));
        model.addAttribute("days", days1);
        model.addAttribute("services", serviceService.getServices());
        model.addAttribute("statuses", BookingStatus.values());
        model.addAttribute("mes", mes);
        model.addAttribute("mesType", mesType);
        model.addAttribute("bookingDetails", bookingDetailService.getBookingDetailsByBookingId(id));
        model.addAttribute("serviceBookings", serviceBookingService.getServiceBookingsByBookingId(id));
        model.addAttribute("creditCardService", creditCardService);
        model.addAttribute("action", "pay");
        return "manager/confirm_payment";
    }

    @RequestMapping(value = "/booking/payment/{action}", method = RequestMethod.POST)
    public String payment(Model model,
            @Valid @ModelAttribute("creditCard") CreditCardEntity creditCard,
            BindingResult result,
            @RequestParam("action") String action,
            @RequestParam("bookingId") int bookingId,
            @RequestParam("totalPrice") double totalPrice,
            @RequestParam("monthExp") String monthExp,
            @RequestParam("yearExp") String yearExp) throws ParseException {
        if (creditCardService.checkCardNumber(creditCard.getCardNumber())) {
            CreditCardEntity credit = creditCardService.getCreditCardByCardNumber(creditCard.getCardNumber());
            DateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date expDate = simpleDateFormat.parse(yearExp.concat("-").concat(monthExp).concat("-01"));
            if (!creditCard.getName().equals(credit.getName())) {
                model.addAttribute("mesType", "n");
                model.addAttribute("mes", "Your card name is incorrect");
                if (action.equals("pay")) {
                    return "redirect:/booking/confirm-payment/" + bookingId;
                } else {
                    return "redirect:/booking/cancel-booking/" + bookingId;
                }
            }
            if (creditCard.getCvcCode() != credit.getCvcCode()) {
                model.addAttribute("mesType", "n");
                model.addAttribute("mes", "Your CVC code is incorrect");
                if (action.equals("pay")) {
                    return "redirect:/booking/confirm-payment/" + bookingId;
                } else {
                    return "redirect:/booking/cancel-booking/" + bookingId;
                }
            }
            if (credit.getExpDate().before(expDate)) {
                model.addAttribute("mesType", "n");
                model.addAttribute("mes", "Your card has expired");
                if (action.equals("pay")) {
                    return "redirect:/booking/confirm-payment/" + bookingId;
                } else {
                    return "redirect:/booking/cancel-booking/" + bookingId;
                }
            }
            if (credit.getBalance() < totalPrice) {
                model.addAttribute("mesType", "n");
                model.addAttribute("mes", "The balance in your card is not enought");
                if (action.equals("pay")) {
                    return "redirect:/booking/confirm-payment/" + bookingId;
                } else {
                    return "redirect:/booking/cancel-booking/" + bookingId;
                }
            }
            if (action.equals("pay")) {
                BookingEntity booking = bookingService.findBookingById(bookingId);
                booking.setTotalPrice(totalPrice + booking.getTotalPrice());
                bookingService.save(booking);
                creditCardService.deductBalance(totalPrice, credit);
                PaymentEntity payment = new PaymentEntity();
                payment.setAmount(totalPrice);
                payment.setStatus(PaymentStatus.COMPLETED);
                payment.setBooking(booking);
                payment.setPaymentDate(new Date());
                payment.setCreditCard(credit);
                paymentService.save(payment);
                
                model.addAttribute("mesType", "y");
                model.addAttribute("mes", "Your bill has been paid");
                return "redirect:/booking/confirm-payment/" + bookingId;
            } else {
                creditCardService.addBalance(totalPrice, credit);
                PaymentEntity payment = paymentService.getPaymentByBookingIdAndStatus(bookingId, "COMPLETED");
                payment.setAmount(totalPrice);
                payment.setStatus(PaymentStatus.REFUND);
                paymentService.save(payment);
                
                model.addAttribute("mesType", "y");
                model.addAttribute("mes", "Your bill has been refunded");
                return "redirect:/booking/cancel-booking/" + bookingId;
            }

        }
        model.addAttribute("mesType", "n");
        model.addAttribute("mes", "Your card number is incorrect");
        if (action.equals("pay")) {
            return "redirect:/booking/confirm-payment/" + bookingId;
        } else {
            return "redirect:/booking/cancel-booking/" + bookingId;
        }
    }

    @RequestMapping(value = "/booking/complete-booking/{action}", method = RequestMethod.GET)
    public String completeBooking(Model model,
            @RequestParam("action") String action,
            @RequestParam("bookingId") int bookingId) {
        if (action.equals("pay")) {
            BookingEntity booking = bookingService.findBookingById(bookingId);
            List<ServiceBookingEntity> serviceBookings = serviceBookingService.findServiceBookingsByBookingId(bookingId);
            for (ServiceBookingEntity serviceBooking : serviceBookings) {
                serviceBooking.setStatus(ServiceBookingStatus.PAID);
            }
            booking.setStatus(BookingStatus.COMPLETED);
            serviceBookingService.saveAll(serviceBookings);
            bookingService.save(booking);
            
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
            
            model.addAttribute("mesType", "y");
            model.addAttribute("mes", "Booking Code: " + booking.getCode() + " has been completed");
        }
        if (action.equals("refund")) {
            BookingEntity booking = bookingService.findBookingById(bookingId);
            List<ServiceBookingEntity> serviceBookings = serviceBookingService.findServiceBookingsByBookingId(bookingId);
            for (ServiceBookingEntity serviceBooking : serviceBookings) {
                serviceBooking.setStatus(ServiceBookingStatus.CANCEL);
            }
            booking.setStatus(BookingStatus.CANCEL);
            serviceBookingService.saveAll(serviceBookings);
            bookingService.save(booking);
            
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
            
            model.addAttribute("mesType", "n");
            model.addAttribute("mes", "Booking Code: " + booking.getCode() + " has been canceled");
        }
        return "redirect:/booking";
    }

    @RequestMapping(value = "/booking/change-status", method = RequestMethod.POST)
    public String changeStatus(Model model,
            @RequestParam("id") int id,
            @RequestParam("status") String status) {
        BookingEntity booking = bookingService.findBookingById(id);
        BookingStatus stat = BookingStatus.valueOf(status);
        booking.setStatus(stat);
        bookingService.save(booking);
        return "redirect:/booking";
    }

    @RequestMapping("/booking/check-in/{id}")
    public String checkIn(Model model,
            @PathVariable("id") int id) {
        BookingEntity booking = bookingService.findBookingById(id);
        if (booking.getStatus() != BookingStatus.CHECKIN) {
            booking.setStatus(BookingStatus.CHECKIN);
        }
        bookingService.save(booking);
        return "redirect:/booking";
    }

}
