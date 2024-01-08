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
    @OptionSetRepresentation<Int>(accessLevelModifier: "public")
    public struct ScrollDirection {
        // MARK: Options
        private enum Options: Int {
            case horizontal
            case vertical
        }

        // MARK: Options Initializers
        /// Horizontal and vertical scroll directions.
        public static var allRegions: Self { [.horizontal, .vertical] }
    }
}

#endif
