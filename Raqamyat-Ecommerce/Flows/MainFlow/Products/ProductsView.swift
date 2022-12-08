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
    
    private var innerItemsSpacing: CGFloat = 14
    
    init() {
        super.init(frame: .zero)
        backgroundColor = ColorName.white.color
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
        return Layout (sectionProvider: { [unowned self] sectionIndex, layoutEnvironment  in
            let isWideView = layoutEnvironment.container.effectiveContentSize.width > 500
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: isWideView ? 4 : 2)
            group.interItemSpacing = .fixed(self.innerItemsSpacing)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = self.innerItemsSpacing
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 22, bottom: 0, trailing: 22)
            return section
        })
    }
}

class ProductsCollectionViewHeader: UIView {

    
}

class ProductsCollectionViewHeaderItem: UIView {
     
}
