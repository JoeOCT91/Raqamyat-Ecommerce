//
//  ProductCell.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 08/12/2022.
//

import UIKit
import Combine
import Kingfisher

class ProductCell: UICollectionViewCell {
    
    var tapSubscriptions: AnyCancellable?
    var tapPublisher: AnyPublisher<Void, Never> {
        return tapGesture.tapPublisher
            .flatMap({ _ in CurrentValueSubject<Void,Never>(()) })
            .eraseToAnyPublisher()
    }
    
    private var tapGesture: UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer()
        return tapGesture
    }()
    
    private var contentContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.layerBorderColor = ColorName.lightGray.color
        view.layerBorderWidth = 1
        view.layerCornerRadius = 8
        return view
    }()
    
    private var discountView: UIView = {
        let  view = UIView(frame: .zero)
        return view
    }()
    
    private let discountBackGroundImage: UIImageView = {
        let imageView = UIImageView(image: Asset.discountRect.image)
        return imageView
    }()
    private let discountValueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = FontFamily.Lato.regular.font(size: 11)
        label.textColor = ColorName.white.color
        return label
    }()
    
    private lazy var containerStack: UIStackView = {
        let arrangedViews = [productImage, productNameLabel, productPriceLabel]
        let stackView = UIStackView(arrangedSubviews: arrangedViews, axis: .vertical, spacing: 8)
        return stackView
    }()
    
    private var productImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.kf.indicatorType = .activity
        imageView.contentMode = .scaleAspectFill
        imageView.layerCornerRadius = 6
        return imageView
    }()
    
    private var productNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = FontFamily.TTNormsPro.regular.font(size: 15)
        label.textColor = ColorName.gray.color
        return label
    }()
    
    private var productPriceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = FontFamily.TTNormsPro.bold.font(size: 12)
        label.textColor = ColorName.black.color
        return label
    }()
    
    private let rateButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(Asset.rateEmpty.image, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addGestureRecognizer(tapGesture)
        setupViewsLayoutConstrains()
    }
    
    override func prepareForReuse() {
        self.tapSubscriptions?.cancel()
    }
    
    func configureCell(with product: any AnyProduct) {
        productNameLabel.text = product.name
        productPriceLabel.text = product.price + L10n.egyptianPound
        discountValueLabel.text = (product.percentage ?? "0") + "%" + L10n.percentageOff
        discountView.isHidden = !product.isHasDiscount
        setProductImage(using: product.image)
    }
    
    private func setProductImage(using urlString: String) {
        guard let productImageURL = URL(string: urlString) else { return }
        let resizingImageProcessor = ResizingImageProcessor(referenceSize: CGSize(width: contentView.size.width,
                                                                                   height: contentView.size.width * 1.20))
        productImage.kf.setImage(with: productImageURL, options: [.processor(resizingImageProcessor),
                                                                  .transition(.fade(0.4)),
                                                                  .loadDiskFileSynchronously,
                                                                  .cacheOriginalImage])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewsLayoutConstrains() {
        contentView.addSubview(contentContainerView)
        contentContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentContainerView.addSubview(containerStack)
        containerStack.snp.makeConstraints { make in
            let innerInsetValue = UIEdgeInsets(top: 9, left: 9, bottom: 14, right: 9)
            make.edges.equalToSuperview().inset(innerInsetValue)
        }
        contentContainerView.addSubview(discountView)
        discountView.snp.makeConstraints { make in
            let insets = NSDirectionalEdgeInsets(top: 4, leading: 16, bottom: 0, trailing: 0)
            make.top.leading.equalToSuperview().inset(insets)
        }
        discountView.addSubview(discountBackGroundImage)
        discountBackGroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        discountView.addSubview(discountValueLabel)
        discountValueLabel.snp.makeConstraints { make in
            let insets = NSDirectionalEdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 0)
            make.edges.equalToSuperview().inset(insets)
        }
        contentContainerView.addSubview(rateButton)
        rateButton.snp.makeConstraints { make in
            make.trailing.top.equalTo(productImage)
        }
        productImage.snp.makeConstraints { make in
            make.height.equalTo(productImage.snp.width).multipliedBy(1.20).priority(.medium)
        }
    }
}
