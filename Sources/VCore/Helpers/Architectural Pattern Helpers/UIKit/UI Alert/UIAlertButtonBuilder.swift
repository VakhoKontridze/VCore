//
//  UIAlertButtonBuilder.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation

// MARK: - UI Alert Button Builder
/// Custom parameter attribute that constructs views from closures.
@resultBuilder 
public struct UIAlertButtonBuilder {
    // MARK: Properties
    public typealias Component = any UIAlertButtonConvertible
    public typealias Result = [any UIAlertButtonProtocol]
    
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

#endif
