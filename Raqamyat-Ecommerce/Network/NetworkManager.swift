//
//  NetworkManager.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 08/12/2022.
//

import Foundation
import Combine
import Moya

class NetworkManger<Target: APITarget> {
    
    private var target: Target
    private var provider = MoyaProvider<Target>()
    
    init(target: Target) {
        self.target = target
        
    }
    
    func getProducts() {
        
    }
    
    private func request<T: Decodable>() async -> Result<T, Error> {
        await withCheckedContinuation { continuation in
            provider.request(target) { requestResult in
//                switch requestResult {
//                case .success(let response):
//                    do {
//                        continuation.resume(returning: try Result.success(response.map(T.self)))
//                    } catch {
//                        continuation.resume(returning: Result.failure(error))
//                    }
//                case .failure(let error):
//                    continuation.resume(returning: Result.failure(error))
//                }
            }
        }
    }
    
}
