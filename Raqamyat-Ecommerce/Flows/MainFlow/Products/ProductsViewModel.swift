//
//  HomeViewModel.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 07/12/2022.
//

import UIKit.NSDiffableDataSourceSectionSnapshot
import Foundation
import Combine

protocol ProductsViewModelProtocol: AnyViewModel {
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<ProductsController.Section, Product>
    var datasourceSnapshotPublisher: Published<DataSourceSnapshot>.Publisher { get }
    var noMoreProductsPublisher: PassthroughSubject<Void, Never> { get }
    func loadMoreProducts()
}

class HomeViewModel: ViewModel, ProductsViewModelProtocol {
    
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<ProductsController.Section, Product>
    @Published private var snapshot: DataSourceSnapshot
    var datasourceSnapshotPublisher: Published<DataSourceSnapshot>.Publisher { $snapshot }
    var noMoreProductsPublisher = PassthroughSubject<Void, Never>()
    
    private let repository: ProductsRepositoryProtocol
    private var pagination: Pagination?

    init(repository: ProductsRepositoryProtocol) {
        self.repository = repository
        self.snapshot = DataSourceSnapshot()
        super.init(repository: repository)
        setInitialDataSourceSnapshot()
        bindToProductsListDownStream()
    }
    
    private func setInitialDataSourceSnapshot() {
        self.snapshot = DataSourceSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems([Product](), toSection: .main)
    }
    
    private func bindToProductsListDownStream() {
        repository.repositoryDataListPublisher.sink { [unowned self] repoResponseData in
            self.processRepoResponse(repoResponseData)
        }.store(in: &subscriptions)
    }
    
    private func processRepoResponse(_ response: APIResponseData<[Product]>) {
        let retrievedListOfProducts = response.data
        createDataSourceSnapshot(using: retrievedListOfProducts)
        guard let pagination = response.meta?.pagination else { return }
        self.pagination = pagination
    }
    
    private func createDataSourceSnapshot(using dataList: [Product]) {
        snapshot.appendItems(dataList, toSection: .main)
        self.snapshot = snapshot
    }
    
    func loadMoreProducts() {
        guard let pagination, pagination.currentPage < pagination.totalPages else {
            self.noMoreProductsPublisher.send()
            return
        }
        repository.fetchProducts(in: pagination.currentPage + 1)
    }
}
