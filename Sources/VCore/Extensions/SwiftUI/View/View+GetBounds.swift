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
    ///             .getBounds(of: .global) { bounds = $0 }
    ///     }
    ///
    public func getBounds(
        of coordinateSpace: NamedCoordinateSpace,
        _ action: @escaping (CGRect?) -> Void
    ) -> some View {
        self
            .onGeometryChange(
                for: CGRect?.self,
                of: { $0.bounds(of: coordinateSpace) },
                action: action
            )
    }
}
