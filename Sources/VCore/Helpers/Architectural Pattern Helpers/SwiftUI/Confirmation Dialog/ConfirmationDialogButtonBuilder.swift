//
//  ConfirmationDialogButtonBuilder.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.08.22.
//

import Foundation

// MARK: - Confirmation Dialog Button Builder
/// Custom parameter attribute that constructs views from closures.
@resultBuilder 
public struct ConfirmationDialogButtonBuilder: Sendable {
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
