//
//  ProductsView.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 07/12/2022.
//

import UIKit
import MJRefresh

class ProductsView: UIView {
    
    var collectionView: UICollectionView {
        return productsCollectionView
    }
    
    private lazy var productsCollectionView: UICollectionView = {
        let layout = generateCollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: Cells.productCell)
        let footer = MJRefreshAutoNormalFooter().link(to: collectionView).autoChangeTransparency(true)
        footer.stateLabel?.font = FontFamily.Poppins.regular.font(size: 14)
        footer.stateLabel?.textColor = ColorName.black.color
        return collectionView
    }()
    
    private let collectionViewHeaderView: ProductsCollectionViewHeader = {
        let view = ProductsCollectionViewHeader()
        return view
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
        addSubview(collectionViewHeaderView)
        addSubview(collectionView)
        
        collectionViewHeaderView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(collectionViewHeaderView.snp.bottom).offset(2)
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
            section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
            return section
        })
    }
}

class ProductsCollectionViewHeader: UIView {
    
    typealias HeaderItem = ProductsCollectionViewHeaderItem
    private lazy var containerView: UIStackView = {
        let arrangedViews = [filterBy, sortBy, result]
        let stackView = UIStackView(arrangedSubviews: arrangedViews, axis: .horizontal,spacing: 1, distribution: .fillEqually)
        return stackView
    }()
    
    private let filterBy: HeaderItem = {
        let item = HeaderItem(image: Asset.downArrow.image, title: L10n.filterBy)
        return item
    }()
    
    private let sortBy: HeaderItem = {
        let item = HeaderItem(image: Asset.downArrow.image, title: L10n.sortBy)
        return item
    }()
    
    private let result: HeaderItem = {
        let item = HeaderItem(image: Asset.iconList.image, title: L10n.result)
        return item
    }()
    
    init() {
        super.init(frame: .zero)
        setViewsLayoutConstrains()
        backgroundColor = ColorName.lightGray.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewsLayoutConstrains() {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(1)
            make.leading.trailing.equalToSuperview()
        }
    }
}

class ProductsCollectionViewHeaderItem: UIView {
     
    private lazy var containerStack: UIStackView = {
        let arrangedView = [titleLabel, imageView]
        let stackView = UIStackView(arrangedSubviews: arrangedView, axis: .horizontal, spacing: 12, distribution: .fillProportionally)
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = FontFamily.Poppins.light.font(size: 14)
        label.textColor = ColorName.gray.color
        return label
    }()
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init(image: UIImage?, title: String?) {
        super.init(frame: .zero)
        backgroundColor = ColorName.white.color
        setViewsLayoutConstrains()
        imageView.image = image
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewsLayoutConstrains() {
        addSubview(containerStack)
        containerStack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.centerX.equalToSuperview()
        }
    }
    
}
