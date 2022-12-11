//
//  NetworkManager.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 08/12/2022.
//

import Foundation
import Combine
import Moya


class APIManager<Target: TargetType>: ProductsDestination {
    
    private let provider: MoyaProvider<Target>
    
    init() {
       let networkLoggerPlugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: [.requestBody, .successResponseBody]))
        provider = MoyaProvider<Target>(plugins: [networkLoggerPlugin])
    }
    
    func getProductsPaging(in page: Int, from category: Int?)  async -> Result<APIResponse<[Product]>, Error> {
        return await request(target: ProductsAPIRouter.products(page, category) as! Target)
    }
    
    func getProductDetails(forProduct withId: Int) async -> Result<APIResponse<Product>, Error> {
        return await request(target: ProductsAPIRouter.product(withId) as! Target)
    }

}

extension APIManager {
    private func request<Element: Decodable>(target: Target) async -> Result<Element, Error> {
        await withCheckedContinuation { continuation in
            provider.request(target) { requestResult in
                switch requestResult {
                case .success(let response):
                    do {
                        continuation.resume(returning: try Result.success(response.map(Element.self)))
                    } catch {
                        continuation.resume(returning: Result.failure(error))
                        print(error)
                    }
                case .failure(let error):
                    continuation.resume(returning: Result.failure(error))
                }
            }
        }
    }
}

