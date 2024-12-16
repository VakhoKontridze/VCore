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
                GeometryReader(content: { geometryProxy in
                    Color.clear
                        .preference(
                            key: SizePreferenceKey.self,
                            value: geometryProxy.size
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
    ///             .getSize(assignTo: $size)
    ///     }
    ///
    public func getSize(
        assignTo binding: Binding<CGSize>
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
    ///             .getWidth(assignTo: $width)
    ///     }
    ///
    public func getWidth(
        assignTo binding: Binding<CGFloat>
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
    ///             .getHeight(assignTo: $height)
    ///     }
    ///
    public func getHeight(
        assignTo binding: Binding<CGFloat>
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
