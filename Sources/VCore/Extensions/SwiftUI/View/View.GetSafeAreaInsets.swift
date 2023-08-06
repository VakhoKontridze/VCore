//
//  View.GetSafeAreaInsets.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.08.23.
//

import SwiftUI

// MARK: - View Get Safe Area Insets
extension View {
    /// Retrieves `EdgeInsets` from `View`.
    ///
    ///     @State private var safeAreaInsets: EdgeInsets = .init()
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .getSafeAreaInsets({ safeAreaInsets = $0 })
    ///     }
    ///
    public func getSafeAreaInsets(
        _ action: @escaping (EdgeInsets) -> Void
    ) -> some View {
        self
            .background(
                GeometryReader(content: { proxy in
                    Color.clear
                        .preference(key: SafeAreaInsetsPreferenceKey.self, value: proxy.safeAreaInsets)
                })
            )
            .onPreferenceChange(SafeAreaInsetsPreferenceKey.self, perform: action)
    }
}

// MARK: - SafeAreaInsets Preference Key
private struct SafeAreaInsetsPreferenceKey: PreferenceKey {
    static var defaultValue: EdgeInsets = .init()

    static func reduce(value: inout EdgeInsets, nextValue: () -> EdgeInsets) {}
}
