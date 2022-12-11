//
//  CoordinatorFactory.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 07/12/2022.
//

import Foundation

class CoordinatorFactory {
    
}

extension CoordinatorFactory: ApplicationCoordinatorFactory {
    
    func createSplashCoordinator(router: AnyRouter) -> SplashCoordinatorOutput {
        let splashModuleFactory = ModuleFactory()
        let coordinator = SplashCoordinator(router: router, factory: splashModuleFactory)
        return coordinator
    }
    
    func createMainCoordinator(router: AnyRouter) -> ProductsCoordinatorOutput {
        let mainModuleFactory = ModuleFactory()
        let coordinator = ProductsCoordinator(router: router, factory: mainModuleFactory)
        return coordinator
    }
}

