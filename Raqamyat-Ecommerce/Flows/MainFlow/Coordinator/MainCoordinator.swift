//
//  MainCoordinator.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 07/12/2022.
//

import Foundation
import Combine

protocol MainCoordinatorOutput: AnyCoordinator {
    
}

final class MainCoordinator: BaseCoordinator, MainCoordinatorOutput {
    
    var finishFlowPublisher = PassthroughSubject<Void, Never>()
    
    private let factory: MainModuleFactory
    private let router: AnyRouter
    
    init(router: AnyRouter, factory: MainModuleFactory) {
        self.factory = factory
        self.router = router
    }
    
    override func start() {
        self.showHome()
    }
    
    private func showHome() {
        let homeOutput = factory.createHomeOutput()
        router.setRootModule(homeOutput)
    }
    
    private func pushProductDetails(forProduct withId: Int) {
        let productDetailsHandler = factory
    }
}
