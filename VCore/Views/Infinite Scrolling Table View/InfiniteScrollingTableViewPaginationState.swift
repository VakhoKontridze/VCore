//
//  InfiniteScrollingTableViewPaginationState.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import Foundation

// MARK: - Pagination State
extension InfiniteScrollingTableView {
    /// Enum that describes state, such as `isLoading`, `canPaginate`, or `shouldNotPaginate`
    public enum PaginationState {
        /// Indicates that `UIActivityIndicator` is visible and additional pagination cannot occur
        case isLoading
        
        /// Indicates that pagination can occur
        case canPaginate
        
        /// Indicates that pagination shouldn't occur
        case shouldNotPaginate
    }
}
