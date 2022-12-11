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
    
    func fetchProducts(inPage page: Int, fromCategory category: Int?)
    
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
    }

    
    func fetchProducts(inPage page: Int, fromCategory category: Int?) {
        Task {
            repositoryState = .loading
            let dataResponse = await destination.getProductsPaging(in: page, from: category)
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
