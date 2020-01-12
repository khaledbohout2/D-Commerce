//
//  ViewBorder.swift
//  Abaya
//
//  Created by Khaled Bohout on 1/12/20.
//  Copyright © 2020 Khaled Bohout. All rights reserved.
//

import UIKit

class BorderView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowOpacity = 0.0
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 2.0
    }



}
