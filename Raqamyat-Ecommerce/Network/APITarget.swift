//
//  APITarget.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 08/12/2022.
//

import Foundation
import Moya

protocol APITarget: TargetType {
    
}

extension APITarget {
    var baseURL: URL {
        URL(string: "https://qiita.com/api/v2/")!
    }
}
