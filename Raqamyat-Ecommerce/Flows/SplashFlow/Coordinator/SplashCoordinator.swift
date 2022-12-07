//
//  SplashCoordinator.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 07/12/2022.
//

import Foundation
import Combine

protocol SplashCoordinatorOutput: AnyCoordinator {
    var finishFlowPublisher: PassthroughSubject<Void, Never> { get }
}

final class SplashCoordinator: BaseCoordinator, SplashCoordinatorOutput {
    
    var finishFlowPublisher = PassthroughSubject<Void, Never>()
    
    private let factory: SplashModuleFactory
    private let router: AnyRouter
    
    init(router: AnyRouter, factory: SplashModuleFactory) {
        self.factory = factory
        self.router = router
    }
    
    override func start() {
        self.showSplash()
    }
    
    private func showSplash() {
        let splashOutput = factory.createSplashHandler()
        router.setRootModule(splashOutput)
    }
}
