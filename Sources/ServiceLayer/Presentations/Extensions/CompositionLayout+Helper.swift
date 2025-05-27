//
//  CompositionLayout+Helper.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 10/16/23.
//

import UIKit

extension NSCollectionLayoutGroup {
    
    public static func horizontal(
        size: NSCollectionLayoutSize,
        item: NSCollectionLayoutItem,
        count: Int
    ) -> NSCollectionLayoutGroup {
        if #available(iOS 16.0, *) {
            return horizontal(
                layoutSize: size,
                repeatingSubitem: item,
                count: count
            )
        } else {
            return horizontal(
                layoutSize: size,
                subitem: item,
                count: count
            )
        }
    }
}

extension NSCollectionLayoutSize {
    
    public convenience init(w width: NSCollectionLayoutDimension, h height: NSCollectionLayoutDimension) {
        self.init(widthDimension: width, heightDimension: height)
    }
}

extension NSCollectionLayoutBoundarySupplementaryItem {
    
    public static func header(layoutSize: NSCollectionLayoutSize) -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: layoutSize,
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .topLeading
        )
    }
    
    public static func footer(layoutSize: NSCollectionLayoutSize) -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: layoutSize,
              elementKind: UICollectionView.elementKindSectionFooter,
              alignment: .bottomLeading
        )
    }
}
