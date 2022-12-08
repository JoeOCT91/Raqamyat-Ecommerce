//
//  File.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 08/12/2022.
//

import Foundation

struct APIResponse<T: Codable>: Codable {
    let success: Bool
    let item: APIResponseData<T>
    let message: String
}
