//
//  View.SafeAreaMargins.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 27.06.22.
//

import SwiftUI

// MARK: - Safe Area Margins
@available(macOS, unavailable)
@available(watchOS, unavailable)
extension View {
    /// Adds padding equal to safe area insets to specific edges of the `View`.
    ///
    /// Safe area insets are retrieved from `UIDevice.safeAreaInsets`.
    ///
    /// Can be used to reverse effects of `ignoresSafeArea(_:edges:)` in nested view.
    ///
    ///     var body: some View {
    ///         ZStack(content: {
    ///             Color.gray
    ///
    ///             Color.accentColor
    ///                 .safeAreaMargins(edges: .all)
    ///         })
    ///         .ignoresSafeArea()
    ///     }
    ///
    @ViewBuilder public func safeAreaMargins(edges: Edge.Set = .all) -> some View {
#if canImport(UIKit) && !os(watchOS)
        self
            .padding(.leading, edges.contains(.leading) ? UIDevice.safeAreaInsets.left : 0)
            .padding(.trailing, edges.contains(.trailing) ? UIDevice.safeAreaInsets.right : 0)
            .padding(.top, edges.contains(.top) ? UIDevice.safeAreaInsets.top : 0)
            .padding(.bottom, edges.contains(.bottom) ? UIDevice.safeAreaInsets.bottom : 0)
#endif
    }
}
