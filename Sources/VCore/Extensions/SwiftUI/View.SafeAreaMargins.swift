//
//  View.SafeAreaMargins.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 27.06.22.
//

import SwiftUI

// MARK: - Safe Area Margins
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
    ///                 .safeAreaMargins(edges: .all)
    ///         })
    ///         .ignoresSafeArea()
    ///     }
    ///
    public func safeAreaMargins(edges: Edge.Set = .all) -> some View {
        self
            .padding(.leading, edges.contains(.leading) ? UIDevice.safeAreaInsetLeft : 0)
            .padding(.trailing, edges.contains(.trailing) ? UIDevice.safeAreaInsetRight : 0)
            .padding(.top, edges.contains(.top) ? UIDevice.safeAreaInsetTop : 0)
            .padding(.bottom, edges.contains(.bottom) ? UIDevice.safeAreaInsetBottom : 0)
    }
}
