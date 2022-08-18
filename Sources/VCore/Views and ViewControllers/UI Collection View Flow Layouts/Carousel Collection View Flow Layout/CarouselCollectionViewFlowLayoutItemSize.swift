//
//  CarouselCollectionViewFlowLayoutItemSize.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 18.08.22.
//

#if canImport(UIKit)

import UIKit

// MARK: - Carousel Collection View Flow Layout Item Size
/// Size of item in `CarouselCollectionViewFlowLayout`.
///
/// Alternate API to `itemSize`.
///
/// If `height` is `nil`, it will be calculated from `UICollectionView`.
public struct CarouselCollectionViewFlowLayoutItemSize {
    // MARK: Properties
    /// Horizontal inset from the bounds of `UICollectionView`.
    public let inset: CGFloat
    
    /// Height.
    public let height: CGFloat?
    
    // MARK: Initializers
    /// Initializes `CarouselCollectionViewFlowLayoutItemSize` with inset and height.
    public init(
        inset: CGFloat,
        height: CGFloat?
    ) {
        self.inset = inset
        self.height = height
    }
    
    // MARK: Size in Container
    func size(in container: CGSize) -> CGSize {
        .init(
            width: container.width - 2*inset,
            height: height ?? container.height
        )
    }
}

#endif
