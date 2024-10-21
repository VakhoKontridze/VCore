//
//  AlertButtonBuilder.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21.07.22.
//

import Foundation

// MARK: - Alert Button Builder
/// Custom parameter attribute that constructs views from closures.
@resultBuilder 
public struct AlertButtonBuilder: Sendable {
    // MARK: Properties
    public typealias Component = any AlertButtonConvertible
    public typealias Result = [any AlertButtonProtocol]
    
    // MARK: Build Blocks
    @MainActor
    public static func buildBlock() -> Result {
        []
    }
    
    @MainActor
    public static func buildBlock(_ components: Component...) -> Result {
        components.flatMap { $0.toButtons() }
    }
    
    @MainActor
    public static func buildOptional(_ component: Component?) -> Result {
        component?.toButtons() ?? []
    }
    
    @MainActor
    public static func buildEither(first component: Component) -> Result {
        component.toButtons()
    }
    
    @MainActor
    public static func buildEither(second component: Component) -> Result {
        component.toButtons()
    }
    
    @MainActor
    public static func buildArray(_ components: [Component]) -> Result {
        components.flatMap { $0.toButtons() }
    }
    
    @MainActor
    public static func buildLimitedAvailability(_ component: Component) -> Result {
        component.toButtons()
    }
    
    @MainActor
    public static func buildFinalResult(_ component: Component) -> Result {
        component.toButtons()
    }
}
