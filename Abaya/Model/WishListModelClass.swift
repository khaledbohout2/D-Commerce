//
//  WishListModelClass.swift
//  Abaya
//
//  Created by Chandar on 07/04/19.
//  Copyright © 2019 Kareem Mohammed. All rights reserved.
//

import UIKit

class WishListModelClass: NSObject {
    
    var wishlist = [WishList]()
    
    
    
    func responseFromJson(dic:[String:AnyObject])
    {
        let data = dic["data"] as![String:AnyObject]
        let list = data["data"] as![[String:AnyObject]]
        
       // print(data)
       // print(list)
        
        if list.count > 0
        {
            for _ in list
            {
               // setData(dic:dic)
            }
        }
    }
//    private func setData(dic:[String:AnyObject])
//    {
//        let name = DataValidationClass.getValueFormString(json: dic, key: "store")
//        let detail = DataValidationClass.getValueFormString(json: dic, key: "country")
//        let price = DataValidationClass.getValueFormString(json: dic, key: "banner")
//        let imgProduct = DataValidationClass.getValueFormString(json: dic, key: "banner")
//    }
    
struct WishList {
        
        var name:String
        var detail:String
        var price:String
        var imgProduct:String

    
    }
}

