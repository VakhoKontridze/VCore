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
    nonisolated public struct ScrollDirection: Sendable {
        nonisolated private enum Options: Int {
            case horizontal
            case vertical
        }
    }
}

#endif
