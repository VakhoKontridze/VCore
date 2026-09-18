//
//  InfiniteScrollingUICollectionViewAppearance.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/21/21.
//

#if canImport(UIKit) && !os(watchOS)

public import Foundation

/// Model that describes appearance
public struct InfiniteScrollingUICollectionViewAppearance {
    // MARK: Properties
    /// Offset that needs to be dragged vertically up for pagination to occur.
    public var paginationOffset: CGFloat = 20
    
    /// Activity indicator container height.
    public var activityIndicatorContainerHeight: CGFloat = 100

    // MARK: Initializers
    /// Initializes appearance with default values.
    public init() {}
    
    /// Initializes appearance from the given base instance and applies the given configuration.
    public init(
        _ base: Self = .init(),
        _ configure: (inout Self) -> Void
    ) {
        self = base
        configure(&self)
    }
}

#endif
