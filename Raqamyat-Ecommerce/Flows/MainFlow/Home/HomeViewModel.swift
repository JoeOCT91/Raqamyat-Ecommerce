//
//  HomeViewModel.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 07/12/2022.
//

import Foundation
import Combine

protocol ProductsRepositoryProtocol {
    var productsListPublisher: AnyPublisher<[Product], Never> { get }
    
    func fetchProducts()
    func fetchMoreProducts()
}

final class ProductsRepository {
    
    init() {
        
    }
    
    
}

protocol HomeViewModelProtocol: AnyObject {
    
}

class HomeViewModel: HomeViewModelProtocol {
    
    private var subscriptions = Set<AnyCancellable>()
    private let repository: ProductsRepositoryProtocol

    init(repository: ProductsRepositoryProtocol) {
        self.repository = repository
    }
    
    private func bindToProductsListDownStream() {
        repository.productsListPublisher
            .sink { [weak self] productsList in
                guard let self else { return }
            }.store(in: &subscriptions)
    }
}
