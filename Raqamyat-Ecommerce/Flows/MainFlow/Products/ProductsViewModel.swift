//
//  HomeViewModel.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 07/12/2022.
//

import UIKit.NSDiffableDataSourceSectionSnapshot
import Foundation
import Combine

protocol HomeViewModelProtocol: AnyObject {
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<HomeController.Section, Product>
    var datasourceSnapshotPublisher: Published<DataSourceSnapshot>.Publisher { get }
}

class HomeViewModel: HomeViewModelProtocol {
    
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<HomeController.Section, Product>
    @Published private var snapshot: DataSourceSnapshot
    var datasourceSnapshotPublisher: Published<DataSourceSnapshot>.Publisher { $snapshot }
    
    
    private var subscriptions = Set<AnyCancellable>()
    private let repository: ProductsRepositoryProtocol

    init(repository: ProductsRepositoryProtocol) {
        self.repository = repository
        self.snapshot = DataSourceSnapshot()
        bindToProductsListDownStream()
    }
    
    private func bindToProductsListDownStream() {
        repository.productsListPublisher
            .sink { [weak self] productsList in
                guard let self else { return }
                self.createDataSourceSnapshot(using: productsList)
            }.store(in: &subscriptions)
    }
    
    private func createDataSourceSnapshot(using dataList: [Product]) {
        var snapshot = DataSourceSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(dataList, toSection: .main)
        self.snapshot = snapshot
    }
}
