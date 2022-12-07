//
//  MainModuleFactory.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 07/12/2022.
//

import Foundation

protocol MainModuleFactory: AnyObject {
    func createHomeOutput() -> HomeControllerProtocol
}

extension ModuleFactory: MainModuleFactory {
    
    func createHomeOutput() -> HomeControllerProtocol {
        let view = HomeView()
        let viewModel = HomeViewModel()
        let controller = HomeController(viewModel: viewModel, view: view)
        return controller
    }
    
    
}
