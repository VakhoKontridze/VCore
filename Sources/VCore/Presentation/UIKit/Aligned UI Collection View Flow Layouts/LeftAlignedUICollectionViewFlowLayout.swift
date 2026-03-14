//
//  LeftAlignedUICollectionViewFlowLayout.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

/// Layout object that organizes items into a grid with a left alignment.
open class LeftAlignedUICollectionViewFlowLayout: UICollectionViewFlowLayout {
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard
            let layoutAttributes = super.layoutAttributesForElements(in: rect)?
                .map({ $0.copy() })
                as? [UICollectionViewLayoutAttributes]
        else {
            return nil
        }
        
        var leftMargin: CGFloat = sectionInset.left
        var maxY: CGFloat = -1
        
        for layoutAttribute in layoutAttributes {
            guard layoutAttribute.representedElementCategory == .cell else { continue }
            
            if layoutAttribute.frame.origin.y >= maxY { leftMargin = sectionInset.left }
            layoutAttribute.frame.origin.x = leftMargin
            
            leftMargin += layoutAttribute.frame.size.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        
        return layoutAttributes
    }
}

#if DEBUG

#Preview {
    AlignedUICollectionViewFlowLayoutViewController(
        layout: LeftAlignedUICollectionViewFlowLayout()
    )
}

#endif

#endif
