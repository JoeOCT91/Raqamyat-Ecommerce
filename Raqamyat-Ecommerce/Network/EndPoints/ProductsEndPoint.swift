//
//  ProductsEndPoint.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 08/12/2022.
//

import Foundation
struct ProductsEndPoint: APITarget {
   
   var path: String
   
   var method: Moya.Method {
       return .get
   }
   
   var task: Moya.Task {
       return .requestPlain
   }
   
   var headers: [String : String]? {
       return nil
   }
}
