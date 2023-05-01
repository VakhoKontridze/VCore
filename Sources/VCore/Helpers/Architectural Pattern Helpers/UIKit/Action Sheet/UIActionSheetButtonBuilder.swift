//
//  UIActionSheetButtonBuilder.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.08.22.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation

// MARK: - UI Action Sheet Button Builder
/// Custom parameter attribute that constructs views from closures.
///
///     presentActionSheet(parameters: .init(
///         title: "Lorem Ipsum",
///         message: "Lorem ipsum dolor sit amet",
///         actions: {
///             UIActionSheetButton(title: "Confirm", action: { print("Confirmed") })
///             UIActionSheetButton(style: .cancel, title: "Cancel", action: { print("Cancelled") })
///         }
///     ))
///
@resultBuilder public struct UIActionSheetButtonBuilder {
    // MARK: Properties
    public typealias Component = any UIActionSheetButtonConvertible
    public typealias Result = [UIActionSheetButton]
    
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
