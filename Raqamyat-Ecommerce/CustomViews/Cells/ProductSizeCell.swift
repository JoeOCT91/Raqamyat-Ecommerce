//
//  SizeCell.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 09/12/2022.
//

import UIKit

class ProductSizeCell: UICollectionViewCell {
    
    private let containerView: UIView = {
        let view = UIView(frame: .zero)
        view.layerBorderColor = ColorName.gray.color
        view.layerBorderWidth = 1
        return view
    }()
    
    private let sizeLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = ColorName.gray.color
        view.font = FontFamily.Poppins.regular.font(size: 14)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViewsLayoutConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with size: ProductSize) {
        self.sizeLabel.text = size.name
    }
    
    private func setupViewsLayoutConstrains() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.addSubview(sizeLabel)
        sizeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
