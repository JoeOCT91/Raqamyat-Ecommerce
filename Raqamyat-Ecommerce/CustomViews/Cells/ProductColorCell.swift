//
//  ProductColorCell.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 09/12/2022.
//

import UIKit

class ProductColorCell: UICollectionViewCell {
    
    private let measure :CGFloat = 16
    
    private let outerView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    private let innerView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewsLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        innerView.layerCornerRadius =  innerView.width / 2
    }
    
    func configure(with color: ProductColor) {
        innerView.backgroundColor = UIColor(hexString: color.colorHex)
        layoutIfNeeded()
    }
    
    private func setupViewsLayoutConstraints() {
        contentView.addSubview(outerView)
        outerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.addSubview(innerView)
        innerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(measure)
        }
    }
}
