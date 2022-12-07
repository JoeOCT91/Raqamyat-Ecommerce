//
//  HomeView.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 07/12/2022.
//

import UIKit

class HomeView: UIView {
    
    private lazy var productsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero)
        return collectionView
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
