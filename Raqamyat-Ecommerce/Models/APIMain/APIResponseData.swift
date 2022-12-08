//
//  APIResponseData.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 08/12/2022.
//

import Foundation

// MARK: - Item
struct APIResponseData<T: Codable>: Codable {
    let data: T
    let meta: Meta
}
