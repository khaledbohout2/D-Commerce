//
//  SearchItemListRequest.swift
//  D-Commerce
//
//  Created by Khaled Bohout on 14/02/2021.
//  Copyright © 2021 Khaled Bohout. All rights reserved.
//


import Foundation

final class SearchItemListRequest: Requestable {
    
    typealias ResponseType = SearchListResponse
    
    init() {
        
    }
    
    var baseUrl: URL {
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "api/itemslist"
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

