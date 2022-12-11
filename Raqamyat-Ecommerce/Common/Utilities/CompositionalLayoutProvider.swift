//
//  CompositionalLayoutProvider.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 09/12/2022.
//

import UIKit

struct CompositionalLayoutProvider {
    
    typealias Layout = UICollectionViewCompositionalLayout
    private static var defaultSectionInset = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
    
    func createHorizontalSectionLayout(withWidth groupWidth: NSCollectionLayoutDimension,
                                       andHeight groupHeight: NSCollectionLayoutDimension,
                                       withItemWidth itemWidth: NSCollectionLayoutDimension = .fractionalWidth(1.0),
                                       withItemHeight itemHeight: NSCollectionLayoutDimension = .fractionalHeight(1.0),
                                       sectionContentInsets: NSDirectionalEdgeInsets = defaultSectionInset,
                                       itemContentInsets: NSDirectionalEdgeInsets = .zero,

                                       scrollBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior = .groupPaging ) -> NSCollectionLayoutSection {
            
        let itemSize = NSCollectionLayoutSize(widthDimension: itemWidth, heightDimension: itemHeight)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = itemContentInsets
        
        let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth, heightDimension: groupHeight)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
            
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = sectionContentInsets
        section.orthogonalScrollingBehavior = scrollBehavior
        return section
    }
    
}
