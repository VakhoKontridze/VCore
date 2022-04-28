//
//  ScrollableView.ScrollDirection.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 2/25/22.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation

// MARK: - Scrollable View Scroll Direction
extension ScrollableView {
    /// Scroll Direction.
    public struct ScrollDirection: OptionSet {
        // MARK: Properties
        public let rawValue: Int

        /// Horizontal scroll direction.
        public static var horizontal: ScrollDirection { .init(rawValue: 1 << 0) }
        
        /// Vertical scroll direction.
        public static var vertical: ScrollDirection { .init(rawValue: 1 << 1) }
        
        /// Horizontal and vertical scroll directions.
        public static var all: ScrollDirection { [.horizontal, .vertical] }
        
        // MARK: Initializers
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
}

#endif
