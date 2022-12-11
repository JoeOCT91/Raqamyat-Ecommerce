//
//  ProductDetailsCompactView.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 09/12/2022.
//

import UIKit
import Combine
import Cosmos

final class ProductDetailsCompactView: UICollectionReusableView {

    var subscriptions = Set<AnyCancellable>()
    @Published var product: Product?
    
    let paginationView = UIView(frame: .zero)
    
    var addToCartTapPublisher: AnyPublisher<Void, Never> {
        return addToCartButton
            .tapPublisher
            .eraseToAnyPublisher()
    }
    
    var addToFavoriteTapPublisher: AnyPublisher<Void, Never> {
        return addToFavoriteButton
            .tapPublisher
            .eraseToAnyPublisher()
    }
    
    let contentView: UIView = {
        let view = UIView( frame: .zero)
        view.backgroundColor = ColorName.white.color
        view.layerCornerRadius = 21
        return view
    }()

    private let gripView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = ColorName.black.color
        view.layerCornerRadius = 2
        return view
    }()
    
    private lazy var containerStack: UIStackView = {
        let arrangedViews = [productNameLabel, horizontalSubContainerStack, ratingStack, buttonsStack]
        let stackView = UIStackView(arrangedSubviews: arrangedViews, axis: .vertical, spacing: 12, distribution: .equalSpacing)
        return stackView
    }()
    
    private let productNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = FontFamily.Poppins.regular.font(size: 16)
        label.textColor = ColorName.black.color
        return label
    }()
    
    private lazy var horizontalSubContainerStack: UIStackView = {
        let arrangedViews = [priceLabel, oldPriceLabel, itemCountControls]
        let stackView = UIStackView(arrangedSubviews: arrangedViews, axis: .horizontal, distribution: .equalSpacing)
        return stackView
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = FontFamily.Poppins.bold.font(size: 16)
        label.textColor = ColorName.black.color
        return label
    }()
    
    private let oldPriceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = FontFamily.Poppins.light.font(size: 12)
        label.textColor = ColorName.gray.color
        return label
    }()
    
    private let itemCountControls: ItemsCountController = {
        let view = ItemsCountController()
        return view
    }()
    
    private lazy var ratingStack: UIStackView = {
        let arrangedView = [ratingView, reviewsCountView]
        let stackView = UIStackView(arrangedSubviews: arrangedView, axis: .horizontal,spacing: 22,  alignment: .leading, distribution: .fillProportionally)
        return stackView
    }()
    
    private let ratingView: CosmosView = {
        var settings = CosmosSettings()
        settings.fillMode = .full
        settings.emptyImage = Asset.startEmpty.image
        settings.filledImage = Asset.starFill.image
        settings.starMargin = 6
        settings.updateOnTouch = false
        let view = CosmosView(settings: settings)
        view.setContentCompressionResistancePriority(.required, for: .vertical)
        view.setContentHuggingPriority(.required, for: .horizontal)
        return view
    }()
    
    private let reviewsCountView: UILabel = {
        let label = UILabel(text: "( 0 reviews )")
        label.font = FontFamily.Poppins.regular.font(size: 12)
        label.textColor = ColorName.gray.color
        return label
    }()
    
    private lazy var buttonsStack: UIStackView = {
        let arrangedViews = [addToCartButton, addToFavoriteButton]
        let stackView = UIStackView(arrangedSubviews: arrangedViews, axis: .horizontal, spacing: 18, distribution: .fill)
        return stackView
    }()
    
    private let addToCartButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitleForAllStates(L10n.addToCart)
        button.backgroundColor = ColorName.black.color
        return button
    }()
    
    private let addToFavoriteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImageForAllStates(Asset.favorite.image)
        button.setContentCompressionResistancePriority(.required, for: .vertical)
        button.contentMode = .center
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewsLayoutConstrains()
        bindToProductDataFlowDownStream()
    }
    
    override func prepareForReuse() {
        subscriptions.forEach { subscription in
            subscription.cancel()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindToProductDataFlowDownStream() {
        $product
            .receive(on: DispatchQueue.main)
            .compactMap({$0})
            .sink { [weak self] product in
                guard let self else { return }
                self.configureView(with: product)
            }.store(in: &subscriptions)
    }
    
    private func configureView(with product: Product) {
        productNameLabel.text = product.name.uppercased()
        priceLabel.text = product.price + L10n.egyptianPound
        ratingView.rating = product.rate
        reviewsCountView.text =  "(" + product.reviewCount.string + " " + L10n.reviews.lowercased() + ")"
        oldPriceLabel.attributedText = product.priceBeforeDiscount
        
        
    }
    
    private func setupViewsLayoutConstrains() {
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            let sectionOverlayValue: CGFloat = -70
            make.top.equalToSuperview().inset(sectionOverlayValue)
            make.leading.trailing.bottom.equalToSuperview()
        }
        contentView.addSubview(gripView)
        gripView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview().inset(8)
            make.height.equalTo(2)
            make.width.equalTo(45)
        }
        contentView.addSubview(containerStack)
        containerStack.snp.makeConstraints { make in
            make.top.equalTo(gripView.snp.bottom).offset(15)
            let edgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
            make.leading.trailing.bottom.equalToSuperview().inset(edgeInsets)
        }
    }
}

class ItemsCountController: UIView {
    
    private lazy var containerStack: UIStackView = {
        let arrangedViews = [incrementButton, countLabel, decrementButton]
        let stackView = UIStackView(arrangedSubviews: arrangedViews, axis: .horizontal, spacing: 8)
        return stackView
    }()
    
    private let incrementButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImageForAllStates(Asset.incrementIcon.image)
        return button
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel(text: "0")
        label.font = FontFamily.Poppins.bold.font(size: 16)
        label.textColor = ColorName.black.color
        return label
    }()
    
    private let decrementButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImageForAllStates(Asset.decrementIcon.image)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupViewsLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewsLayoutConstraints() {
        addSubview(containerStack)
        containerStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
