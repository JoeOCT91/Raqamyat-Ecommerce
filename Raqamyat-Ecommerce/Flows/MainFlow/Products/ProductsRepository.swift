//
//  ProductsRepository.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 08/12/2022.
//

import Foundation
import Combine

protocol ProductsRepositoryProtocol: AnyRepository {
    var productsListPublisher: AnyPublisher<[Product], Never> { get }
    var repositoryDataListPublisher: AnyPublisher<APIResponseData<[Product]>, Never> { get }
    
    func fetchProducts(in page: Int)
}

class ProductsRepository: Repository, ProductsRepositoryProtocol {
    
    @Published private var productsList = [Product]()
    var productsListPublisher: AnyPublisher<[Product], Never> {
        return $productsList.eraseToAnyPublisher()
    }
    
    @Published private var repositoryDataList: APIResponseData<[Product]>?
    var repositoryDataListPublisher: AnyPublisher<APIResponseData<[Product]>, Never> {
        return $repositoryDataList
            .compactMap({$0})
            .eraseToAnyPublisher()
    }
    
    private let destination: ProductsDestination
    
    init(destination: ProductsDestination ) {
        self.destination = destination
        super.init()
        fetchProducts()
    }
    
    func fetchProducts(in page: Int = 1) {
        Task {
            let dataResponse = await destination.getProductsPaging(in: page, from: 5)
            repositoryState = .idle
            switch dataResponse {
            case .success(let success):
                repositoryDataList = success.item
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
