//
//  ProductCell.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 08/12/2022.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    private lazy var containerStack: UIStackView = {
        let arrangedViews = [productImage, productNameLabel, productPriceLabel]
        let stackView = UIStackView(arrangedSubviews: arrangedViews)
        return stackView
    }()
    
    private var productImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        return imageView
    }()
    
    private var productNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    private var productPriceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func configureCell(with product: Product) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewsLayoutConstrains() {
        contentView.addSubview(containerStack)
        
    }
}
