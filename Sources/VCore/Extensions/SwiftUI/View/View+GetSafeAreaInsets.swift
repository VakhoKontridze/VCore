//
//  View+GetSafeAreaInsets.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.08.23.
//

import SwiftUI

// MARK: - View + Get Safe Area Insets
extension View {
    /// Retrieves safe are insets from `View`.
    ///
    ///     @State private var safeAreaInsets: EdgeInsets = .init()
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .getSafeAreaInsets({ [$safeAreaInsets] in $safeAreaInsets.wrappedValue = $0 })
    ///     }
    ///
    public func getSafeAreaInsets(
        ignoredKeyboardSafeAreaEdges: Edge.Set = [],
        _ action: @escaping @Sendable (EdgeInsets) -> Void
    ) -> some View {
        self
            .background(content: {
                GeometryReader(content: { proxy in
                    Color.clear
                        .preference(
                            key: SafeAreaInsetsPreferenceKey.self,
                            value: proxy.safeAreaInsets
                        )
                        .onPreferenceChange(SafeAreaInsetsPreferenceKey.self, perform: action)
                })
                .ignoresSafeArea(.keyboard, edges: ignoredKeyboardSafeAreaEdges)
                .allowsHitTesting(false) // Avoids blocking gestures
            })
    }
    
    /// Retrieves safe are insets from `View` and assigns on a `Binding`.
    ///
    ///     @State private var safeAreaInsets: EdgeInsets = .init()
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .getSafeAreaInsets(assignTo: $safeAreaInsets)
    ///     }
    ///
    public func getSafeAreaInsets(
        ignoredKeyboardSafeAreaEdges: Edge.Set = [],
        assignTo binding: Binding<EdgeInsets>
    ) -> some View {
        self
            .getSafeAreaInsets(
                ignoredKeyboardSafeAreaEdges: ignoredKeyboardSafeAreaEdges,
                { binding.wrappedValue = $0 }
            )
    }
}

// MARK: - Safe Area Insets Preference Key
private struct SafeAreaInsetsPreferenceKey: PreferenceKey {
    static let defaultValue: EdgeInsets = .init()

    static func reduce(value: inout EdgeInsets, nextValue: () -> EdgeInsets) {}
}
