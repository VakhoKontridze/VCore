//
//  DynamicTypeSizeTypeExtension.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 09.07.24.
//

import SwiftUI

// MARK: - Dynamic Type Size Type Extension
extension View {
    /// Sets `DynamicTypeSize` based on `DynamicTypeSizeType`.
    ///
    ///     var body: some View {
    ///         Text("Lorem ipsum")
    ///             .dynamicTypeSize(type: .closedRange(.small ... .large))
    ///     }
    ///
    @ViewBuilder
    public func dynamicTypeSize(
        type dynamicTypeSizeType: DynamicTypeSizeType
    ) -> some View {
        switch dynamicTypeSizeType.storage {
        case .fixed(let size):
            self
                .dynamicTypeSize(size)

        case .partialRangeUpTo(let range):
            self
                .dynamicTypeSize(range)

        case .partialRangeThrough(let range):
            self
                .dynamicTypeSize(range)

        case .partialRangeFrom(let range):
            self
                .dynamicTypeSize(range)

        case .range(let range):
            self
                .dynamicTypeSize(range)

        case .closedRange(let range):
            self
                .dynamicTypeSize(range)
        }
    }
}
