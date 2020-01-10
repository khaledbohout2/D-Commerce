//
//  HelperMethods.swift
//  Abaya
//
//  Created by Khaled Bohout on 1/10/20.
//  Copyright © 2020 Khaled Bohout. All rights reserved.
//

import Foundation

 func getUserDetails() -> Bool {
    
    let userDefault = UserDefaults.standard
    
    var signed : Bool?
    
    if userDefault.value(forKey: "dictionaryKey") != nil {
        
        signed = true
        
    } else {
    
    signed = false
        
}
    return signed!
}

