//
//  View+OnGeometryChangeNoType.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16.07.25.
//

import SwiftUI

nonisolated extension View {
    /// Adds an action to be performed when a value, created from a `GeometryProxy`, changes.
    ///
    ///     var body: some View {
    ///         Text("Lorem ipsum")
    ///             .onGeometryChange(of: { $0.size.width }) { print($0) }
    ///     }
    ///
    public func onGeometryChange<T>(
        of transform: @Sendable @escaping (GeometryProxy) -> T,
        action: @escaping (T) -> Void
    ) -> some View
        where
            T: Equatable,
            T: Sendable
    {
        self
            .onGeometryChange(
                for: T.self,
                of: transform,
                action: action
            )
    }

    /// Adds an action to be performed when a value, created from a `GeometryProxy`, changes.
    ///
    ///     var body: some View {
    ///         Text("Lorem ipsum")
    ///             .onGeometryChange(of: { $0.frame(in: .global) }) { print($0) }
    ///     }
    ///
    @available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 10.0, *)
    public func onGeometryChange<T>(
        of transform: @Sendable @escaping (GeometryProxy) -> T,
        action: @escaping (T, T) -> Void
    ) -> some View
        where
            T: Equatable,
            T: Sendable
    {
        self
            .onGeometryChange(
                for: T.self,
                of: transform,
                action: action
            )
    }
}
