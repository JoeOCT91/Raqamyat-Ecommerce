//
//  Home.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 07/12/2022.
//

import UIKit
import Combine

protocol HomeControllerProtocol: Presentable {
    var onProductTapPublisher: PassthroughSubject<Product, Never> { get }
    var onCartTapPublisher: PassthroughSubject<Void, Never> { get }
}

final class ProductsController: ViewController, HomeControllerProtocol {
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Coordinator helpers ...
    //----------------------------------------------------------------------------------------------------------------
    var onProductTapPublisher = PassthroughSubject<Product, Never>()
    var onCartTapPublisher = PassthroughSubject<Void, Never>()
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Properties ...
    //----------------------------------------------------------------------------------------------------------------
    enum Section: Hashable {
        case main
    }
    
    private typealias DataSource = UICollectionViewDiffableDataSource<ProductsController.Section, Product>
    private var dataSource: DataSource!

    private var viewModel: ProductsViewModelProtocol
    private var contentView: ProductsView
    private var subscriptions = Set<AnyCancellable>()
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Life cycle methods ...
    //----------------------------------------------------------------------------------------------------------------
    init(viewModel: ProductsViewModelProtocol, view: ProductsView) {
        self.contentView = view
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleView()
        setupNavigationBarCartButton()
        configureCollectionViewDataSource()
        bindViewModelDataStreamsToView()
        bindViewInteractionsDownstreamToViewModel()
    }
    
    override func showLoader() {
        super.showLoader()
    }
    
    override func hideLoader() {
        super.hideLoader()
        contentView.collectionView.mj_footer?.endRefreshing()
    }
    
    private func setupNavigationBarCartButton() {
        let button = UIButton(frame: .zero)
        button.setImage(Asset.navigationBarCart.image, for: .normal)
        let customView = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = customView
        button.tapPublisher
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .sink { [unowned self] _ in
            print("navigation bar cart button tap publisher >>>>>")
            self.onCartTapPublisher.send()
        }.store(in: &subscriptions)
    }
    
    private func setupTitleView() {
        
    }
}
//----------------------------------------------------------------------------------------------------------------
//=======>MARK: -  Private methods ...
//----------------------------------------------------------------------------------------------------------------
extension ProductsController {
    //=======>MARK: -  Data source configuration ...
    private func configureCollectionViewDataSource() {
        dataSource = DataSource(collectionView: contentView.collectionView) {  [unowned self] collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.productCell, for: indexPath) as? ProductCell
            cell?.tapSubscriptions = cell?.tapPublisher.sink(receiveValue: { [unowned self] in
                self.onProductTapPublisher.send(itemIdentifier)
            })
            cell?.configureCell(with: itemIdentifier)
            return cell
        }
    }
    
    private func bindViewModelDataStreamsToView() {
        bindToDataSourceSnapshotDownstream()
        bindToNoMoreDataDownStream()
    }
    
    private func bindToDataSourceSnapshotDownstream() {
        viewModel.datasourceSnapshotPublisher
            .receive(on: RunLoop.main)
            .sink { [unowned self] snapshot in
                self.dataSource.apply(snapshot)
            }.store(in: &subscriptions)
    }
    private func bindToNoMoreDataDownStream() {
        viewModel.noMoreProductsPublisher
            .receive(on: RunLoop.main)
            .sink { [unowned self] _ in
                self.contentView.collectionView.mj_footer?.endRefreshingWithNoMoreData()
            }.store(in: &subscriptions)
    }
    private func bindViewInteractionsDownstreamToViewModel() {
        bindCollectionViewLoadMoreBlockWithViewModel()
    }
    
    private func bindCollectionViewLoadMoreBlockWithViewModel() {
        contentView.collectionView.mj_footer?.refreshingBlock = { [unowned self] in
            self.viewModel.loadMoreProducts()   
        }
    }
    
}
