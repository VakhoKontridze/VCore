//
//  View.SafeAreaMarginInsets.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 27.06.22.
//

import SwiftUI

// MARK: - Safe Area Margin Insets
@available(iOS 15.0, tvOS 15.0, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
extension View {
    /// Inserts `Spacer`s with width or height of safe are inset as margins for specified edges.
    ///
    /// Can be used to reverse effects of `ignoresSafeArea(_:edges:)` in nested view.
    ///
    ///     var body: some View {
    ///         ZStack(content: {
    ///             Color.gray
    ///
    ///             Color.accentColor
    ///                 .safeAreaMarginInsets(edges: .all)
    ///         })
    ///         .ignoresSafeArea()
    ///     }
    ///
    @ViewBuilder public func safeAreaMarginInsets(edges: Edge.Set = .all) -> some View {
#if os(iOS) || os(tvOS)
        self
            .safeAreaInset(edge: .leading, content: {
                if edges.contains(.leading) {
                    Spacer().frame(width: UIDevice.safeAreaInsetLeft)
                }
            })
            .safeAreaInset(edge: .trailing, content: {
                if edges.contains(.trailing) {
                    Spacer().frame(width: UIDevice.safeAreaInsetRight)
                }
            })
            .safeAreaInset(edge: .top, content: {
                if edges.contains(.top) {
                    Spacer().frame(height: UIDevice.safeAreaInsetTop)
                }
            })
            .safeAreaInset(edge: .bottom, content: {
                if edges.contains(.bottom) {
                    Spacer().frame(height: UIDevice.safeAreaInsetBottom)
                }
            })
#endif
    }
}
