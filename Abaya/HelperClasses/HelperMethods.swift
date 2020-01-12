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

func isValidPhone(phone: String) -> Bool {
    let phoneRegex =  "^(05)([503649187])([0-9]{7})$";
    let valid = NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: phone)
    return valid
}

func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}

func isValidPassword(testStr:String) -> Bool {
    // at least one uppercase,
    // at least one digit
    // at least one lowercase
    // 8 characters total
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
    return passwordTest.evaluate(with: testStr)
}

