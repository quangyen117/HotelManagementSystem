/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.entities;

import java.util.List;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 *
 * @author USER
 */
@Entity
@Table(name = "booking_detail")
public class BookingDetailEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private double price;

    private int discount;

    @ManyToOne
    @JoinColumn(name = "room_id")
    private RoomEntity room;

    @ManyToOne
    @JoinColumn(name = "booking_id")
    private BookingEntity booking;

    @OneToMany(mappedBy = "bookingDetail", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private Set<ServiceBookingEntity> serviceBookings;

    @Transient
    private List<Integer> services;
    
    @Transient
    private List<Integer> serviceIds;
    
    @Transient
    private List<ServiceEntity> serviceEntity;
    
    public BookingDetailEntity() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public RoomEntity getRoom() {
        return room;
    }

    public void setRoom(RoomEntity room) {
        this.room = room;
    }

    public BookingEntity getBooking() {
        return booking;
    }

    public void setBooking(BookingEntity booking) {
        this.booking = booking;
    }

    public Set<ServiceBookingEntity> getServiceBookings() {
        return serviceBookings;
    }

    public void setServiceBookings(Set<ServiceBookingEntity> serviceBookings) {
        this.serviceBookings = serviceBookings;
    }

    public List<Integer> getServices() {
        return services;
    }

    public void setServices(List<Integer> services) {
        this.services = services;
    }


    public BookingDetailEntity(RoomEntity room) {
        this.room = room;
    }

    public BookingDetailEntity(RoomEntity room, Set<ServiceBookingEntity> serviceBookings) {
        this.room = room;
        this.serviceBookings = serviceBookings;
    }

    public BookingDetailEntity(RoomEntity room, List<ServiceEntity> serviceEntity) {
        this.room = room;
        this.serviceEntity = serviceEntity;
    }

    public List<ServiceEntity> getServiceEntity() {
        return serviceEntity;
    }

    public void setServiceEntity(List<ServiceEntity> serviceEntity) {
        this.serviceEntity = serviceEntity;
    }

    public List<Integer> getServiceIds() {
        return serviceIds;
    }

    public void setServiceIds(List<Integer> serviceIds) {
        this.serviceIds = serviceIds;
    }

    
    
    


    
}
