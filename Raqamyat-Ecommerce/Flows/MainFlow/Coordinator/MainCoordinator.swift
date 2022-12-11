//
//  ProductsCoordinator.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 07/12/2022.
//

import Foundation
import Combine

protocol ProductsCoordinatorOutput: AnyCoordinator {
    var finishFlowPublisher: PassthroughSubject<Void, Never> { get }
}

final class ProductsCoordinator: BaseCoordinator, ProductsCoordinatorOutput {
    
    var finishFlowPublisher = PassthroughSubject<Void, Never>()
    
    private let factory: MainModuleFactory
    private let router: AnyRouter
    
    init(router: AnyRouter, factory: MainModuleFactory) {
        self.factory = factory
        self.router = router
    }
    
    override func start() {
        self.showProducts()
    }
    
    private func showProducts() {
        let productsOutput = factory.createHomeOutput()
        productsOutput.onProductTapPublisher.sink { [unowned self] tapedProduct in
            self.presentProductDetails(for: tapedProduct)
        }.store(in: &subscriptions)
        productsOutput.onCartTapPublisher.sink { [unowned self] in
            self.presentCart()
        }.store(in: &subscriptions)
        router.setRootModule(productsOutput)
    }
    
    private func presentProductDetails(for product: Product) {
        let productDetailsHandler = factory.createProductDetailsHandler(for: product)
        productDetailsHandler.onFinishFlowPublisher.sink { [unowned self] in
            self.router.dismissModule()
        }.store(in: &subscriptions)
        router.present(productDetailsHandler)
    }
    
    private func presentCart() {
        
    }
}
