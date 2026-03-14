//
//  ScrollableUIView+ScrollDirection.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 2/25/22.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation

nonisolated extension ScrollableUIView {
    /// Scroll Direction.
    @OptionSetRepresentation<Int>
    public nonisolated struct ScrollDirection: Sendable {
        private nonisolated enum Options: Int {
            case horizontal
            case vertical
        }
    }
}

#endif
