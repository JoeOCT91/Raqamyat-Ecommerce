//
//  ApplicationCoordinatorFactory.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 07/12/2022.
//

import Foundation

protocol ApplicationCoordinatorFactory {
    func createSplashCoordinator(router: AnyRouter) -> SplashCoordinatorOutput
    func createMainCoordinator(router: AnyRouter) -> MainCoordinatorOutput
}
