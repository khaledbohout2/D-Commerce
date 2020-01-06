//
//  CommonRequest.swift
//  Abaya
//
//  Created by Khaled Bohout on 10/26/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import Foundation
import Alamofire

public typealias ResultHandler = (Bool, Any?, NSError?) -> Void

class Network {
    
    static let baseUrl = "http://theblocksapp.com/api/"

    class func commonRequest(url: String, method: HTTPMethod, parameters:[String: Any]?, headers:HTTPHeaders?, handler: @escaping (Bool, Any?, NSError?) -> Void) {
        print("url: \(baseUrl)\(url)")
        
        AF.request(baseUrl + url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            switch responseObject.result
            {
            case .success(let data):
                let jsonValue = data
              
                handler(true, jsonValue, nil)
                break
                
            case .failure(let error):
                print(error.localizedDescription)
                
                handler(false, nil, error as NSError)
                break
            }
        }
    }
    }

    
