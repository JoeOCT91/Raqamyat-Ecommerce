//
//  File.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 11/12/2022.
//

import Foundation
import Moya

enum ProductsAPIRouter: TargetType {
    case products(_ page: Int, _ categoryId: Int?)
    case product(_ productId: Int)
}

extension ProductsAPIRouter {
    
    var baseURL: URL {
        guard let url = URL(string: URLs.baseURL) else {
            fatalError("Failed to initialises base URL")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .products:
            return URLs.products
        case .product:
            return URLs.productDetails
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .products(let page, let category):
            var parameters: [String: Any] = [ParametersKeys.page: page]
            if let category { parameters[ParametersKeys.categoryId] = category }
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .product(let productId):
            let parameters = [ParametersKeys.productId: productId]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        let headers = [
            HeaderKeys.contentType: "application/json",
            HeaderKeys.accept: "*/*",
        ]
        return headers
    }
    
}
