//
//  OrderCell.swift
//  Abaya
//
//  Created by Abdullah elotabi on 11/18/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {



    @IBOutlet weak var orderNumberLbl: UILabel!
    
    @IBOutlet weak var orderDateLbl: UILabel!
    
    @IBOutlet weak var orderStatus: UILabel!
    
    @IBOutlet weak var orderItemsNumber: UILabel!
    
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var btnTrackOrder: UIButton!
    
    @IBOutlet weak var btnCancelOrder: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func generateCell(order: Order) {
        
        orderNumberLbl.text = String(order.orderNumber)
        orderDateLbl.text = order.orderDate
        orderStatus.text = order.orderStatus
        orderItemsNumber.text = String(order.orderItems.count) + " items"
        priceLbl.text = "KD " + String(order.orderPrice)
        
        
        
    }



}
