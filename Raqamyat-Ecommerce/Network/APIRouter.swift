//
//  APIRouter.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 08/12/2022.
//

import Foundation
import Moya

enum APIRouter {
    case products(_ paging: Int)
    case productDetails(_ forId: Int)
}

extension APIRouter: TargetType {
    
    public var baseURL: URL {
            guard let baseURL = URL(string: URLs.baseURL) else { fatalError() }
            return baseURL
    }
    
    public var path: String {
        switch self {
        case .products:
            return URLs.products
        case .productDetails:
            return URLs.productDetails
        }
    }
    
    public var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        default:
            return.requestPlain
        }
    }
    
    public var headers: [String : String]? {
//        let headers = [
//            HeaderKeys.contentType: "application/json",
//            HeaderKeys.accept: "application/json",
//        ]
        return nil
    }

    
    
    
    
}

