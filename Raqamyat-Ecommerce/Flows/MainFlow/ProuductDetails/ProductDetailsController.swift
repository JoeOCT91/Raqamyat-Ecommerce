//
//  ProductDetailsController.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 08/12/2022.
//

import UIKit
import Combine

protocol ProductDetailsControllerProtocol: AnyObject {
    var onFinishFlowPublisher: PassthroughSubject<Void, Never> { get }
    var onCartTapPublisher: PassthroughSubject<Void, Never> { get }
    var onProductTapPublisher: PassthroughSubject<Void, Never> { get}
    var onSizeGuideTapPublisher: PassthroughSubject<Void, Never> { get }
    var onShowReviewsTapPublisher: PassthroughSubject<Void, Never> { get }
}

final class ProductDetailsController: UIViewController, ProductDetailsControllerProtocol {

    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Coordinator helpers ...
    //----------------------------------------------------------------------------------------------------------------
    let onFinishFlowPublisher = PassthroughSubject<Void, Never>()
    let onCartTapPublisher = PassthroughSubject<Void, Never>()
    let onProductTapPublisher = PassthroughSubject<Void, Never>()
    let onSizeGuideTapPublisher = PassthroughSubject<Void, Never>()
    var onShowReviewsTapPublisher = PassthroughSubject<Void, Never>()
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Properties ...
    //----------------------------------------------------------------------------------------------------------------
    typealias DataSource = UICollectionViewDiffableDataSource<ProductDetailsSection, ProductDetailsSection.SectionItem>
    var dataSource: DataSource!
    
    private var subscriptions = Set<AnyCancellable>()
    private var viewModel: ProductDetailsViewModelProtocol
    private var contentView: ProductDetailsView
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Life cycle methods ...
    //----------------------------------------------------------------------------------------------------------------
    init(viewModel: ProductDetailsViewModelProtocol, view: ProductDetailsView) {
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
        configureDataSource()
        configureDataSourceSupplementaryView()
        bindViewModelDataStreamsToView()
        bindViewInteractionsDownstreamToViewModel()
    }
}

extension ProductDetailsController {
    private func bindViewModelDataStreamsToView() {
        bindToDataSourceSnapshotDownStream()
    }
    
    private func bindViewInteractionsDownstreamToViewModel() {
        bindToCartTapInteractionDownstream()
        bindToDismissTapInteractionDownStream()
    }
    
    private func bindToDataSourceSnapshotDownStream() {
        viewModel.dataSourceSnapShotPublisher
            .receive(on: RunLoop.main)
            .sink { [unowned self] snapshot in
                self.dataSource.apply(snapshot)
            }.store(in: &subscriptions)
    }
    
    private func bindToCartTapInteractionDownstream() {
        contentView.cartTapPublisher
            .sink { [unowned self] _ in
                self.onCartTapPublisher.send()
            }.store(in: &subscriptions)
    }
    
    private func bindToDismissTapInteractionDownStream() {
        contentView.dismissTapPublisher
            .receive(on: RunLoop.main)
            .sink { [unowned self] _ in
                self.onFinishFlowPublisher.send()
            }.store(in: &subscriptions)
    }
    
    private func configureDataSource() {
        dataSource = DataSource(collectionView: contentView.collectionView, cellProvider: { [unowned self] collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .imageURl(let imageURL):
                let cell = self.productsImageCellProvider(collectionView: collectionView, indexPath: indexPath, imageURL: imageURL)
                return cell
            case .productSize(let size):
                let cell = self.productsSizeCellProvider(collectionView: collectionView, indexPath: indexPath, size: size)
                return cell
            case .productColor(let color):
                let cell = productsSizeCellProvider(collectionView: collectionView, indexPath: indexPath, color: color)
                return cell
            case .productReview(let review):
                let cell = self.productReviewCellProvider(collectionView: collectionView, indexPath: indexPath, review: review)
                return cell
            case .suggestedProduct(let product):
                let cell = self.suggestedProductCellProvider(collectionView: collectionView, indexPath: indexPath, product: product)
                return cell
            }
        })
    }
    
    private func productsImageCellProvider(collectionView: UICollectionView, indexPath: IndexPath, imageURL: String) -> UICollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.productImageCell, for: indexPath) as? ProductImageCell
        cell?.configure(with: imageURL)
        return cell
    }
    
    private func productsSizeCellProvider(collectionView: UICollectionView, indexPath: IndexPath, size: ProductSize) -> UICollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.productSizeCell, for: indexPath) as? ProductSizeCell
        cell?.configure(with: size)
        return cell
    }
    
    private func productsSizeCellProvider(collectionView: UICollectionView, indexPath: IndexPath, color: ProductColor) -> UICollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.productColorCell, for: indexPath) as? ProductColorCell
        cell?.configure(with: color)
        return cell
    }
    
    private func productReviewCellProvider(collectionView: UICollectionView, indexPath: IndexPath, review: ProductReview) -> UICollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.reviewCell, for: indexPath) as? ReviewCell
        cell?.configureCell(with: review)
        return cell
    }
    
    private func suggestedProductCellProvider(collectionView: UICollectionView, indexPath: IndexPath, product: SuggestedProduct) -> UICollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.productCell, for: indexPath) as? ProductCell
        cell?.configureCell(with: product)
        return cell
    }
    
    private func configureDataSourceSupplementaryView() {
        dataSource.supplementaryViewProvider = { [unowned self] collectionView, kind, indexPath -> UICollectionReusableView? in
            guard let section = ProductDetailsSection.SectionIdentifier.allCases[safe: indexPath.section] else { return nil }
            switch section {
            case .productImages:
                return self.ProductImagesSupplementary(collectionView: collectionView, kind: kind, indexPath: indexPath)
            case .productSizes:
                return self.productSizesSupplementary(collectionView: collectionView, kind: kind, indexPath: indexPath)
            case .productColors:
                return self.productColorsSupplementary(collectionView: collectionView, kind: kind, indexPath: indexPath)
            case .productReviews:
                return self.productReviewsSupplementary(collectionView: collectionView, kind: kind, indexPath: indexPath)
            case .suggestedProducts:
                return self.suggestedProductSupplementary(collectionView: collectionView, kind: kind, indexPath: indexPath)
            }
        }
    }
        
    private typealias SectionHeader = ProductDetailsSectionHeader
    private typealias ImagesFooter = ProductDetailsCompactView
    private func ProductImagesSupplementary(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> ImagesFooter? {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kind, for: indexPath) as? ImagesFooter
        guard let view else { return nil }
        viewModel.productPublisher.assign(to: \.product, on: view).store(in: &view.subscriptions)
        view.addToCartTapPublisher.sink { _ in
            print("Add to cart button tap call back ...")
        }.store(in: &view.subscriptions)
        view.addToFavoriteTapPublisher.sink { _ in
            print("Add to product to favorite tap call back ...")
        }.store(in: &view.subscriptions)
        return view
    }

    private func productSizesSupplementary(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kind, for: indexPath) as? SectionHeader
        view?.tapSubscription = view?.tapPublisher.sink(receiveValue: { [unowned self] _ in
            print("product Sizes Supplementary tap call to action call back")
            self.onSizeGuideTapPublisher.send()
        })
        view?.trailingCustomView = contentView.productSizesHeaderCustomView
        view?.title = L10n.selectSize
        return view
    }
    
    private func productColorsSupplementary(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        guard let viewKind = ProductColorsSectionReusableView(rawValue: kind) else { return nil }
        switch viewKind {
        case .header:
            return productColorsHeader(collectionView: collectionView, kind: kind, indexPath: indexPath)
        case .footer:
            return productColorsFooter(collectionView: collectionView, kind: kind, indexPath: indexPath)
        }
    }
    
    private func productColorsHeader(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kind, for: indexPath) as? SectionHeader
        view?.title = L10n.selectColor
        return view
    }
    
    typealias ColorFooter = ProductDescriptionView
    private func productColorsFooter(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kind, for: indexPath) as? ColorFooter
        view?.content = viewModel.product?.description
        return view
    }

    private func productReviewsSupplementary(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kind, for: indexPath) as? SectionHeader
        view?.tapSubscription = view?.tapPublisher.sink(receiveValue: { [unowned self] in
            print("product reviews Supplementary tap call to action call back")
            self.onShowReviewsTapPublisher.send()
        })
        view?.trailingCustomView = contentView.productReviewsHeaderCustomView
        view?.title = L10n.reviews
        return view
    }
    
    private func suggestedProductSupplementary(collectionView: UICollectionView, kind: String, indexPath: IndexPath) ->  UICollectionReusableView? {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kind, for: indexPath) as? SectionHeader
        view?.title = L10n.suggestedProductsHeaderTitle
        return view
    }
}

fileprivate enum ProductColorsSectionReusableView: String {
    
    case header
    case footer
    
    init?(rawValue: String) {
        switch rawValue {
        case SupplementariesKind.productDetailsHeader:
            self = .header
        case SupplementariesKind.productDescription:
            self = .footer
        default:
            return nil
        }
    }
}
