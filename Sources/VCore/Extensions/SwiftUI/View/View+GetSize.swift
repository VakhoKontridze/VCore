//
//  View+GetSize.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/28/21.
//

import SwiftUI

// MARK: - View + Get Size
extension View {
    /// Retrieves `CGSize` from `View`.
    ///
    ///     @State private var size: CGSize = .zero
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .getSize({ size = $0 })
    ///     }
    ///
    public func getSize(
        _ action: @escaping (CGSize) -> Void
    ) -> some View {
        self
            .background(content: {
                GeometryReader(content: { proxy in
                    Color.clear
                        .preference(
                            key: SizePreferenceKey.self,
                            value: proxy.size
                        )
                        .onPreferenceChange(SizePreferenceKey.self, perform: action)
                })
                .allowsHitTesting(false) // Avoids blocking gestures
            })
    }
}

// MARK: - Size Preference Key
private struct SizePreferenceKey: PreferenceKey {
    static let defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
