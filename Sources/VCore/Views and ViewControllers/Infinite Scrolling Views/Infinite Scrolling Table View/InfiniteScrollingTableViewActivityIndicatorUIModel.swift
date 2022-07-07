//
//  InfiniteScrollingTableViewActivityIndicatorUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Infinite Scrolling Table View Activity Indicator UI Model
struct InfiniteScrollingTableViewActivityIndicatorUIModel {
    // MARK: Layout
    struct Layout {
        // MARK: Properties
        static var height: CGFloat { 100 }
        
        // MARK: Initializers
        private init() {}
    }
}

#endif
