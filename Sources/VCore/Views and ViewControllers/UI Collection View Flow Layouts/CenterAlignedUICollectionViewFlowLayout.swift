//
//  CenterAlignedUICollectionViewFlowLayout.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Center Aligned UI Collection View Flow Layout
/// Layout object that organizes items into a grid with a center alignment.
///
/// Requires `UICollectionViewDelegateFlowLayout` to be set via `delegate`.
open class CenterAlignedUICollectionViewFlowLayout: UICollectionViewFlowLayout {
    // MARK: Properties
    private var itemLayoutAttributes: [IndexPath: UICollectionViewLayoutAttributes] = [:]

    // MARK: Lifecycle
    public override func prepare() {
        super.prepare()
        
        itemLayoutAttributes = [:]
    }

    // MARK: Item Attributes
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView else { return nil }
        
        var updatedItemLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        for i in 0..<collectionView.numberOfSections {
            for j in 0..<collectionView.numberOfItems(inSection: i) {
                let indexPath: IndexPath = .init(row: j, section: i)

                layoutAttributesForItem(at: indexPath).map {
                    guard $0.frame.intersects(rect) else { return }
                    updatedItemLayoutAttributes.append($0)
                }
                
                layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: indexPath).map {
                    updatedItemLayoutAttributes.append($0)
                }
                
                layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, at: indexPath).map {
                    updatedItemLayoutAttributes.append($0)
                }
            }
        }
        
        return updatedItemLayoutAttributes
    }

    // MARK: Item Attribute
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard
            let collectionView = collectionView,
            let flowDelegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout
        else {
            return super.layoutAttributesForItem(at: indexPath)
        }
        
        if let attributes: UICollectionViewLayoutAttributes = itemLayoutAttributes[indexPath] { return attributes }
        
        let availableWidthForCells: CGFloat = // Available width left where cells can be centered
            collectionView.bounds.width -
            collectionView.contentInset.left -
            collectionView.contentInset.right

        let sameRowItemAttributes: [UICollectionViewLayoutAttributes] = findSameRowItemAttributes(
            collectionView: collectionView,
            indexPath: indexPath,
            availableWidthForCells: availableWidthForCells
        )

        let interitemSpacing: CGFloat = calculateRowItemInterimSpacing( // Minimum spacing between items in a row
            collectionView: collectionView,
            flowDelegate: flowDelegate,
            indexPath: indexPath,
            sameRowItemAttributes: sameRowItemAttributes
        )

        let centerAlignmentXOffset: CGFloat = calculateXOffset(
            availableWidthForCells: availableWidthForCells,
            interitemSpacing: interitemSpacing,
            sameRowItemAttributes: sameRowItemAttributes
        )
        
        // Adjusts x positions
        do {
            var previousFrame: CGRect = .zero
            
            for itemAttributes in sameRowItemAttributes {
                let centeredItemFrame: CGRect = {
                    var centeredItemFrame: CGRect = itemAttributes.frame
                    
                    centeredItemFrame.origin.x = {
                        switch previousFrame {
                        case .zero: return centerAlignmentXOffset
                        default: return previousFrame.maxX + interitemSpacing
                        }
                    }()
                    
                    return centeredItemFrame
                }()

                itemAttributes.frame = centeredItemFrame
                
                previousFrame = centeredItemFrame
                itemLayoutAttributes[itemAttributes.indexPath] = itemAttributes
            }
        }

        return itemLayoutAttributes[indexPath]
    }
    
    // MARK: Helpers
    private func findSameRowItemAttributes(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        availableWidthForCells: CGFloat
    ) -> [UICollectionViewLayoutAttributes] {
        var sameRowItemAttributes: [UICollectionViewLayoutAttributes] = .init()
        
        let defaultRowFrame: CGRect = { // Needed for finding items in row, by checking intersect
            var defaultRowFrame: CGRect = super.layoutAttributesForItem(at: indexPath)?.frame ?? .zero
            defaultRowFrame.origin.x = 0
            defaultRowFrame.size.width = availableWidthForCells
            return defaultRowFrame
        }()

        let indexOfFirstItemInRow: Int = { // Stop at 0, or when it reach previous row
            var index: Int = indexPath.row
            
            while true {
                let previousIndex = index - 1
                guard previousIndex >= 0 else { break }

                let previousIndexPath: IndexPath = .init(row: previousIndex, section: indexPath.section)
                let previousFrame: CGRect = super.layoutAttributesForItem(at: previousIndexPath)?.frame ?? .zero
                
                guard previousFrame.intersects(defaultRowFrame) else { break }
                
                index = previousIndex
            }
            
            return index
        }()
        
        do {
            var currentIndex = indexOfFirstItemInRow
            while true {
                guard currentIndex <= collectionView.numberOfItems(inSection: indexPath.section) - 1 else { break }

                let currentIndexPath = IndexPath(row: currentIndex, section: indexPath.section)
                guard
                    let currentAttributes: UICollectionViewLayoutAttributes = super.layoutAttributesForItem(at: currentIndexPath),
                    currentAttributes.frame.intersects(defaultRowFrame),
                    let copyOfCurrentAttributes: UICollectionViewLayoutAttributes = currentAttributes.copy() as? UICollectionViewLayoutAttributes
                else {
                    break
                }
                
                sameRowItemAttributes.append(copyOfCurrentAttributes)
                currentIndex += 1
            }
        }
        
        return sameRowItemAttributes
    }
    
    private func calculateRowItemInterimSpacing(
        collectionView: UICollectionView,
        flowDelegate: UICollectionViewDelegateFlowLayout,
        indexPath: IndexPath,
        sameRowItemAttributes: [UICollectionViewLayoutAttributes]
    ) -> CGFloat {
        guard
            delegateSupportsInteritemSpacing(
                collectionView: collectionView,
                flowDelegate: flowDelegate
            ),
            sameRowItemAttributes.count > 0
        else {
            return minimumInteritemSpacing
        }

        return flowDelegate.collectionView?(
            collectionView,
            layout: self,
            minimumInteritemSpacingForSectionAt: indexPath.section
        ) ?? 0
    }
    
    private func calculateXOffset(
        availableWidthForCells: CGFloat,
        interitemSpacing: CGFloat,
        sameRowItemAttributes: [UICollectionViewLayoutAttributes]
    ) -> CGFloat {
        let sumOfInteritemSpacings: CGFloat = interitemSpacing * .init(sameRowItemAttributes.count - 1)
        let sumOfItemWidths: CGFloat = sameRowItemAttributes.reduce(0, { $0 + $1.frame.size.width })
        let alignmentWidth: CGFloat = sumOfItemWidths + sumOfInteritemSpacings
        let centerAlignmentXOffset: CGFloat = (availableWidthForCells - alignmentWidth) / 2
        
        return centerAlignmentXOffset
    }
    
    private func delegateSupportsInteritemSpacing(
        collectionView: UICollectionView,
        flowDelegate: UICollectionViewDelegateFlowLayout
    ) -> Bool {
        let selector: Selector = #selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:minimumInteritemSpacingForSectionAt:))
        return flowDelegate.responds(to: selector)
    }
}

#endif
