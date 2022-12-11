//
//  ProductReview.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 11/12/2022.
//

import Foundation

struct ProductReview: Codable, Hashable {
    
    let id: Int
    let rate: Double
    let review: String
    let title: String
    let createdBy: String
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case rate
        case review
        case title
        case createdBy = "created_by"
        case createdAt = "created_at"
    }
}
