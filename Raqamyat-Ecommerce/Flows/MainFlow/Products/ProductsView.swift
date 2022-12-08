//
//  ProductsView.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 07/12/2022.
//

import UIKit

class ProductsView: UIView {
    
    var collectionView: UICollectionView {
        return productsCollectionView
    }
    
    private lazy var productsCollectionView: UICollectionView = {
        let layout = generateCollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: Cells.productCell)
        return collectionView
    }()
    
    init() {
        super.init(frame: .zero)
        setupViewsLayoutConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewsLayoutConstrains() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    typealias Layout = UICollectionViewCompositionalLayout
    private func generateCollectionViewLayout() -> Layout {
        return Layout (sectionProvider: { sectionIndex, layoutEnvironment  in
            let isWideView = layoutEnvironment.container.effectiveContentSize.width > 500
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: isWideView ? 4 : 2)
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        })
    }
}

class ProductsCollectionViewHeader: UIView {

    
}

class ProductsCollectionViewHeaderItem: UIView {
     
}
