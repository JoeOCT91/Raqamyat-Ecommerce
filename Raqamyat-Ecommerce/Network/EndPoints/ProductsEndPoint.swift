//
//  ProductsEndPoint.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 08/12/2022.
//

import Foundation
import Moya

struct ProductsEndPoint: APITarget {
    
    var paging: Int?
    
    var path: String
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        return .requestParameters(parameters: ["": paging], encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
}
