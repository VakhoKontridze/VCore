//
//  InfiniteScrollingUITableViewDelegate.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation

// MARK: - Infinite Scrolling UI Table View Delegate
/// Allows the adopting delegate to respond to messages from `InfiniteScrollingUITableView`.
@MainActor
public protocol InfiniteScrollingUITableViewDelegate: AnyObject {
    /// Indicates that pagination did occur.
    func tableViewDidScrollToBottom(sender infiniteScrollingTableView: InfiniteScrollingUITableView)
}

#endif
