//
//  NewItemsResponse.swift
//  D-Commerce
//
//  Created by Khaled Bohout on 15/02/2021.
//  Copyright © 2021 Khaled Bohout. All rights reserved.
//

import Foundation

// MARK: - NewItemsResponse
struct NewItemsResponse: Codable {
    
    let currentPage: Int
    let data: [ItemModel]
    let firstPageURL: String
    let from, lastPage: Int
    let lastPageURL: String
    let links: [Link]
    let nextPageURL, path: String
    let perPage: Int
    let prevPageURL: String?
    let to, total: Int

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

// MARK: - Datum
struct ItemModel: Codable {
    
    let id: Int
    let name, newItemsResponseDescription, size, color: String
    let code: String
    let quantity: Int
    let photoLink, category: String
    let buyingPrice, sellingPrice, discount: Int
    let brand, weight, material, manfacturedIn: String
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case newItemsResponseDescription = "description"
        case size, color, code, quantity
        case photoLink = "photo_link"
        case category
        case buyingPrice = "buying_price"
        case sellingPrice = "selling_price"
        case discount, brand, weight, material
        case manfacturedIn = "manfactured_in"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

enum Label: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Label.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Label"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
