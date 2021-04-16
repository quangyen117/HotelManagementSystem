/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.entities;

import com.mycompany.spring_mvc_project_final.enums.ServiceBookingStatus;
import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import org.springframework.format.annotation.DateTimeFormat;

/**
 *
 * @author USER
 */
@Entity
@Table(name = "service_booking")
public class ServiceBookingEntity implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    private double price;
    
    private int quantity;
    
    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private ServiceBookingStatus status;
    
    @Column(name = "service_booking_date", nullable = false)
    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date serviceBookingDate;
    
    @ManyToOne
    @JoinColumn(name = "booking_detail_id")
    private BookingDetailEntity bookingDetail;
    
    @ManyToOne
    @JoinColumn(name = "service_id")
    private ServiceEntity service;

    public ServiceBookingEntity() {
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

    public Date getServiceBookingDate() {
        return serviceBookingDate;
    }

    public void setServiceBookingDate(Date serviceBookingDate) {
        this.serviceBookingDate = serviceBookingDate;
    }

    public BookingDetailEntity getBookingDetail() {
        return bookingDetail;
    }

    public void setBookingDetail(BookingDetailEntity bookingDetail) {
        this.bookingDetail = bookingDetail;
    }

    public ServiceEntity getService() {
        return service;
    }

    public void setService(ServiceEntity service) {
        this.service = service;
    }

    public ServiceBookingEntity(BookingDetailEntity bookingDetail, ServiceEntity service) {
        this.bookingDetail = bookingDetail;
        this.service = service;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public ServiceBookingStatus getStatus() {
        return status;
    }

    public void setStatus(ServiceBookingStatus status) {
        this.status = status;
    }

    
    
    
}
