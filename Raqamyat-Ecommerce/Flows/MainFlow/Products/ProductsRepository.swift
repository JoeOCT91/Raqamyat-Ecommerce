//
//  ProductsRepository.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 08/12/2022.
//

import Foundation
import Combine

protocol ProductsRepositoryProtocol {
    var productsListPublisher: AnyPublisher<[Product], Never> { get }
    
    func fetchProducts()
    func fetchMoreProducts()
}

class ProductsRepository: ProductsRepositoryProtocol {
    
    @Published private var productsList = [Product]()
    var productsListPublisher: AnyPublisher<[Product], Never> {
        return $productsList.eraseToAnyPublisher()
    }
    
    init() {
        fetchProducts()
    }
    
    func fetchProducts() {
        Task {
            let dataResponse = await NetworkManger.shared().getProducts()
            switch dataResponse {
            case .success(let success):
                productsList = success.item.data
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchMoreProducts() {
        
    }
}
