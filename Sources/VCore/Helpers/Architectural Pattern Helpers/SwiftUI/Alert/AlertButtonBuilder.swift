//
//  AlertButtonBuilder.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21.07.22.
//

import Foundation

// MARK: - Alert Button Builder
/// Custom parameter attribute that constructs views from closures.
///
///     @State private var parameters: AlertParameters?
///
///     var body: some View {
///         Button(
///             "Present",
///             action: {
///                 parameters = AlertParameters(
///                     title: "Lorem Ipsum",
///                     message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
///                     actions: {
///                         AlertButton(action: { print("Confirmed") }, title: "Confirm")
///                         AlertButton(role: .cancel, action: { print("Cancelled") }, title: "Cancel")
///                     }
///                 )
///             }
///         )
///         .alert(parameters: $parameters)
///     }
///
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@resultBuilder public struct AlertButtonBuilder {
    // MARK: Properties
    public typealias Component = any AlertButtonConvertible
    public typealias Result = [AlertButton]
    
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
