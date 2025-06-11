//
//  RightAlignedUICollectionViewFlowLayout.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Right Aligned UI Collection View Flow Layout
/// Layout object that organizes items into a grid with a right alignment.
open class RightAlignedUICollectionViewFlowLayout: UICollectionViewFlowLayout {
    // MARK: Item Attributes
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard
            let layoutAttributes = super.layoutAttributesForElements(in: rect)?.map({ $0.copy() }) as? [UICollectionViewLayoutAttributes]
        else {
            return nil
        }
        
        for layoutAttribute in layoutAttributes {
            guard layoutAttribute.representedElementCategory == .cell else { continue }
            
            layoutAttributesForItem(at: layoutAttribute.indexPath).map {
                layoutAttribute.frame = $0.frame
            }
        }
        
        return layoutAttributes
    }
    
    // MARK: Item Attributes
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard
            let collectionView,
            let layoutAttributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes
        else {
            return nil
        }
        
        let indexPath: IndexPath = layoutAttributes.indexPath
        let nextIndexPath: IndexPath = .init(item: indexPath.item + 1, section: indexPath.section)
        
        let isLastElementInRow: Bool = isLastElementInRow(
            collectionView: collectionView,
            indexPath: indexPath,
            layoutAttributes: layoutAttributes,
            nextIndexPath: nextIndexPath
        )
        
        if isLastElementInRow {
            layoutAttributes.frame.origin.x =
                collectionView.frame.size.width -
                sectionInset.right -
                layoutAttributes.frame.size.width
            
        } else if let nextItemLayoutAttributes: UICollectionViewLayoutAttributes = layoutAttributesForItem(at: nextIndexPath) {
            layoutAttributes.frame.origin.x =
                nextItemLayoutAttributes.frame.minX -
                minimumInteritemSpacing -
                layoutAttributes.frame.size.width
        }
        
        return layoutAttributes
    }
    
    // MARK: Helpers
    private func isLastElementInRow(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        layoutAttributes: UICollectionViewLayoutAttributes,
        nextIndexPath: IndexPath
    ) -> Bool {
        let numberOfItemsInSection: Int = collectionView.numberOfItems(inSection: indexPath.section)
        
        if indexPath.item >= numberOfItemsInSection - 1 {
            return true
        } else if let nextItemLayoutAttributes: UICollectionViewLayoutAttributes = super.layoutAttributesForItem(at: nextIndexPath) {
            return !areOnTheSameRow(collectionView: collectionView, lhs: layoutAttributes, rhs: nextItemLayoutAttributes)
        } else {
            return true
        }
    }
    
    private func areOnTheSameRow(
        collectionView: UICollectionView,
        lhs: UICollectionViewLayoutAttributes,
        rhs: UICollectionViewLayoutAttributes
    ) -> Bool {
        let rowRect: CGRect = .init(
            origin: CGPoint(
                x: sectionInset.left,
                y: lhs.frame.origin.y
            ),
            size: CGSize(
                width: collectionView.frame.size.width - sectionInset.left - sectionInset.right,
                height: lhs.frame.size.height
            )
        )
        
        return rowRect.intersects(rhs.frame)
    }
}

// MARK: - Preview
#if DEBUG

#Preview {
    Preview_AlignedUICollectionViewFlowLayoutViewController(
        layout: RightAlignedUICollectionViewFlowLayout()
    )
}

#endif

#endif
