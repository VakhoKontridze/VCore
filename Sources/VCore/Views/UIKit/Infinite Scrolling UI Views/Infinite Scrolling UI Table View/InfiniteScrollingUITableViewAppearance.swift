//
//  InfiniteScrollingUITableViewAppearance.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

/// Model that describes appearance
public struct InfiniteScrollingUITableViewAppearance: Equatable {
    // MARK: Properties
    /// Offset that needs to be dragged vertically up for pagination to occur.
    public var paginationOffset: CGFloat = 20
    
    /// Activity indicator container height.
    public var activityIndicatorContainerHeight: CGFloat = 100

    // MARK: Initializers
    /// Initializes appearance with default values.
    public init() {}
}

#endif
