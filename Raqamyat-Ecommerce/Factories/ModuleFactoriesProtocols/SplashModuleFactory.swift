//
//  SplashModuleFactory.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 07/12/2022.
//

import Foundation

protocol SplashModuleFactory {
    func createSplashHandler() -> SplashControllerHandler
}

extension ModuleFactory: SplashModuleFactory {
    
    func createSplashHandler() -> SplashControllerHandler {
        let view = SplashView()
        //let repository
        let viewModel = SplashViewModel()
        let controller = SplashController(viewModel: viewModel, view: view)
        return controller
    }
    
    
}
 
