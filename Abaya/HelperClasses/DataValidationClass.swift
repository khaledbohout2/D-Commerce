//
//  ActivityDataGetClass.swift
//  I-Train
//
//  Created by mac on 7/5/18.
//  Copyright © 2018 TechnoBrix. All rights reserved.
//

import UIKit

class DataValidationClass {

    
    class  func getValue<T>(json: [String : AnyObject], key:String) -> T
    {
        if (json[key] as? String) != nil
        {
            if !(json[key] is NSNull )
            {
                return json[key] as! T;
            }
            // return json["data_array"] as! [String : Any] as! T;
        }
        return "" as! T;
    }
    class  func getValueFormString(json: [String : AnyObject], key:String) -> String
    {
        if (json[key] as? String) != nil
        {
            if !(json[key] is NSNull )
            {
                return json[key] as! String ;
            }
            // return json["data_array"] as! [String : Any] as! T;
        }
        return "" ;
    }

    
}
