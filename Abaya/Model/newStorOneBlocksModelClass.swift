//
//  HelpDictionaryModelClass.swift
//  NARI
//
//  Created by mac on 7/27/18.
//  Copyright © 2018 technoBrix. All rights reserved.
//

import UIKit

class newStorOneBlocksModelClass: NSObject {

    var helplineList = [arrNewBlocks]()

    func responseFromJson(dic:[String:AnyObject])
    {
      //  let data = dic["data"] as![String:AnyObject]
        
        var dicData = NSDictionary()
        dicData = (dic["data"] as! NSDictionary)
        
        let list = dicData["data"] as![[String:AnyObject]]
        
        
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
         
            let logo = DataValidationClass.getValueFormString(json: dic, key: "logo")
            
            let obj = arrNewBlocks( logo: logo)
            
            helplineList.append(obj)
        }

}

struct arrNewBlocks {
    
    
    var logo:String
    
}
