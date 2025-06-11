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
    ///             .getSize { size = $0 }
    ///     }
    ///
    public func getSize(
        _ action: @escaping (CGSize) -> Void
    ) -> some View {
        self
            .onGeometryChange(
                for: CGSize.self,
                of: { $0.size },
                action: action
            )
    }
}
