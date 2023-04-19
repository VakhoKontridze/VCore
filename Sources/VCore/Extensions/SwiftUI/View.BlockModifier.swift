//
//  View.BlockModifier.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 23.03.23.
//

import SwiftUI

// MARK: - View Block Modifier
extension View {
    /// Applies a block modifier to a `View` and returns a new `View`.
    ///
    /// This method should be used with caution, since it doesn't preserve view identity.
    ///
    ///     struct ContentView: View {
    ///         var body: some View {
    ///             SomeView()
    ///                 .applyModifier({
    ///     #if os(iOS) || os(macOS)
    ///                     $0.listRowSeparator(.hidden)
    ///     #else
    ///                     $0
    ///     #endif
    ///                 })
    ///         }
    ///     }
    ///
    public func applyModifier<Content>(
        @ViewBuilder _ block: (Self) -> Content
    ) -> some View
        where Content: View
    {
        block(self)
    }
}
