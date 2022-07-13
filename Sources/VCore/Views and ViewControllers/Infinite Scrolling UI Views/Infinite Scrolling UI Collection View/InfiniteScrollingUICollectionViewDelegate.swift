//
//  InfiniteScrollingUICollectionViewPaginationState.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/21/21.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation

// MARK: - Infinite Scrolling UI Collection View Delegate
/// Allows the adopting delegate to respond to messages from `InfiniteScrollingUICollectionView`.
public protocol InfiniteScrollingUICollectionViewDelegate: AnyObject {
    func collectionViewDidScrollToBottom(sender infiniteScrollingCollectionView: InfiniteScrollingUICollectionView)
}

#endif
