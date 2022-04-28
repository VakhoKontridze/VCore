//
//  InfiniteScrollingTableViewActivityIndicatorModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Infinite Scrolling Table View Activity Indicator Model
struct InfiniteScrollingTableViewActivityIndicatorModel {
    // MARK: Layout
    struct Layout {
        // MARK: Properties
        static var height: CGFloat { 100 }
        
        // MARK: Initializers
        private init() {}
    }
}

#endif
