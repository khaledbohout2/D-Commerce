//
//  country.swift
//  Abaya
//
//  Created by Khaled Bohout on 1/12/20.
//  Copyright © 2020 Khaled Bohout. All rights reserved.
//

import Foundation

class Country: Codable {
    let id: Int
    let country: String

    init(id: Int, country: String) {
        self.id = id
        self.country = country
    }
}
