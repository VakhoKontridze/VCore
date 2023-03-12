//
//  View.OnSizeChange.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/28/21.
//

import SwiftUI

// MARK: - View On Size Change
extension View {
    /// Reads `View` size and calls an on-change block.
    ///
    ///     @State private var size: CGSize = .zero
    ///
    ///     var body: some View {
    ///         VStack(content: {
    ///             Color.accentColor
    ///                 .onSizeChange(perform: { size = $0 })
    ///         })
    ///     }
    ///
    public func onSizeChange(
        perform action: @escaping (CGSize) -> Void
    ) -> some View {
        background(
            GeometryReader(content: { proxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: proxy.frame(in: .local).size)
            })
        )
            .onPreferenceChange(SizePreferenceKey.self, perform: action)
    }
}

// MARK: - Size Preference Key
private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
