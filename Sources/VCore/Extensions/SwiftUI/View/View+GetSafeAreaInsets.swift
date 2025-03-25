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
    ///             .getSafeAreaInsets({ safeAreaInsets = $0 })
    ///     }
    ///
    public func getSafeAreaInsets(
        ignoredKeyboardSafeAreaEdges: Edge.Set = [],
        _ action: @escaping (EdgeInsets) -> Void
    ) -> some View {
        self
            .background(content: {
                Color.clear
                    .ignoresSafeArea(.keyboard, edges: ignoredKeyboardSafeAreaEdges)
                    .onGeometryChange(
                        for: EdgeInsets.self,
                        of: { $0.safeAreaInsets },
                        action: action
                    )
            })
    }
}
