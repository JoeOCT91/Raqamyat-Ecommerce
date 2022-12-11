//
//  ProductColor.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 11/12/2022.
//

import Foundation

struct ProductColor: Codable, Hashable {
    
    let id: Int
    let name: String
    let colorHex: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case colorHex = "color_hex"
    }
}
