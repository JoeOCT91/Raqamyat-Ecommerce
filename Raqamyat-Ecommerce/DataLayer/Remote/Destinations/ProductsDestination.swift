//
//  ProductsDestination.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 11/12/2022.
//

import Foundation

protocol ProductsDestination  {
    func getProductsPaging(in page: Int, from category: Int?) async -> Result<APIResponse<[Product]>, Error>
    func getProductDetails(forProduct withId: Int)  async -> Result<APIResponse<Product>, Error>
}
