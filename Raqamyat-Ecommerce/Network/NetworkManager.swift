//
//  NetworkManager.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 08/12/2022.
//

import Foundation
import Combine
import Moya

class NetworkManger {
    
    private static let networkLoggerPlugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: [.requestBody, .successResponseBody]))

    private var provider = MoyaProvider<APIRouter>(plugins: [networkLoggerPlugin])
    private static let sharedInstance = NetworkManger()
    
    // Private Init
    private init() {}
    
    class func shared() -> NetworkManger {
        return NetworkManger.sharedInstance
    }
    
    func getProducts() async -> Result<APIResponse<[Product]>, Error> {
        await request(target: .products(1))
    }
    
    private func request<T: Decodable>(target: APIRouter) async -> Result<T, Error> {
        await withCheckedContinuation { continuation in
            provider.request(target) { requestResult in
                switch requestResult {
                case .success(let response):
                    do {
                        continuation.resume(returning: try Result.success(response.map(T.self)))
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
