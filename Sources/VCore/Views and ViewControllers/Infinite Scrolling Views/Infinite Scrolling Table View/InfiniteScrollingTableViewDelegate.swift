//
//  InfiniteScrollingTableViewDelegate.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation

// MARK: - Infinite Scrolling Table View Delegate
/// Allows the adopting delegate to respond to messages from `InfiniteScrollingTableView`.
public protocol InfiniteScrollingTableViewDelegate: AnyObject {
    func tableViewDidScrollToBottom(sender infiniteScrollingTableView: InfiniteScrollingTableView)
}

#endif
