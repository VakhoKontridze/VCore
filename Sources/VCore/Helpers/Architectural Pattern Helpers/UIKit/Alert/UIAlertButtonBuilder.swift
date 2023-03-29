//
//  UIAlertButtonBuilder.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import SwiftUI

// MARK: - UI Alert Button Convertible
/// Type that allows for conversion to `UIAlertButtonProtocol`.
public protocol UIAlertButtonConvertible {
    /// Converts `UIAlertButtonConvertible` to `UIAlertButtonProtocol` `Array`.
    func toButtons() -> [any UIAlertButtonProtocol]
}

extension Array: UIAlertButtonConvertible where Element == UIAlertButtonProtocol {
    public func toButtons() -> [any UIAlertButtonProtocol] { self }
}

extension EmptyView: UIAlertButtonConvertible {
    public func toButtons() -> [any UIAlertButtonProtocol] { [] }
}

// MARK: - UI Alert Button Builder
/// Custom parameter attribute that constructs views from closures.
///
///     presentAlert(parameters: UIAlertParameters(
///         title: "Lorem Ipsum",
///         message: "Lorem ipsum dolor sit amet",
///         actions: {
///             UIAlertButton(title: "Confirm", action: { print("Confirmed") })
///             UIAlertButton(style: .cancel, title: "Cancel", action: { print("Cancelled") })
///         }
///     ))
///
@resultBuilder public struct UIAlertButtonBuilder {
    // MARK: Properties
    public typealias Component = any UIAlertButtonConvertible
    public typealias Result = [any UIAlertButtonProtocol]
    
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

#endif
