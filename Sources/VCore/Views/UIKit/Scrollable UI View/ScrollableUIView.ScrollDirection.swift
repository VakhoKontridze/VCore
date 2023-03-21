//
//  ScrollableUIView.ScrollDirection.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 2/25/22.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation

// MARK: - Scrollable UI View Scroll Direction
extension ScrollableUIView {
    /// Scroll Direction.
    public struct ScrollDirection: OptionSet {
        // MARK: Options
        /// Horizontal scroll direction.
        public static let horizontal: Self = .init(rawValue: 1 << 0)
        
        /// Vertical scroll direction.
        public static let vertical: Self = .init(rawValue: 1 << 1)
        
        // MARK: Options Initializers
        /// Horizontal and vertical scroll directions.
        public static var all: Self { [.horizontal, .vertical] }
        
        // MARK: Properties
        public let rawValue: Int
        
        // MARK: Initializers
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
}

#endif
