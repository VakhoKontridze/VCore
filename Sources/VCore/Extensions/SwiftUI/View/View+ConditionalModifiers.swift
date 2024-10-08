//
//  View+ConditionalModifiers.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/6/21.
//

import SwiftUI

// MARK: - View + Conditional Modifiers
extension View {
    /// Applies modifier and transforms `View` if condition is met.
    ///
    /// This method should be used with caution, since any changes to the condition will cause view state to be reset.
    ///
    ///     private let isRed: Bool = true
    ///
    ///     var body: some View {
    ///         Text("Lorem Ipsum")
    ///             .applyIf(isRed, transform: { $0.foregroundStyle(.red) })
    ///     }
    ///
    @ViewBuilder 
    public func applyIf(
        _ condition: Bool,
        transform: (Self) -> some View
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    /// Applies modifier and transforms `View` if condition is met, or applies alternate modifier.
    ///
    /// This method should be used with caution, since any changes to the condition will cause view state to be reset.
    ///
    ///     private let isError: Bool = true
    ///
    ///     var body: some View {
    ///         Text("Lorem Ipsum")
    ///             .applyIf(
    ///                 isError,
    ///                 ifTransform: { $0.foregroundStyle(.red) },
    ///                 elseTransform: { $0.fontWeight(.bold) }
    ///             )
    ///     }
    ///
    @ViewBuilder 
    public func applyIf(
        _ condition: Bool,
        ifTransform: (Self) -> some View,
        elseTransform: (Self) -> some View
    ) -> some View {
        if condition {
            ifTransform(self)
        } else {
            elseTransform(self)
        }
    }
    
    /// Applies modifier and transforms `View` if value is non-`nil`.
    ///
    /// This method should be used with caution, since any changes to the condition will cause view state to be reset.
    ///
    ///     private let color: Color? = .accentColor
    ///
    ///     var body: some View {
    ///         Text("Lorem Ipsum")
    ///             .applyIfLet(color, transform: { $0.foregroundStyle($1) })
    ///     }
    ///
    @ViewBuilder 
    public func applyIfLet<Value>(
        _ value: Value?,
        transform: (Self, Value) -> some View
    ) -> some View {
        if let value {
            transform(self, value)
        } else {
            self
        }
    }
    
    /// Applies modifier and transforms `View` if value is non-`nil`, or applies alternate modifier.
    ///
    /// This method should be used with caution, since any changes to the condition will cause view state to be reset.
    ///
    ///     private let color: Color? = .accentColor
    ///
    ///     var body: some View {
    ///         Text("Lorem Ipsum")
    ///             .applyIfLet(
    ///                 color,
    ///                 ifTransform: { $0.foregroundStyle($1) },
    ///                 elseTransform: { $0.fontWeight(.bold) }
    ///             )
    ///     }
    ///
    @ViewBuilder 
    public func applyIfLet<Value>(
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
