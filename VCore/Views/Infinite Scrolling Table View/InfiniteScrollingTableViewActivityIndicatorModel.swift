//
//  InfiniteScrollingTableViewActivityIndicatorModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import UIKit

// MARK: - Infinite Scrolling Table View Activity Indicator Model
struct InfiniteScrollingTableViewActivityIndicatorModel {
    // MARK: Properties
    let layout: Layout = .init()
}

// MARK: - Layout
extension InfiniteScrollingTableViewActivityIndicatorModel {
    struct Layout {
        // MARK: Properties
        let height: CGFloat = 100
        
        // MARK: Initializers
        fileprivate init() {}
    }
}
