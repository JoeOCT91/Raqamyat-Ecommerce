//
//  ProductDetailsRepository.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 11/12/2022.
//

import Foundation
import Combine

protocol ProductDetailsRepositoryProtocol: AnyRepository {
    var productPublisher: AnyPublisher<APIResponseData<Product>, Never> { get }
    func fetchProductDetails(forProduct withProductId: Int)
}

class ProductDetailsRepository: Repository, ProductDetailsRepositoryProtocol {
    
    @Published private var product: APIResponseData<Product>?
    var productPublisher: AnyPublisher<APIResponseData<Product>, Never> {
        return $product
            .compactMap({$0})
            .eraseToAnyPublisher()
    }
    
    private let destination: ProductsDestination
    
    init(destination: ProductsDestination ) {
        self.destination = destination
        super.init()
    }
    
    func fetchProductDetails(forProduct withProductId: Int) {
        Task {
            repositoryState = .loading
            let dataResponse = await destination.getProductDetails(forProduct: withProductId)
            repositoryState = .idle
            switch dataResponse {
            case .success(let success):
                product = success.item
            case .failure(let failure):
                repositoryState = .error(failure)
            }
        }
    }
}
