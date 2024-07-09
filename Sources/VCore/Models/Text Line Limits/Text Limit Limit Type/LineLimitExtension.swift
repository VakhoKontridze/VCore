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
            self
                .lineLimit(lineLimit, reservesSpace: reservesSpace)

        case .partialRangeThrough(let lineLimit):
            self
                .lineLimit(lineLimit)

        case .partialRangeFrom(let lineLimit):
            self
                .lineLimit(lineLimit)

        case .closedRange(let lineLimit):
            self
                .lineLimit(lineLimit)
        }
    }
}
