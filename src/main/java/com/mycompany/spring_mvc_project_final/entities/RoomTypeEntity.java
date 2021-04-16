/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.entities;

import com.mycompany.spring_mvc_project_final.enums.RoomTypeStatus;
import java.io.Serializable;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 *
 * @author USER
 */
@Entity
@Table(name = "room_type")
public class RoomTypeEntity implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @Column(length = 100)
    private String name;
    
    @Column(length = 1000)
    private String description;
    
    private int size;
    
    private int capacity;
    
    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private RoomTypeStatus status;
    
    private int discount;

    @OneToMany(mappedBy = "roomType", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private Set<RoomEntity> rooms;
    
    @OneToMany(mappedBy = "roomType", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private Set<ImageEntity> images;
    
    @ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinTable(name = "room_type_convenience_relationship",
            joinColumns = @JoinColumn(name = "room_type_id",
                    referencedColumnName = "id"),
            inverseJoinColumns = @JoinColumn(
                    name = "convenience_id",
                    referencedColumnName = "id"))
    private Set<ConvenienceEntity> conveniences;
    
//    @ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
//    @JoinTable(name = "room_type_promotion_relationship",
//            joinColumns = @JoinColumn(name = "room_type_id",
//                    referencedColumnName = "id"),
//            inverseJoinColumns = @JoinColumn(
//                    name = "promotion_id",
//                    referencedColumnName = "id"))
    @ManyToMany(mappedBy = "roomTypes",cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<PromotionEntity> promotions;
    
    public RoomTypeEntity() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public RoomTypeStatus getStatus() {
        return status;
    }

    public void setStatus(RoomTypeStatus status) {
        this.status = status;
    }

    public Set<RoomEntity> getRooms() {
        return rooms;
    }

    public void setRooms(Set<RoomEntity> rooms) {
        this.rooms = rooms;
    }

    public Set<ImageEntity> getImages() {
        return images;
    }

    public void setImages(Set<ImageEntity> images) {
        this.images = images;
    }

    public Set<ConvenienceEntity> getConveniences() {
        return conveniences;
    }

    public void setConveniences(Set<ConvenienceEntity> conveniences) {
        this.conveniences = conveniences;
    }

    public Set<PromotionEntity> getPromotions() {
        return promotions;
    }

    public void setPromotions(Set<PromotionEntity> promotions) {
        this.promotions = promotions;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }
    
    
}
