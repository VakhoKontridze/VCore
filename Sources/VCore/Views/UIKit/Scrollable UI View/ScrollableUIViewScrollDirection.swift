//
//  ScrollableUIViewScrollDirection.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 2/25/22.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation

// MARK: - Scrollable UI View Scroll Direction
extension ScrollableUIView {
    /// Scroll Direction.
    @OptionSetRepresentation<Int>
    public struct ScrollDirection {
        private enum Options: Int {
            case horizontal
            case vertical
        }
    }
}

#endif
