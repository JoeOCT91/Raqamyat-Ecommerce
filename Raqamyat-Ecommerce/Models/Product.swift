//
//  Product.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 08/12/2022.
//

import Foundation

struct Product: Codable, Hashable {
    let id: Int
    let name: String
    let description: String
    let rate: Int
    let reviewCount: Int
    let price: String
    let oldPrice: String
    let percentage: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case rate
        case reviewCount = "review_count"
        case price
        case oldPrice = "old_price"
        case percentage
        case image
    }
}
