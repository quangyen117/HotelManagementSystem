/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.entities.ImageEntity;
import com.mycompany.spring_mvc_project_final.entities.PromotionEntity;
import com.mycompany.spring_mvc_project_final.entities.RoomEntity;
import com.mycompany.spring_mvc_project_final.entities.RoomTypeEntity;
import com.mycompany.spring_mvc_project_final.entities.ServiceEntity;
import com.mycompany.spring_mvc_project_final.enums.PromotionStatus;
import com.mycompany.spring_mvc_project_final.enums.RoomStatus;
import com.mycompany.spring_mvc_project_final.enums.RoomTypeStatus;
import com.mycompany.spring_mvc_project_final.enums.ServiceStatus;
import com.mycompany.spring_mvc_project_final.service.ConvenienceService;
import com.mycompany.spring_mvc_project_final.service.ImageService;
import com.mycompany.spring_mvc_project_final.service.PromotionService;
import com.mycompany.spring_mvc_project_final.service.RoomService;
import com.mycompany.spring_mvc_project_final.service.RoomTypeService;
import com.mycompany.spring_mvc_project_final.service.ServiceService;
import com.mycompany.spring_mvc_project_final.service.UserService;
import com.mycompany.spring_mvc_project_final.utils.SecurityUtils;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Set;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author USER
 */
@Controller
public class HotelManagementController {

    @Autowired
    private RoomService roomService;

    @Autowired
    private RoomTypeService roomTypeService;

    @Autowired
    private ImageService imageService;

    @Autowired
    private ServiceService serviceService;

    @Autowired
    private PromotionService promotionService;
    
    @Autowired
    private ConvenienceService convenienceService;
    
    @Autowired
    private UserService userService;

    @RequestMapping("/hotelManagement/room/add-room")
    public String addRoom(Model model) {
        model.addAttribute("room", new RoomEntity());
        model.addAttribute("roomTypes", roomTypeService.getRoomTypes());
        model.addAttribute("statuses", RoomStatus.values());
        model.addAttribute("action", "add");
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("user", userService.getUser(username));
        model.addAttribute("roles", SecurityUtils.getRolesOfUser());
        return "manager/add_room";
    }

    @RequestMapping("/hotelManagement/room/edit-room/{id}")
    public String editRoom(Model model,
            @PathVariable("id") int id) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("user", userService.getUser(username));
        model.addAttribute("roles", SecurityUtils.getRolesOfUser());
        model.addAttribute("room", roomService.findRoomById(id));
        model.addAttribute("roomTypes", roomTypeService.getRoomTypes());
        model.addAttribute("statuses", RoomStatus.values());
        model.addAttribute("action", "edit");
        return "manager/add_room";
    }

    @RequestMapping(value = "/hotelManagement/room/{action}", method = RequestMethod.POST)
    public String resultRoom(Model model,
            @Valid @ModelAttribute("room") RoomEntity room,
            BindingResult result,
            @RequestParam("action") String action) {
        roomService.save(room);
        return "redirect:/hotelManagement/room/view-room";
    }

    @RequestMapping("/hotelManagement/room/view-room")
    public String viewAllRoom(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("user", userService.getUser(username));
        model.addAttribute("roles", SecurityUtils.getRolesOfUser());
        model.addAttribute("rooms", roomService.getRooms());
        return "manager/all_rooms";
    }

    @RequestMapping(value = "/hotelManagement/room/change-status/{id}")
    public String updateRoomStatus(Model model,
            @PathVariable("id") int id) {
        RoomEntity room = roomService.findRoomById(id);
        if (room.getStatus() == RoomStatus.MAINTENANCE) {
            room.setStatus(RoomStatus.AVAILABLE);
        } else {
            room.setStatus(RoomStatus.MAINTENANCE);
        }
        roomService.save(room);
        return "redirect:/hotelManagement/room/view-room";
    }

    @RequestMapping("/hotelManagement/room-type/view-room-type")
    public String viewRoomType(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("user", userService.getUser(username));
        model.addAttribute("roles", SecurityUtils.getRolesOfUser());
        model.addAttribute("roomTypes", roomTypeService.getRoomTypes());
        model.addAttribute("roomTypeService", roomTypeService);
        return "manager/all_room_types";
    }

    @RequestMapping("/hotelManagement/room-type/add-room-type")
    public String addRoomType(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("user", userService.getUser(username));
        model.addAttribute("roles", SecurityUtils.getRolesOfUser());
        model.addAttribute("roomTypeService", roomTypeService);
        model.addAttribute("roomType", new RoomTypeEntity());
        model.addAttribute("conveniences", convenienceService.getConveniences());
        model.addAttribute("statuses", RoomTypeStatus.values());
        model.addAttribute("action", "add");
        return "manager/add_room_type";
    }

    @RequestMapping("/hotelManagement/room-type/edit-room-type/{id}")
    public String editRoomType(Model model,
            @PathVariable("id") int id) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("user", userService.getUser(username));
        model.addAttribute("roles", SecurityUtils.getRolesOfUser());
        model.addAttribute("roomTypeService", roomTypeService);
        model.addAttribute("roomType", roomTypeService.findRoomTypeById(id));
        model.addAttribute("conveniences", convenienceService.getConveniences());
        model.addAttribute("statuses", RoomTypeStatus.values());
        model.addAttribute("action", "edit");
        return "manager/add_room_type";
    }

    @RequestMapping(value = "/hotelManagement/room-type/{action}", method = RequestMethod.POST)
    public String resultRoomType(Model model,
            @Valid @ModelAttribute("roomType") RoomTypeEntity roomType,
            BindingResult result,
            @RequestParam(value = "convenienceIds", required = false) List<Integer> convenienceIds,
            @RequestParam("file") List<MultipartFile> files,
            HttpServletRequest request,
            @RequestParam("action") String action) {
        roomTypeService.save(roomType);
        roomType.setConveniences(convenienceService.getConveniencesByConvenienceIds(convenienceIds));
        roomTypeService.save(roomType);
        if (files != null && files.size() > 0) {
            for (MultipartFile file : files) {
                ImageEntity image = new ImageEntity();
                try {
                    byte[] bytes = file.getBytes();
                    ServletContext context = request.getServletContext();
                    String pathUrl = context.getRealPath("/images");
                    int index = pathUrl.indexOf("target");
                    String pathFolder = pathUrl.substring(0, index) + "src\\main\\webapp\\resources-management\\images\\";
                    String fileName = "";
                    String originalName = file.getOriginalFilename();
                    if (imageService.getImageNames(originalName).isEmpty()) {
                        fileName = originalName;
                    } else {
                        boolean cont = true;
                        do {
                            fileName = RandomStringUtils.randomNumeric(2) + '-' + originalName;
                            if (imageService.getImageNames(fileName).isEmpty()) {
                                cont = false;
                            }
                        } while (cont);
                    }
                    Path path = Paths.get(pathFolder + fileName);
                    Files.write(path, bytes);
                    image.setName(fileName);
                    image.setRoomType(roomType);
                    imageService.saveImage(image);
                } catch (IOException ex) {
                    ex.getMessage();
                }
            }
        }
        return "redirect:/hotelManagement/room-type/view-room-type";
    }

    @RequestMapping("/hotelManagement/room-type/delete-image/{id}")
    public String deleteImage(Model model,
            @PathVariable("id") int id,
            HttpServletRequest request) {
        Set<ImageEntity> listImage = imageService.findImageByRoomType(roomTypeService.findRoomTypeInImageById(id));
        for (ImageEntity image : listImage) {
            ServletContext context = request.getServletContext();
            String pathUrl = context.getRealPath("/images");
            int index = pathUrl.indexOf("target");
            String pathFolder = pathUrl.substring(0, index) + "src\\main\\webapp\\resources-management\\images\\";
            Path path = Paths.get(pathFolder + image.getName());
            try {
                Files.delete(path);
            } catch (IOException ex) {

            }
        }
        imageService.deleteImageByRoomType(roomTypeService.findRoomTypeInImageById(id));
        return "redirect:/hotelManagement/room-type/edit-room-type/{id}";
    }
    
    @RequestMapping(value = "/hotelManagement/room-type/change-status/{id}")
    public String updateRoomTypeStatus(Model model,
            @PathVariable("id") int id) {
        RoomTypeEntity roomType = roomTypeService.findRoomTypeById(id);
        if (roomType.getStatus() == RoomTypeStatus.UNACTIVE) {
            roomType.setStatus(RoomTypeStatus.ACTIVE);
        } else {
            roomType.setStatus(RoomTypeStatus.UNACTIVE);
        }
        roomTypeService.save(roomType);
        return "redirect:/hotelManagement/room-type/view-room-type";
    }

    @RequestMapping("/hotelManagement/service/view-service")
    public String viewService(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("user", userService.getUser(username));
        model.addAttribute("roles", SecurityUtils.getRolesOfUser());
        model.addAttribute("services", serviceService.getServices());
        return "manager/all_services";
    }

    @RequestMapping("/hotelManagement/service/add-service")
    public String addService(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("user", userService.getUser(username));
        model.addAttribute("roles", SecurityUtils.getRolesOfUser());
        model.addAttribute("service", new ServiceEntity());
        model.addAttribute("statuses", ServiceStatus.values());
        model.addAttribute("action", "add");
        return "manager/add_service";
    }

    @RequestMapping("/hotelManagement/service/edit-service/{id}")
    public String editService(Model model,
            @PathVariable("id") int id) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("user", userService.getUser(username));
        model.addAttribute("roles", SecurityUtils.getRolesOfUser());
        model.addAttribute("service", serviceService.findServiceById(id));
        model.addAttribute("statuses", ServiceStatus.values());
        model.addAttribute("action", "edit");
        return "manager/add_service";
    }

    @RequestMapping(value = "/hotelManagement/service/{action}", method = RequestMethod.POST)
    public String resultService(Model model,
            @Valid @ModelAttribute("service") ServiceEntity service,
            BindingResult result,
            @RequestParam("action") String action) {
        serviceService.save(service);
        return "redirect:/hotelManagement/service/view-service";
    }

    @RequestMapping("/hotelManagement/service/change-status/{id}")
    public String updateServiceStatus(Model model,
            @PathVariable("id") int id) {
        ServiceEntity service = serviceService.findServiceById(id);
        if (service.getStatus() == ServiceStatus.UNAVAILABLE) {
            service.setStatus(ServiceStatus.AVAILABLE);
        } else {
            service.setStatus(ServiceStatus.UNAVAILABLE);
        }
        serviceService.save(service);
        return "redirect:/hotelManagement/service/view-service";
    }

    @RequestMapping("/hotelManagement/promotion/view-promotion")
    public String viewPromotion(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("user", userService.getUser(username));
        model.addAttribute("roles", SecurityUtils.getRolesOfUser());
        model.addAttribute("promotionService", promotionService);
        model.addAttribute("promotions", promotionService.getPromotions());
        return "manager/all_promotions";
    }

    @RequestMapping("/hotelManagement/promotion/add-promotion")
    public String addPromotion(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("user", userService.getUser(username));
        model.addAttribute("roles", SecurityUtils.getRolesOfUser());
        model.addAttribute("promotionService", promotionService);
        model.addAttribute("promotion", new PromotionEntity());
        model.addAttribute("roomTypes", roomTypeService.getRoomTypes());
        model.addAttribute("statuses", PromotionStatus.values());
        model.addAttribute("action", "add");
        return "manager/add_promotion";
    }

    @RequestMapping("/hotelManagement/promotion/edit-promotion/{id}")
    public String editPromotion(Model model,
            @PathVariable("id") int id) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("user", userService.getUser(username));
        model.addAttribute("roles", SecurityUtils.getRolesOfUser());
        model.addAttribute("promotionService", promotionService);
        model.addAttribute("promotion", promotionService.findPromotionById(id));
        model.addAttribute("roomTypes", roomTypeService.getRoomTypes());
        model.addAttribute("statuses", PromotionStatus.values());
        model.addAttribute("action", "edit");
        return "manager/add_promotion";
    }

    @RequestMapping(value = "/hotelManagement/promotion/{action}", method = RequestMethod.POST)
    public String resultPromotion(Model model,
            @Valid @ModelAttribute("promotion") PromotionEntity promotion,
            BindingResult result,
            @RequestParam(value = "roomTypeIds", required = false) List<Integer> roomTypeIds,
            @RequestParam("action") String action) {
        promotionService.save(promotion);
        promotion.setRoomTypes(roomTypeService.getRoomTypesByRoomTypeIds(roomTypeIds));
        promotionService.save(promotion);
        return "redirect:/hotelManagement/promotion/view-promotion";
    }

    @RequestMapping("/hotelManagement/promotion/change-status/{id}")
    public String updatePromotionStatus(Model model,
            @PathVariable("id") int id) {
        PromotionEntity promotion = promotionService.findPromotionById(id);
        if (promotion.getStatus() == PromotionStatus.UNAVAILABLE) {
            promotion.setStatus(PromotionStatus.AVAILABLE);
        } else {
            promotion.setStatus(PromotionStatus.UNAVAILABLE);
        }
        promotionService.save(promotion);
        return "redirect:/promotion/view-promotion";
    }
}
