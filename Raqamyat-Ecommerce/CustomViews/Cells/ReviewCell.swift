//
//  ReviewCell.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 08/12/2022.
//

import UIKit
import Combine
import Cosmos

class ReviewCell: UICollectionViewCell {
    
    private let containerView: UIView = {
        let view = UIView(frame: .zero)
        view.layerBorderColor = ColorName.lightGray.color
        view.layerBorderWidth = 1
        view.layerCornerRadius = 8
        return view
    }()
    
    private lazy var containerStack: UIStackView = {
        let arrangedViews = [ratingView, titleLabel, descriptionLabel, reviewInformation]
        let stackView = UIStackView(arrangedSubviews: arrangedViews, axis: .vertical, spacing: 8)
        stackView.backgroundColor = ColorName.offGray.color
        return stackView
    }()
    
    private let ratingView: CosmosView = {
        var settings = CosmosSettings()
        settings.fillMode = .full
        settings.emptyImage = Asset.startEmpty.image
        settings.filledImage = Asset.starFill.image
        settings.starMargin = 6
        settings.updateOnTouch = false
        let view = CosmosView(frame: .zero, settings: settings)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = ColorName.black.color
        label.font = FontFamily.TTNormsPro.medium.font(size: 15)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel(text: "\n\n")
        label.font = FontFamily.Poppins.regular.font(size: 12)
        label.textColor = ColorName.darkGray.color
        label.numberOfLines = 2
        label.lineBreakMode = .byClipping
        return label
    }()
    
    private let ratingDate: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    private let reviewInformation: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = ColorName.gray.color
        label.font = FontFamily.Poppins.light.font(size: 11)
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewsLayoutConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with review: ProductReview) {
        ratingView.rating = review.rate
        titleLabel.text = review.title
        descriptionLabel.text = review.review + "\n"
        reviewInformation.text = review.createdAt + "\t" + L10n.by + review.createdBy
        descriptionLabel.sizeToFit()
        layoutIfNeeded()
    }
    
    private func setupViewsLayoutConstrains() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.addSubview(containerStack)
        containerStack.snp.makeConstraints { make in
            let insetValue: CGFloat = 16
            make.edges.equalToSuperview().inset(insetValue)
        }
    }
}
