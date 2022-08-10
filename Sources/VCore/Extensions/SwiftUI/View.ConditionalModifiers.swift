//
//  View.ConditionalModifiers.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/6/21.
//

import SwiftUI

// MARK: - Conditional View Modifiers
extension View {
    /// Applies modifier and transforms view if condition is met.
    ///
    ///     let isRed: Bool = true
    ///
    ///     var body: some View {
    ///         Text("Lorem Ipsum")
    ///             .if(isRed, transform: { $0.foregroundColor(.red) })
    ///     }
    ///
    @ViewBuilder public func `if`(
        _ condition: Bool,
        transform: (Self) -> some View
    ) -> some View {
        switch condition {
        case false: self
        case true: transform(self)
        }
    }

    /// Applies modifier and transforms view if condition is met, or applies alternate modifier.
    ///
    ///     let isError: Bool = true
    ///
    ///     var body: some View {
    ///         Text("Lorem Ipsum")
    ///             .if(
    ///                 isError,
    ///                 ifTransform: { $0.foregroundColor(.red) },
    ///                 elseTransform: { $0.fontWeight(.bold) }
    ///             )
    ///     }
    ///
    @ViewBuilder public func `if`(
        _ condition: Bool,
        ifTransform: (Self) -> some View,
        elseTransform: (Self) -> some View
    ) -> some View {
        switch condition {
        case false: elseTransform(self)
        case true: ifTransform(self)
        }
    }
    
    /// Applies modifier and transforms view if value is non-`nil`.
    ///
    ///     let color: Color? = .accentColor
    ///
    ///     var body: some View {
    ///         Text("Lorem Ipsum")
    ///             .ifLet(color, transform: { $0.foregroundColor($1) })
    ///     }
    ///
    @ViewBuilder public func ifLet<Value>(
        _ value: Value?,
        transform: (Self, Value) -> some View
    ) -> some View {
        if let value {
            transform(self, value)
        } else {
            self
        }
    }
    
    /// Applies modifier and transforms view if value is non-`nil`, or applies alternate modifier.
    ///
    ///     let color: Color? = .accentColor
    ///
    ///     var body: some View {
    ///         Text("Lorem Ipsum")
    ///             .ifLet(
    ///                 color,
    ///                 ifTransform: { $0.foregroundColor($1) },
    ///                 elseTransform: { $0.fontWeight(.bold) }
    ///             )
    ///     }
    ///
    @ViewBuilder public func `ifLet`<Value>(
        _ value: Value?,
        ifTransform: (Self, Value) -> some View,
        elseTransform: (Self) -> some View
    ) -> some View {
        if let value {
            ifTransform(self, value)
        } else {
            elseTransform(self)
        }
    }
}
