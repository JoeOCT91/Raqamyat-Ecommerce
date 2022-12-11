//
//  Constants.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 08/12/2022.
//

import Foundation

struct URLs {
    static let baseURL = "https://macariastore.com/api/"
    static let products = "products/pages"
    static let productDetails = "product/details"
}

struct Cells {
    static let productCell = "ProductCell"
    static let productImageCell = "ProductImageCell"
    static let reviewCell = "ReviewCell"
    static let productSizeCell = "ProductSizeCell"
    static let productColorCell = "ProductColorCell"
}

struct SupplementariesKind {
    static let productDetailsHeader = "productDetailsCollectionViewHeader"
    static let productDescription = "ProductDescriptionCollectionViewHeader"
    static let productDetailsCompact = "productDetailsCompactView"
}

struct HeaderKeys {
    static let contentType = "Content-Type"
    static let accept = "Accept"
}

struct ParametersKeys {
    static let page = "page"
    static let categoryId = "category_id"
    static let productId = "id"
}
