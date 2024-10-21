//
//  InfiniteScrollingPaginationState.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation

// MARK: - Infinite Scrolling Pagination State
/// Enumeration that represents state.
public enum InfiniteScrollingPaginationState: Int, Sendable, CaseIterable {
    /// Indicates that `UIActivityIndicator` is visible and additional pagination cannot occur.
    case loading
    
    /// Indicates that pagination can occur.
    case canPaginate
    
    /// Indicates that pagination cannot occur.
    case cannotPaginate
}

#endif
