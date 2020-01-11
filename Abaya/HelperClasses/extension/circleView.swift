//
//  circleView.swift
//  Abaya
//
//  Created by Khaled Bohout on 1/11/20.
//  Copyright © 2020 Khaled Bohout. All rights reserved.
//

import Foundation

import UIKit

class FancyView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = frame.size.width/2
        clipsToBounds = true

      //  layer.borderColor = UIColor.whiteColor.CGColor
        layer.borderWidth = 5.0
    }



}
