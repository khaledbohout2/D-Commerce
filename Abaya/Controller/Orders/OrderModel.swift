//
//  orderModel.swift
//  Abaya
//
//  Created by Abdullah elotabi on 11/18/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import Foundation

class Order {
    
   private var _orderNumber: Int!
   private var _orderDate: String!
   private var _orderStatus: String!
   private var _orderItems : [NSDictionary]!
   private var _orderprice: Int!
    
    var orderNumber: Int {
        
        if _orderNumber == nil {
            _orderNumber = 0
        }
        return _orderNumber
    }
    
    var orderDate: String {
        
        if _orderDate == nil {
            _orderDate = ""
        }
        return _orderDate
    }
    
    var orderStatus: String {
        
        if _orderStatus == nil {
            _orderStatus = ""
        }
        
        return _orderStatus
    }
    
    var orderItems: [NSDictionary] {
        
        if _orderItems == nil {
            _orderItems = [NSDictionary]()
        }
        return _orderItems
    }
    
    var orderPrice: Int {
        
        if _orderprice == nil {
            _orderprice = 0
        }
        return _orderprice
    }
    
    

    
    
    
    init(orderNumber: Int, orderDate: String,orderStatues: String, orderItems: [NSDictionary], orderprice: Int) {
        
        self._orderNumber = orderNumber
        self._orderDate = orderDate
        self._orderStatus = orderStatues
        self._orderItems = orderItems
        self._orderprice = orderprice
    }
    
}
