//
//  RelatedItems.swift
//  D-Commerce
//
//  Created by Khaled Bohout on 15/02/2021.
//  Copyright © 2021 Khaled Bohout. All rights reserved.
//

import Foundation

// MARK: - RelatedItems
struct RelatedItems: Codable {
    let items: Items
    let recommendedItems: [ItemModel]

    enum CodingKeys: String, CodingKey {
        case items
        case recommendedItems = "recommended_items"
    }
}

// MARK: - Items
struct Items: Codable {
    let currentPage: Int
    let data: [ItemModel]
    let firstPageURL: String
    let from, to: Int?
    let lastPage: Int
    let lastPageURL: String
    let links: [Link]
    let nextPageURL: String?
    let path: String
    let perPage: Int
    let prevPageURL: String?
    let total: Int

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case links
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
}
