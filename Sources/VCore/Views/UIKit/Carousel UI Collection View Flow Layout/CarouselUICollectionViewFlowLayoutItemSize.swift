//
//  CarouselUICollectionViewFlowLayoutItemSize.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 18.08.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Carousel UI Collection View Flow Layout Item Size
/// Size of item in `CarouselUICollectionViewFlowLayout`.
///
/// Alternate API to `itemSize`.
///
/// If `height` is `nil`, it will be calculated from `UICollectionView`.
public struct CarouselUICollectionViewFlowLayoutItemSize: Sendable {
    // MARK: Properties
    /// Horizontal inset from the bounds of `UICollectionView`.
    public var inset: CGFloat
    
    /// Height.
    public var height: CGFloat?
    
    // MARK: Initializers
    /// Initializes `CarouselUICollectionViewFlowLayoutItemSize` with inset and height.
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
