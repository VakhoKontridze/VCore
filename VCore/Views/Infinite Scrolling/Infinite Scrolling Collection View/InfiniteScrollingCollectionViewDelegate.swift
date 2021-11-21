//
//  InfiniteScrollingCollectionViewPaginationState.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/21/21.
//

import Foundation

// MARK: - Infinite Scrolling Collection View Delegate
/// Allows the adopting delegate to respond to messages from `InfiniteScrollingCollectionView`.
public protocol InfiniteScrollingCollectionViewDelegate: AnyObject {
    func collectionViewDidScrollToBottom(sender infiniteScrollingCollectionView: InfiniteScrollingCollectionView)
}
