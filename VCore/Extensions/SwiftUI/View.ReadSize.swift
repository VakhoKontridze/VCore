//
//  View.ReadSize.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/6/21.
//

import SwiftUI

// MARK: - Read View Size
extension View {
    /// Reads `View` size and calls an on-change block.
    public func readSize(
        onChange completion: @escaping (CGSize) -> Void
    ) -> some View {
        background(
            GeometryReader(content: { proxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: proxy.size)
            })
        )
            .onPreferenceChange(SizePreferenceKey.self, perform: completion)
    }
}

// MARK: - Size Preference Key
private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
