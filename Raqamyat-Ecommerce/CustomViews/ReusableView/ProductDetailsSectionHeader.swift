//
//  ProductDetailsSectionHeader.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 09/12/2022.
//

import UIKit
import Combine

class ProductDetailsSectionHeader: UICollectionReusableView {
    
    private let tapGesture = UITapGestureRecognizer()
    var tapSubscription: AnyCancellable?
    var tapPublisher: AnyPublisher<Void, Never> {
        return tapGesture.tapPublisher
            .flatMap({ _ in CurrentValueSubject<Void,Never>(()) })
            .eraseToAnyPublisher()
    }
    
    private let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = ColorName.black.color
        label.adjustsFontForContentSizeCategory = true
        label.font = FontFamily.TTNormsPro.medium.font(size: 14)
        return label
    }()
    
    private var trailingView: UIStackView = {
        let view = UIStackView(frame: .zero)
        return view
    }()
    
    var trailingCustomView: UIView? {
        didSet {
            setupCustomView(trailingCustomView)
            layoutIfNeeded()
        }
    }
    
    var title: String? {
        didSet {
            label.text = title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewLayoutsConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCustomView(_ view: UIView?) {
        guard let view else { return }
        view.addGestureRecognizer(tapGesture)
        trailingView.removeArrangedSubviews()
        trailingView.addArrangedSubview(view)
    }
    
    private func setupViewLayoutsConstrains() {
        addSubview(label)
        addSubview(trailingView)

        label.snp.makeConstraints { make in
            let edgeInsets = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
            make.leading.top.bottom.equalToSuperview().inset(edgeInsets)
        }
        trailingView.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.leading.equalTo(label.snp.trailing).priority(.low)
        }
    }
}
