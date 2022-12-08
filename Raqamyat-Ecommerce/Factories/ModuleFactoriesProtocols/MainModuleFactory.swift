//
//  MainModuleFactory.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 07/12/2022.
//

import Foundation

protocol MainModuleFactory: AnyObject {
    func createHomeOutput() -> HomeControllerProtocol
    func createProductDetailsHandler(forProduct withId: Int) -> ProductDetailsControllerProtocol
}

extension ModuleFactory: MainModuleFactory {
    
    func createHomeOutput() -> HomeControllerProtocol {
        let view = ProductsView()
        let repository = ProductsRepository()
        let viewModel = HomeViewModel(repository: repository)
        let controller = HomeController(viewModel: viewModel, view: view)
        return controller
    }
    
    func createProductDetailsHandler(forProduct withId: Int) -> ProductDetailsControllerProtocol {
        let view = ProductDetailsView()
        let viewModel = ProductDetailsViewModel()
        let controller = ProductDetailsController(viewModel: viewModel, view: view)
        return controller
    }
}
