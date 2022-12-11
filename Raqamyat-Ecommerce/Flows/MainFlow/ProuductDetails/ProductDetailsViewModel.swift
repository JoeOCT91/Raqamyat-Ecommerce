//
//  ProductDetailsViewModel.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 08/12/2022.
//

import UIKit.NSDiffableDataSourceSectionSnapshot
import Foundation
import Combine

protocol ProductDetailsViewModelProtocol: AnyObject {
    typealias DataSourceSnapShot = NSDiffableDataSourceSnapshot<ProductDetailsSection, ProductDetailsSection.SectionItem>
    var dataSourceSnapShotPublisher: Published<DataSourceSnapShot>.Publisher { get }
    
    var product: Product? { get }
    var productPublisher: Published<Product?>.Publisher { get }

}

final class ProductDetailsViewModel: ViewModel, ProductDetailsViewModelProtocol {
    
    typealias DataSourceSnapShot = NSDiffableDataSourceSnapshot<ProductDetailsSection, ProductDetailsSection.SectionItem>
    @Published private var snapShot = DataSourceSnapShot()
    var dataSourceSnapShotPublisher: Published<DataSourceSnapShot>.Publisher { $snapShot }
    
    @Published var product: Product?
    var productPublisher: Published<Product?>.Publisher { $product }
    
    private var repository: ProductDetailsRepositoryProtocol
    
    init(repository: ProductDetailsRepositoryProtocol, product: Product) {
        self.repository = repository
        self.product = product
        super.init(repository: repository)
        createDataSourceSnapShot(using: product)
        bindToRepositoryDataDownStream()
        repository.fetchProductDetails(forProduct: product.id)
    }
    
    private func bindToRepositoryDataDownStream(){
        repository.productPublisher
            .sink { [unowned self]response in
                self.product = response.data
            }.store(in: &subscriptions)
    }

    private func createDataSourceSnapShot(using product: Product) {
        var snapshot = DataSourceSnapShot()
        
        let productImages = product.images.map { imageUrl in
            return ProductDetailsSection.SectionItem.imageURl(imageUrl)
        }
        
        let productSizes = product.sizes.map { size in
            return  ProductDetailsSection.SectionItem.productSize(size)
        }
        
        let productColors = product.colors.map { color in
            return ProductDetailsSection.SectionItem.productColor(color)
        }
        
        let productReviews = product.reviews.map { review in
            return ProductDetailsSection.SectionItem.productReview(review)
        }
        
        let suggestedProducts = product.suggestedProducts.map { product in
            return ProductDetailsSection.SectionItem.suggestedProduct(product)
        }
         
        let sectionsItemsList = [productImages, productSizes, productColors, productReviews, suggestedProducts]
        for sectionItems in sectionsItemsList {
            let section = ProductDetailsSection(title: "", items: sectionItems)
            snapshot.appendSections([section])
            snapshot.appendItems(sectionItems)
        }
        
        self.snapShot = snapshot
    }
}

struct ProductDetailsSection: Hashable {
    
    let title: String?
    var items: [SectionItem]
    
    enum SectionIdentifier: String, Hashable, CaseIterable  {
        case productImages
        case productSizes
        case productColors
        case productReviews
        case suggestedProducts
    }
    
    enum SectionItem: Hashable {
        case imageURl(_ imageUrl: String)
        case productSize(_ size: ProductSize)
        case productColor(_ color: ProductColor)
        case productReview(_ review: ProductReview)
        case suggestedProduct(_ product: SuggestedProduct)
    }
}
