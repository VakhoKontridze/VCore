//
//  View+GetFrame.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.09.23.
//

import SwiftUI

// MARK: - View + Get Frame
extension View {
    /// Retrieves frame from `View`.
    ///
    ///     @State private var frame: CGRect = .init()
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .getFrame(in: .global, { frame = $0 })
    ///     }
    ///
    public func getFrame(
        in coordinateSpace: CoordinateSpace,
        _ action: @escaping (CGRect) -> Void
    ) -> some View {
        self
            .onGeometryChange(
                for: CGRect.self,
                of: { $0.frame(in: coordinateSpace) },
                action: action
            )
    }

    /// Retrieves frame from `View`.
    ///
    ///     @State private var frame: CGRect = .init()
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .getFrame(in: .global, { frame = $0 })
    ///     }
    ///
    public func getFrame(
        in coordinateSpace: some CoordinateSpaceProtocol,
        _ action: @escaping (CGRect) -> Void
    ) -> some View {
        self
            .onGeometryChange(
                for: CGRect.self,
                of: { $0.frame(in: coordinateSpace) },
                action: action
            )
    }
}
