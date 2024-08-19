//
//  InfiniteScrollingCollectionView+PaginationState.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/21/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Infinite Scrolling UI Collection View + Pagination State
extension InfiniteScrollingUICollectionView {
    /// Enumeration that represents state.
    public typealias PaginationState = InfiniteScrollingPaginationState
}

#endif
