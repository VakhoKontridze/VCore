//
//  InfiniteScrollingPaginationState.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import Foundation

// MARK: - Pagination State
/// Enum that describes state, such as `loading`, `canPaginate`, or `cannotPaginate`.
public enum InfiniteScrollingPaginationState {
    /// Indicates that `UIActivityIndicator` is visible and additional pagination cannot occur.
    case loading
    
    /// Indicates that pagination can occur.
    case canPaginate
    
    /// Indicates that pagination cannot occur.
    case cannotPaginate
}
