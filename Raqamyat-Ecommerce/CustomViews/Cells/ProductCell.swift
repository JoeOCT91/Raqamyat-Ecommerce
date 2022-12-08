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
        setupViewsLayoutConstrains()
    }
    
    override func prepareForReuse() {
        self.tapSubscriptions?.cancel()
    }
    
    func configureCell(with product: Product) {
        productNameLabel.text = product.name
        productPriceLabel.text = product.price + "" + L10n.egyptianPound
        
        guard let productImageURL = URL(string: product.image) else { return }
        productImage.kf.setImage(with: productImageURL)
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
        
        contentContainerView.addSubview(rateButton)
        rateButton.snp.makeConstraints { make in
            make.trailing.top.equalTo(productImage)
        }
        
        productImage.snp.makeConstraints { make in
            make.height.equalTo(productImage.snp.width).multipliedBy(1.20)
        }
    }
}
