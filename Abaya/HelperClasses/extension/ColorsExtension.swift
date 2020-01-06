//
//  Colors.swift
//  Abaya
//
//  Created by Kareem Mohammed on 2/9/18.
//  Copyright © 2018 Kareem Mohammed. All rights reserved.
//

import UIKit

public extension UIColor {
    
    class func colorWithHex (_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
//    class func hintColor() -> UIColor{
//        return colorWithHex("9E9E9E")
//    }
    
    class func defaultColor() -> UIColor{
        return colorWithHex("3F3F3F")
    }
   
    class var imageborder: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 192.0 / 255.0, blue: 31.0 / 255.0, alpha: 1.0)
    }
    
//    class func pinkColor() -> UIColor {
//        return colorWithHex("CC3A69")
//    }
    
}
