//
//  SuggestedProduct.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 09/12/2022.
//

import Foundation

struct SuggestedProduct: AnyProduct, Codable, Hashable {
    
    let id: Int
    let name: String
    let price: String
    let image: String
    let isFav: Bool
    let percentage: String?
    
    var isHasDiscount: Bool {
        return percentage != nil
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case image
        case isFav = "is_fav"
        case percentage
    }
}
