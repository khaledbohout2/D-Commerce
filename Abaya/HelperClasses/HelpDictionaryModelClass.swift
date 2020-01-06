//
//  HelpDictionaryModelClass.swift
//  NARI
//
//  Created by mac on 7/27/18.
//  Copyright © 2018 technoBrix. All rights reserved.
//

import UIKit

class HelpDictionaryModelClass: NSObject {

    var helplineList = [HelplineList]()

    func responseFromJson(dic:[String:AnyObject])
    {
        let data = dic["data"] as![String:AnyObject]
        let list = data["data"] as![[String:AnyObject]]
        
        if list.count > 0
        {
            for dic in list
            {
                setData(dic:dic)
            }
        }
    }
        private func setData(dic:[String:AnyObject])
        {
            
            print(dic)
            
            let store = DataValidationClass.getValueFormString(json: dic, key: "store")
            let country = DataValidationClass.getValueFormString(json: dic, key: "country")
            let logo = DataValidationClass.getValueFormString(json: dic, key: "banner")
            let product_id = DataValidationClass.getValueFormString(json: dic, key: "id")
            
//            let product_id = String(format: "%@", DataValidationClass.getValueFormString(json: dic, key: "new_arrivals") as CVarArg)
            let obj = HelplineList(store:store , country: country , logo: logo,product_id: product_id)
            helplineList.append(obj)
        }

}

struct HelplineList {
    
    var store:String
    var country:String
    var logo:String
    var product_id:String
    
}
