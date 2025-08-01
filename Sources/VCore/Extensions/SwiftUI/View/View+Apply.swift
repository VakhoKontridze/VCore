//
//  View+Apply.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 23.03.23.
//

import SwiftUI

extension View {
    /// Applies a transformation to a `View`.
    ///
    /// This method should be used with caution, since any changes to the condition will cause view state to be reset.
    ///
    ///     var body: some View {
    ///         ContentView()
    ///             .apply {
    ///                 if #available(iOS 99.0, *) {
    ///                     $0.newFeature()
    ///                 } else {
    ///                     $0
    ///                 }
    ///             }
    ///     }
    ///
    public func apply<Content>(
        @ViewBuilder _ transform: (Self) -> Content
    ) -> some View
        where Content: View
    {
        transform(self)
    }
    
    /// Applies a transformation to a `View` if condition is met.
    ///
    /// This method should be used with caution, since any changes to the condition will cause view state to be reset.
    ///
    ///     private let isRed: Bool = true
    ///
    ///     var body: some View {
    ///         Text("Lorem Ipsum")
    ///             .applyIf(isRed) { $0.foregroundStyle(.red) }
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
    
    /// Applies a transformation to a `View` if condition is met.
    ///
    /// This method should be used with caution, since any changes to the condition will cause view state to be reset.
    ///
    ///     private let isError: Bool = true
    ///
    ///     var body: some View {
    ///         Text("Lorem Ipsum")
    ///             .applyIf(isError) {
    ///                 $0.foregroundStyle(.red)
    ///             } else: {
    ///                 $0.fontWeight(.bold)
    ///             }
    ///     }
    ///
    @ViewBuilder
    public func applyIf(
        _ condition: Bool,
        _ ifTransform: (Self) -> some View,
        else elseTransform: (Self) -> some View
    ) -> some View {
        if condition {
            ifTransform(self)
        } else {
            elseTransform(self)
        }
    }
    
    /// Applies a transformation to a `View` if condition is met.
    ///
    /// This method should be used with caution, since any changes to the condition will cause view state to be reset.
    ///
    ///     private let color: Color? = .accentColor
    ///
    ///     var body: some View {
    ///         Text("Lorem Ipsum")
    ///             .applyIfLet(color) { $0.foregroundStyle($1) }
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
    
    /// Applies a transformation to a `View` if condition is met.
    ///
    /// This method should be used with caution, since any changes to the condition will cause view state to be reset.
    ///
    ///     private let color: Color? = .accentColor
    ///
    ///     var body: some View {
    ///         Text("Lorem Ipsum")
    ///             .applyIfLet(color) {
    ///                 $0.foregroundStyle($1)
    ///             } else: {
    ///                 $0.fontWeight(.bold)
    ///             }
    ///     }
    ///
    @ViewBuilder
    public func applyIfLet<Value>(
        _ value: Value?,
        _ ifTransform: (Self, Value) -> some View,
        else elseTransform: (Self) -> some View
    ) -> some View {
        if let value {
            ifTransform(self, value)
        } else {
            elseTransform(self)
        }
    }
}
