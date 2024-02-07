//
//  LineLimitExtension.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 09.01.24.
//

import SwiftUI

// MARK: - Line Limit Extension
extension View {
    /// Sets line limit based on `TextLineLimitType`.
    ///
    ///     var body: some View {
    ///         Text("Lorem ipsum")
    ///             .lineLimit(type: .closedRange(lineLimit: 4...5))
    ///     }
    ///
    @ViewBuilder 
    public func lineLimit(
        type textLineLimitType: TextLineLimitType
    ) -> some View {
        switch textLineLimitType.storage {
        case .none:
            self

        case .fixed(let lineLimit):
            self
                .lineLimit(lineLimit)

        case .spaceReserved(let lineLimit, let reservesSpace):
            if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
                self
                    .lineLimit(lineLimit, reservesSpace: reservesSpace)
            } else {
                fatalError()
            }

        case .partialRangeFrom(let lineLimit):
            if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
                self
                    .lineLimit(lineLimit)
            } else {
                fatalError()
            }

        case .partialRangeThrough(let lineLimit):
            if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
                self
                    .lineLimit(lineLimit)
            } else {
                fatalError()
            }

        case .closedRange(let lineLimit):
            if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
                self
                    .lineLimit(lineLimit)
            } else {
                fatalError()
            }
        }
    }
}
