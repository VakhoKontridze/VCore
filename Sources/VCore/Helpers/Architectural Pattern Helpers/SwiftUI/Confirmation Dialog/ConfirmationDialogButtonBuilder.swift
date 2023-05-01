//
//  ConfirmationDialogButtonBuilder.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.08.22.
//

import Foundation

// MARK: - Confirmation Dialog Button Builder
/// Custom parameter attribute that constructs views from closures.
///
///     @State private var parameters: ConfirmationDialogParameters?
///
///     var body: some View {
///         Button(
///             "Present",
///             action: {
///                 parameters = ConfirmationDialogParameters(
///                     title: "Lorem Ipsum",
///                     message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
///                     actions: {
///                         ConfirmationDialogButton(action: { print("Confirmed") }, title: "Confirm")
///                         ConfirmationDialogButton(role: .cancel, action: { print("Cancelled") }, title: "Cancel")
///                     }
///                 )
///             }
///         )
///         .confirmationDialog(parameters: $parameters)
///
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@resultBuilder public struct ConfirmationDialogButtonBuilder {
    // MARK: Properties
    public typealias Component = any ConfirmationDialogButtonConvertible
    public typealias Result = [ConfirmationDialogButton]
    
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
