//
//  View+OnScrollGeometryChangeNoType.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 30.10.26.
//

public import SwiftUI

nonisolated extension View {
    /// Adds an action to be performed when a value, created from a `ScrollGeometry`, changes.
    ///
    ///     var body: some View {
    ///         ScrollView {
    ///             ...
    ///         }
    ///         .onScrollGeometryChange(of: { $0.contentOffset.y }) { print($0) }
    ///     }
    ///
    public func onScrollGeometryChange<T>(
        of transform: @escaping (ScrollGeometry) -> T,
        action: @escaping (T) -> Void
    ) -> some View
        where T: Equatable
    {
        self
            .onScrollGeometryChange(
                for: T.self,
                of: transform,
                action: { (_, newValue) in action(newValue) }
            )
    }

    /// Adds an action to be performed when a value, created from a `ScrollGeometry`, changes.
    ///
    ///     var body: some View {
    ///         ScrollView {
    ///             ...
    ///         }
    ///         .onScrollGeometryChange(of: { $0.contentOffset.y }) { print($0, $1) }
    ///     }
    ///
    public func onScrollGeometryChange<T>(
        of transform: @escaping (ScrollGeometry) -> T,
        action: @escaping (T, T) -> Void
    ) -> some View
        where T: Equatable
    {
        self
            .onScrollGeometryChange(
                for: T.self,
                of: transform,
                action: action
            )
    }
}
