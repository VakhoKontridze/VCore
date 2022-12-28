//
//  AlertButtonBuilder.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21.07.22.
//

import Foundation

// MARK: - Alert Button Convertible
/// Type that allows for conversion to `AlertButtonProtocol`.
@available(iOS 15.0, *)
@available(macOS 12.0, *)
@available(tvOS 15.0, *)
@available(watchOS 8.0, *)
public protocol AlertButtonConvertible {
    /// Converts `AlertButtonConvertible` to `AlertButtonProtocol` `Array`.
    func toButtons() -> [any AlertButtonProtocol]
}

@available(iOS 15.0, *)
@available(macOS 12.0, *)
@available(tvOS 15.0, *)
@available(watchOS 8.0, *)
extension Array: AlertButtonConvertible where Element == AlertButtonProtocol {
    public func toButtons() -> [any AlertButtonProtocol] { self }
}

// MARK: - Alert Button Builder
/// Custom parameter attribute that constructs views from closures.
///
///     @State private var parameters: AlertParameters? = .init(
///         title: "Lorem Ipsum",
///         message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
///         actions: {
///             AlertButton(title: "Confirm", action: { print("Confirmed") })
///             AlertButton(role: .cancel, title: "Cancel", action: { print("Cancelled") })
///         }
///     )
///
///     var body: some View {
///         content
///             .alert(parameters: $parameters)
///     }
///
@available(iOS 15.0, *)
@available(macOS 12.0, *)
@available(tvOS 15.0, *)
@available(watchOS 8.0, *)
@resultBuilder public struct AlertButtonBuilder {
    // MARK: Properties
    public typealias Component = any AlertButtonConvertible
    public typealias Result = [any AlertButtonProtocol]
    
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
