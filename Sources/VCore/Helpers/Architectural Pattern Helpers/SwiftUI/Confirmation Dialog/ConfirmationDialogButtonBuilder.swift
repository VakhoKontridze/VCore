//
//  ConfirmationDialogButtonBuilder.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.08.22.
//

import SwiftUI

// MARK: - Confirmation Dialog Button Convertible
/// Type that allows for conversion to `ConfirmationDialogButtonProtocol`.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public protocol ConfirmationDialogButtonConvertible {
    /// Converts `ConfirmationDialogButtonConvertible` to `ConfirmationDialogButtonProtocol` `Array`.
    func toButtons() -> [any ConfirmationDialogButtonProtocol]
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension Array: ConfirmationDialogButtonConvertible where Element == ConfirmationDialogButtonProtocol {
    public func toButtons() -> [any ConfirmationDialogButtonProtocol] { self }
}

// MARK: - Confirmation Dialog Button Builder
/// Custom parameter attribute that constructs views from closures.
///
///
///     @State private var parameters: ConfirmationDialogParameters? = .init(
///         title: "Lorem Ipsum",
///         message: "Lorem ipsum dolor sit amet",
///         actions: {
///             ConfirmationDialogButton(action: { print("Confirmed") }, title: "Confirm")
///             ConfirmationDialogButton(role: .cancel, action: { print("Cancelled") }, title: "Cancel")
///         }
///     )
///
///     var body: some View {
///         content
///             .confirmationDialog(parameters: $parameters)
///     }
///
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@resultBuilder public struct ConfirmationDialogButtonBuilder {
    // MARK: Properties
    public typealias Component = any ConfirmationDialogButtonConvertible
    public typealias Result = [any ConfirmationDialogButtonProtocol]
    
    // MARK: Build Blocks
    public static func buildBlock() -> Result {
        []
    }
    
    public static func buildBlock(_ components: Component...) -> Result {
        components.flatMap { $0.toButtons() }
    }
    
    public static func buildOptional(_ component: Component?) -> Result {
        component?.toButtons() ?? []
    }
    
    public static func buildEither(first component: Component) -> Result {
        component.toButtons()
    }

    public static func buildEither(second component: Component) -> Result {
        component.toButtons()
    }
    
    public static func buildArray(_ components: [Component]) -> Result {
        components.flatMap { $0.toButtons() }
    }
    
    public static func buildLimitedAvailability(_ component: Component) -> Result {
        component.toButtons()
    }

    public static func buildFinalResult(_ component: Component) -> Result {
        component.toButtons()
    }
}
