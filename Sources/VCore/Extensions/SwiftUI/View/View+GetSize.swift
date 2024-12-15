//
//  View+GetSize.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/28/21.
//

import SwiftUI

// MARK: - View + Get Size
extension View {
    /// Retrieves size from `View`.
    ///
    ///     @State private var size: CGSize = .zero
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .getSize({ [$size] in $size.wrappedValue = $0 })
    ///     }
    ///
    public func getSize(
        _ action: @escaping @Sendable (CGSize) -> Void
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
    
    /// Retrieves size from `View` and assigns on a `Binding`.
    ///
    ///     @State private var size: CGSize = .zero
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .getSize(assignOn: $size)
    ///     }
    ///
    public func getSize(
        assignOn binding: Binding<CGSize>
    ) -> some View {
        self
            .getSize({ binding.wrappedValue = $0 })
    }
    
    /// Retrieves width from `View` and assigns on a `Binding`.
    ///
    ///     @State private var width: CGFloat = 0
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .getWidth(assignOn: $width)
    ///     }
    ///
    public func getWidth(
        assignOn binding: Binding<CGFloat>
    ) -> some View {
        self
            .getSize({ binding.wrappedValue = $0.width })
    }
    
    /// Retrieves height from `View` and assigns on a `Binding`.
    ///
    ///     @State private var height: CGFloat = 0
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .getHeight(assignOn: $height)
    ///     }
    ///
    public func getHeight(
        assignOn binding: Binding<CGFloat>
    ) -> some View {
        self
            .getSize({ binding.wrappedValue = $0.height })
    }
}

// MARK: - Size Preference Key
private struct SizePreferenceKey: PreferenceKey {
    static let defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
