//
//  View+OnGeometryChangeAdditionalMethods.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16.07.25.
//

import SwiftUI

// MARK: - View + On Geometry Change Additional Methods
extension View {
    /// Adds an action to be performed when a value, created from a `GeometryProxy`, changes.
    public func onGeometryChange<T>(
        of transform: @escaping @Sendable (GeometryProxy) -> T,
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
    @available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 10.0, *)
    public func onGeometryChange<T>(
        of transform: @escaping @Sendable (GeometryProxy) -> T,
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
