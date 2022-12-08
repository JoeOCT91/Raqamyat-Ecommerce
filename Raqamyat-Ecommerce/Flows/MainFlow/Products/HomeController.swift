//
//  Home.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 07/12/2022.
//

import UIKit
import Combine

protocol HomeControllerProtocol: Presentable {
    var onProductTapPublisher: PassthroughSubject<Int, Never> { get }
}

final class HomeController: UIViewController, HomeControllerProtocol {
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Coordinator helpers ...
    //----------------------------------------------------------------------------------------------------------------
    var onProductTapPublisher = PassthroughSubject<Int, Never>()
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Properties ...
    //----------------------------------------------------------------------------------------------------------------
    enum Section: Hashable {
        case main
    }
    
    private typealias DataSource = UICollectionViewDiffableDataSource<HomeController.Section, Product>
    private var dataSource: DataSource!

    private var viewModel: HomeViewModelProtocol
    private var contentView: ProductsView
    private var subscriptions = Set<AnyCancellable>()
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Life cycle methods ...
    //----------------------------------------------------------------------------------------------------------------
    init(viewModel: HomeViewModelProtocol, view: ProductsView) {
        self.contentView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionViewDataSource()
        bindViewModelDataStreamsToView()
        bindViewInteractionsDownstreamToViewModel()
    }
}

extension HomeController {
    
    private func configureCollectionViewDataSource() {
        dataSource = DataSource(collectionView: contentView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            nil
        })
    }
    
    private func bindViewModelDataStreamsToView() {
        bindToDataSourceSnapshotDownstream()
    }
    
    private func bindViewInteractionsDownstreamToViewModel() {
        
    }
    
    private func bindToDataSourceSnapshotDownstream() {
        viewModel.datasourceSnapshotPublisher
            .receive(on: RunLoop.main)
            .sink { [unowned self] snapshot in
                self.dataSource.apply(snapshot)
            }.store(in: &subscriptions)
    }
}
