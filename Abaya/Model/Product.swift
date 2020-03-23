//
//  Product.swift
//  Blocks
//
//  Created by Khaled Bohout on 3/23/20.
//  Copyright © 2020 Khaled Bohout. All rights reserved.
//

import Foundation

// MARK: - Product
struct Product: Codable {
    let success: Bool
    let data: DataClass
    let message: String
}

// MARK: - DataClass
struct DataClass: Codable {
    let id: Int
    let productName, productCode, productDescription, brand: String
    let productOriginalPrice, productCurrentPrice, productDiscount: Int
    let productImage: String
    let availableQuantity, minimumQuantity, stockStatus, isnew: Int
    let madeInCountry, outOfStockStatus, productType: String
    let attributeGroupID: Int
    let weight, material: String?
    let productsImages: [ProductsImage]
    let attributeGroup: AttributeGroup

    enum CodingKeys: String, CodingKey {
        case id
        case productName = "product_name"
        case productCode = "product_code"
        case productDescription = "product_description"
        case brand
        case productOriginalPrice = "product_original_price"
        case productCurrentPrice = "product_current_price"
        case productDiscount = "product_discount"
        case productImage = "product_image"
        case availableQuantity = "available_quantity"
        case minimumQuantity = "minimum_quantity"
        case stockStatus = "stock_status"
        case isnew
        case madeInCountry = "made_in_country"
        case outOfStockStatus = "out_of_stock_status"
        case productType = "product_type"
        case attributeGroupID = "attribute_group_id"
        case weight, material
        case productsImages = "products_images"
        case attributeGroup = "attribute_group"
    }
}

// MARK: - AttributeGroup
struct AttributeGroup: Codable {
    let id: Int
    let groupName: String
    let attributes: [Attribute]

    enum CodingKeys: String, CodingKey {
        case id
        case groupName = "group_name"
        case attributes
    }
}

// MARK: - Attribute
struct Attribute: Codable {
    let id: Int
    let label, attributeCode: String
    let pivot: Pivot
    let attributeOptions: [AttributeOption]

    enum CodingKeys: String, CodingKey {
        case id, label
        case attributeCode = "attribute_code"
        case pivot
        case attributeOptions = "attribute_options"
    }
}

// MARK: - AttributeOption
struct AttributeOption: Codable {
    let id: Int
    let attributeOption: String
    let attributeID: Int
    let sku: [Int]

    enum CodingKeys: String, CodingKey {
        case id
        case attributeOption = "attribute_option"
        case attributeID = "attribute_id"
        case sku
    }
}

// MARK: - Pivot
struct Pivot: Codable {
    let attributeGroupID, attributeID: Int

    enum CodingKeys: String, CodingKey {
        case attributeGroupID = "attribute_group_id"
        case attributeID = "attribute_id"
    }
}

// MARK: - ProductsImage
struct ProductsImage: Codable {
    let id: Int
    let image: String
    let productID, sortorder: Int

    enum CodingKeys: String, CodingKey {
        case id, image
        case productID = "product_id"
        case sortorder
    }
}
