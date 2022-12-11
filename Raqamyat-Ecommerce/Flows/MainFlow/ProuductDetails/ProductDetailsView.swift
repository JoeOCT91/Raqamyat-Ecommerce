//
//  ProductDetailsView.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 08/12/2022.
//

import UIKit
import Combine
import MJRefresh

class ProductDetailsView: UIView {
    
    var collectionView: UICollectionView {
        return detailsCollectionView
    }
    
    var dismissTapPublisher: AnyPublisher<Void, Never> {
        return dismissButton.tapPublisher.eraseToAnyPublisher()
    }
    
    var cartTapPublisher: AnyPublisher<Void, Never> {
        return dismissButton.tapPublisher.eraseToAnyPublisher()
    }

    private let insetValue: CGFloat = 16
    private let layoutProvider = CompositionalLayoutProvider()

    private lazy var detailsCollectionView: UICollectionView = {
        let layout = createCollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.insetsLayoutMarginsFromSafeArea = false
        collectionView.register(ProductImageCell.self, forCellWithReuseIdentifier: Cells.productImageCell)
        collectionView.register(ProductColorCell.self, forCellWithReuseIdentifier: Cells.productColorCell)
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: Cells.reviewCell)
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: Cells.productCell)
        collectionView.register(ProductSizeCell.self, forCellWithReuseIdentifier: Cells.productSizeCell)
        collectionView.register(ProductDetailsCompactView.self,
                                forSupplementaryViewOfKind: SupplementariesKind.productDetailsCompact,
                                withReuseIdentifier: SupplementariesKind.productDetailsCompact)
        collectionView.register(ProductDetailsSectionHeader.self,
                                forSupplementaryViewOfKind: SupplementariesKind.productDetailsHeader,
                                withReuseIdentifier: SupplementariesKind.productDetailsHeader)
        collectionView.register(ProductDescriptionView.self,
                                forSupplementaryViewOfKind: SupplementariesKind.productDescription,
                                withReuseIdentifier: SupplementariesKind.productDescription)
        return collectionView
    }()
    
    private let dismissButton: UIButton = {
        let button = UIButton(frame: .zero)
        let image = Asset.navigationBackIcon.image.withTintColor(ColorName.white.color, renderingMode: .alwaysOriginal)
        button.backgroundColor = ColorName.black.color.withAlphaComponent(0.5)
        button.setImageForAllStates(image)
        button.layerCornerRadius = 16
        return button
    }()
    
    private let cartButton: UIButton = {
        let button = UIButton(frame: .zero)
        let image = Asset.navigationBarCart.image.withTintColor(ColorName.white.color, renderingMode: .alwaysOriginal)
        button.backgroundColor = ColorName.black.color.withAlphaComponent(0.5)
        button.setImageForAllStates(image)
        button.layerCornerRadius = 16
        return button
    }()
    
    let productSizesHeaderCustomView: UIView = {
        let imageView = UIImageView(image: Asset.meterIcon.image)
        imageView.contentMode = .scaleAspectFit
        let label = UILabel(text: L10n.sizeGuide)
        label.font = FontFamily.Poppins.regular.font(size: 12)
        label.textColor = ColorName.gray.color
        let arrangedViews = [imageView, label]
        let stackView = UIStackView(arrangedSubviews: arrangedViews, axis: .horizontal, spacing: 8,  distribution: .fillProportionally)
        return stackView
    }()
    
    let productReviewsHeaderCustomView: UIView = {
        let imageView = UIImageView(image: Asset.featherArrow.image)
        imageView.contentMode = .scaleAspectFit
        let label = UILabel(text: L10n.allReviews)
        label.font = FontFamily.Poppins.regular.font(size: 12)
        label.textColor = ColorName.gray.color
        let arrangedViews = [label, imageView]
        let stackView = UIStackView(arrangedSubviews: arrangedViews, axis: .horizontal, spacing: 8,  distribution: .fillProportionally)
        return stackView
    }()
    
    init(product: Product) {
        super.init(frame: .zero)
        backgroundColor = ColorName.white.color
        setupViewsLayoutConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    //MARK: - Subviews layout
    private func setupViewsLayoutConstrains() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let buttonInsetValue = UIEdgeInsets(top: 50, left: 16, bottom: 0, right: 16)
        let buttonMeasure: CGFloat = 44
        addSubview(dismissButton)
        dismissButton.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(buttonInsetValue)
            make.height.width.equalTo(buttonMeasure)
        }
        
        addSubview(cartButton)
        cartButton.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(buttonInsetValue)
            make.height.width.equalTo(buttonMeasure)
        }
    }
    
    //MARK: - Collection view flow layout creation ...
    typealias Layout = UICollectionViewCompositionalLayout
    typealias LayoutConfiguration = UICollectionViewCompositionalLayoutConfiguration
    typealias LayoutSectionProvider = (Int, NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection
    private func createCollectionViewLayout() -> Layout {
        let layoutConfiguration = LayoutConfiguration()
        let sectionProvider: LayoutSectionProvider = { sectionIndex, environment  in
            let section = ProductDetailsSection.SectionIdentifier.allCases[sectionIndex]
            switch section {
            case .productImages: return self.createProductImagesSlider()
            case .productSizes: return self.createProductSizesSectionLayout()
            case .productColors: return self.createProductColorsSectionLayout()
            case .productReviews: return self.createProductReviewsLayout(environment: environment)
            case .suggestedProducts: return self.createSuggestedProductsLayout(environment: environment)
            }
        }
        return Layout(sectionProvider: sectionProvider, configuration: layoutConfiguration)
    }
    
    private func createProductImagesSlider() -> NSCollectionLayoutSection {
        let itemWidth = NSCollectionLayoutDimension.fractionalWidth(1.0)
        let itemHeight = NSCollectionLayoutDimension.fractionalHeight(0.83)
        let section = layoutProvider.createHorizontalSectionLayout(withWidth: itemWidth,
                                                                   andHeight: itemHeight,
                                                                   sectionContentInsets: .zero)
        
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(150))
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize,
                                                                        elementKind: SupplementariesKind.productDetailsCompact,
                                                                        alignment: .bottom)
        section.boundarySupplementaryItems = [sectionFooter]
        return section
    }
    
    private func createProductSizesSectionLayout()  -> NSCollectionLayoutSection {
        let itemWidth = NSCollectionLayoutDimension.absolute(60)
        let itemHeight = NSCollectionLayoutDimension.estimated(30)
        let section = layoutProvider.createHorizontalSectionLayout(withWidth: itemWidth,
                                                                   andHeight: itemHeight)
                                                                   
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: SupplementariesKind.productDetailsHeader,
                                                                        alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        section.interGroupSpacing = 8
        return section
    }
    
    private func createProductColorsSectionLayout()  -> NSCollectionLayoutSection {
        let itemWidth = NSCollectionLayoutDimension.absolute(25)
        let itemHeight = NSCollectionLayoutDimension.estimated(25)
        let section = layoutProvider.createHorizontalSectionLayout(withWidth: itemWidth,
                                                                   andHeight: itemHeight)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: SupplementariesKind.productDetailsHeader,
                                                                        alignment: .top)
        
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: SupplementariesKind.productDescription,
                                                                        alignment: .bottom)
        
        section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
        section.interGroupSpacing = 8
        return section
    }
    
    private func createProductReviewsLayout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let itemWidth = NSCollectionLayoutDimension.fractionalWidth(1.0)
        let itemHeight = NSCollectionLayoutDimension.estimated(130)
        let section = layoutProvider.createHorizontalSectionLayout(withWidth: itemWidth,
                                                                   andHeight: itemHeight,
                                                                   withItemHeight: itemHeight,
                                                                   itemContentInsets: NSDirectionalEdgeInsets(top: 0, leading: insetValue, bottom: 0, trailing: insetValue),
                                                                   scrollBehavior: .groupPagingCentered)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: SupplementariesKind.productDetailsHeader,
                                                                        alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func createSuggestedProductsLayout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let totalWidth = environment.container.contentSize.width
        let innerSpacing: CGFloat = 14
        let verticalInset: CGFloat = 16
        let availableWidth: CGFloat = totalWidth - innerSpacing - (verticalInset * 2)
        let itemWidth = availableWidth / 2
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(itemWidth), heightDimension: .estimated(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: SupplementariesKind.productDetailsHeader,
                                                                        alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: verticalInset, bottom: 0, trailing: verticalInset)
        section.boundarySupplementaryItems = [sectionHeader]
        section.interGroupSpacing = innerSpacing
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}

