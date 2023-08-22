//
//  InfiniteScrollingTableViewPaginationState.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/21/21.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation

// MARK: - Infinite Scrolling UI Table View Pagination State
extension InfiniteScrollingUITableView {
    /// Enum Enumeration that represents state, such as `loading`, `canPaginate`, or `cannotPaginate`.
    public typealias PaginationState = InfiniteScrollingPaginationState
}

#endif
