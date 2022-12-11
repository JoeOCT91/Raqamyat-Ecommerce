//
//  MainModuleFactory.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 07/12/2022.
//

import Foundation

protocol MainModuleFactory: AnyObject {
    func createHomeOutput() -> HomeControllerProtocol
    func createProductDetailsHandler(for product: Product) -> ProductDetailsControllerProtocol & Presentable
}

extension ModuleFactory: MainModuleFactory {
    
    func createHomeOutput() -> HomeControllerProtocol {
        let view = ProductsView()
        let dataDestination = APIManager<ProductsAPIRouter>()
        let repository = ProductsRepository(destination: dataDestination)
        let viewModel = HomeViewModel(repository: repository)
        let controller = ProductsController(viewModel: viewModel, view: view)
        return controller
    }
    
    func createProductDetailsHandler(for product: Product) -> ProductDetailsControllerProtocol & Presentable {
        let view = ProductDetailsView(product: product)
        let dataDestination = APIManager<ProductsAPIRouter>()
        let repository = ProductDetailsRepository(destination: dataDestination)
        let viewModel = ProductDetailsViewModel(repository: repository, product: product)
        let controller = ProductDetailsController(viewModel: viewModel, view: view)
        return controller
    }
}
