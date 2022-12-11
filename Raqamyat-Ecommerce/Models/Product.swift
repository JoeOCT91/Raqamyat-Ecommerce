//
//  Product.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 08/12/2022.
//

import Foundation

protocol AnyProduct: Hashable, Codable {
    var id: Int  { get }
    var name: String { get }
    var price: String { get }
    var image: String { get }
    var isFav: Bool { get }
    var percentage: String? { get }
    var isHasDiscount: Bool { get }

}

struct Product: AnyProduct, Codable, Hashable {
    
    let id: Int
    let name: String
    let description: String
    let rate: Double
    let reviewCount: Int
    let price: String
    let oldPrice: String
    let percentage: String?
    let image: String
    let images: [String]
    let suggestedProducts: [SuggestedProduct]
    let colors: [ProductColor]
    let reviews: [ProductReview]
    let sizes: [ProductSize]
    let isFav: Bool
    
    var isHasDiscount: Bool {
        return percentage != nil && ((percentage?.isEmpty) == nil)
    }
    
    var priceBeforeDiscount: NSMutableAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "oldPrice" + L10n.egyptianPound)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 0, length: attributeString.length))
        return attributeString
    }

    
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
        case images
        case suggestedProducts
        case reviews
        case sizes
        case colors
        case isFav = "is_fav"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let da = try container.decode(APIResponseData<[SuggestedProduct]>.self, forKey: .suggestedProducts)
        self.suggestedProducts = da.data
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.rate = try container.decode(Double.self, forKey: .rate)
        self.reviewCount = try container.decode(Int.self, forKey: .reviewCount)
        self.price = try container.decode(String.self, forKey: .price)
        self.oldPrice = try container.decode(String.self, forKey: .oldPrice)
        self.percentage = try container.decode(String.self, forKey: .percentage)
        self.image = try container.decode(String.self, forKey: .image)
        self.images = try container.decode([String].self, forKey: .images)
        self.reviews = try container.decode([ProductReview].self, forKey: .reviews)
        self.sizes = try container.decode([ProductSize].self, forKey: .sizes)
        self.colors = try container.decode([ProductColor].self, forKey: .colors)
        self.isFav = try container.decode(Bool.self, forKey: .isFav)
    }
}
