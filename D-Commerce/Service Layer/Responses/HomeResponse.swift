





import Foundation

// MARK: - HomeResponse
struct HomeResponse: Codable {
    let banners: [String]
    let categories: [Category]
    let sale: [Sale]
}

// MARK: - Category
struct Category: Codable {
    let id: Int
    let title: Title
    let photoLink: String
    let categoryDescription: Description
    let icon, colorCode, coloredIcon, subCategories: String
    let mapIcon: String
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case photoLink = "photo_link"
        case categoryDescription = "description"
        case icon
        case colorCode = "color_code"
        case coloredIcon = "colored_icon"
        case subCategories = "sub_categories"
        case mapIcon = "map_icon"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

enum Description: String, Codable {
    case desc = "desc"
}

enum Title: String, Codable {
    case categ = "categ"
    case title = "title"
}

// MARK: - Sale
struct Sale: Codable {
    let id: Int
    let name: String
    let saleDescription: String
    let size: String
    let color: String
    let code: String
    let quantity: Int
    let photoLink: String
    let category: String
    let buyingPrice, sellingPrice, discount: Int
    let brand: String
    let weight: String
    let material: String
    let manfacturedIn: String
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case saleDescription = "description"
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
