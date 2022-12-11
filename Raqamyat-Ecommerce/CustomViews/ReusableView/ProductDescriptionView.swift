//
//  ProductDescriptionHeader.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 09/12/2022.
//

import UIKit
import Combine

final class ProductDescriptionView: UICollectionReusableView {
    
    @Published var product: Product?
    var subscriptions = Set<AnyCancellable>()
    
    private lazy var containerStack: UIStackView = {
        let arrangedViews = [titleLabel, contentLabel]
        let stackView = UIStackView(arrangedSubviews: arrangedViews, axis: .vertical, spacing: 12, distribution: .equalSpacing)
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel(text: L10n.description)
        label.font = FontFamily.Poppins.medium.font(size: 14)
        label.textColor = ColorName.black.color
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = FontFamily.Poppins.light.font(size: 12)
        label.textColor = ColorName.gray.color
        label.numberOfLines = 0
        return label
    }()
    
    var content: String? {
        set(newValue) {
            self.contentLabel.text = newValue
        }
        get {
            return contentLabel.text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewsLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewsLayoutConstraints() {
        addSubview(containerStack)
        containerStack.snp.makeConstraints { make in
            let edgeInsets = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
            make.edges.equalToSuperview().inset(edgeInsets)
        }
    }
}
