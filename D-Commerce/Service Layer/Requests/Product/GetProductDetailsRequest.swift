//
//  GetProductDetailsRequest.swift
//  D-Commerce
//
//  Created by Khaled Bohout on 15/02/2021.
//  Copyright © 2021 Khaled Bohout. All rights reserved.
//

import Foundation

final class GetProductDetailsRequest: Requestable {
    
    typealias ResponseType = HomeResponse
    private var id: String!
    
    init(id: String) {
        self.id = id
    }
    
    var baseUrl: URL {
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "api/items/\(id!)"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        
        return nil

    }
    
    var headers: [String : String]? {
        return defaultJSONHeader
    }
    
    var timeout: TimeInterval {
        return 30.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}
