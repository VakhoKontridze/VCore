//
//  View+GetBounds.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 23.09.23.
//

import SwiftUI

// MARK: - View + Get Bounds
extension View {
    /// Retrieves bounds from `View`.
    ///
    ///     @State private var bounds: CGRect?
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .getBounds(of: .global, { [$bounds] $bounds.wrappedValue = $0 })
    ///     }
    ///
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
    public func getBounds(
        of coordinateSpace: NamedCoordinateSpace,
        _ action: @escaping @Sendable (CGRect?) -> Void
    ) -> some View {
        self
            .background(content: {
                GeometryReader(content: { proxy in
                    Color.clear
                        .preference(
                            key: BoundsPreferenceKey.self,
                            value: proxy.bounds(of: coordinateSpace)
                        )
                        .onPreferenceChange(BoundsPreferenceKey.self, perform: action)
                })
                .allowsHitTesting(false) // Avoids blocking gestures
            })
    }
    
    /// Retrieves bounds from `View` and assigns it on a `Binding`.
    ///
    ///     @State private var bounds: CGRect?
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .getBounds(of: .global, assignOn: $bounds)
    ///     }
    ///
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
    public func getBounds(
        of coordinateSpace: NamedCoordinateSpace,
        assignOn binding: Binding<CGRect?>
    ) -> some View {
        self
            .getBounds(
                of: coordinateSpace,
                { binding.wrappedValue = $0 }
            )
    }
}

// MARK: - Bounds Preference Key
private struct BoundsPreferenceKey: PreferenceKey {
    static let defaultValue: CGRect? = nil

    static func reduce(value: inout CGRect?, nextValue: () -> CGRect?) {}
}
