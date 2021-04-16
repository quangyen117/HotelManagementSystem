/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.CreditCardEntity;
import com.mycompany.spring_mvc_project_final.repository.CreditCardRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

/**
 *
 * @author HMT
 */
@Service
public class CreditCardService {
    @Autowired
    private CreditCardRepository creditCardRepository;
    
    public boolean checkCardNumber(String cardNumber){
        CreditCardEntity credit = creditCardRepository.findByCardNumberLike(cardNumber);
        if(ObjectUtils.isEmpty(credit)){
            return false;
        }
        return true;
    }
    
    public CreditCardEntity getCreditCardByCardNumber(String cardNumber){
        return creditCardRepository.findByCardNumberLike(cardNumber);
    }
    
    public void changeBalance(double amount,CreditCardEntity card ){
        card.setBalance(card.getBalance()-amount);
        creditCardRepository.save(card);
        
    }
    
    public void save(CreditCardEntity credit){
        creditCardRepository.save(credit);
    }
    
    public CreditCardEntity getCreditCardByPayment(int id){
        return creditCardRepository.findByPaymentsIdLike(id);
    }
    
    public void deductBalance(double amount, CreditCardEntity card ){
        card.setBalance(card.getBalance() - amount);
        creditCardRepository.save(card);
    }
    
    public void addBalance(double amount, CreditCardEntity card ){
        card.setBalance(card.getBalance() + amount);
        creditCardRepository.save(card);
    }
}
