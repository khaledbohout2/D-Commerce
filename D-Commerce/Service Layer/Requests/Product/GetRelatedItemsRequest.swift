//
//  GetRelatedItemsRequest.swift
//  D-Commerce
//
//  Created by Khaled Bohout on 15/02/2021.
//  Copyright © 2021 Khaled Bohout. All rights reserved.
//

import Foundation

final class GetRelatedItemsRequest: Requestable {
    
    typealias ResponseType = RelatedItems
    private var itemID: String!
    
    init(itemID: String) {
        
        self.itemID = itemID
    }
    
    var baseUrl: URL {
        
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "api/RelatedItems"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        
        return ["item_id" : self.itemID!]

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

