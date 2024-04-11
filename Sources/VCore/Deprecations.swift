//
//  Deprecations.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import SwiftUI

// MARK: - KeyPath Initializable Enumeration
extension KeyPathInitializableEnumeration {
    @available(*, deprecated, message: "Use initializer instead")
    public static func aCase<Property>(
        key keyPath: KeyPath<Self, Property>,
        value: Property
    ) -> Self?
        where Property: Equatable
    {
        Self.allCases.first { $0[keyPath: keyPath] == value }
    }
}

// MARK: - Extensions - Foundation
extension AttributedString {
    @available(*, deprecated, renamed: "init(string:attributeContainers:)")
    public init(
        _ string: String,
        attributeContainers: [Character: AttributeContainer]
    ) throws {
        try self.init(string: string, attributeContainers: attributeContainers)
    }

    @available(*, deprecated, renamed: "init(stringAndDefault:attributeContainers:)")
    public init(
        defaultingIfError string: String,
        attributeContainers: [Character: AttributeContainer]
    ) {
        self.init(stringAndDefault: string, attributeContainers: attributeContainers)
    }
}

// MARK: - Extensions - UIKit
#if canImport(UIKit) && !os(watchOS)

extension UIApplication {
    @available(*, deprecated, message: "Method will be removed in VCore 7.0")
    public func firstWindow(
        activationStates: [UIScene.ActivationState],
        where predicate: (UIWindow) throws -> Bool
    ) rethrows -> UIWindow? {
        try connectedScenes
            .filter { activationStates.contains($0.activationState) }
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first(where: predicate)
    }
}

#endif

// MARK: - Uninitializable Macro
@available(*, deprecated, renamed: "Uninitializable")
@attached(member, names: named(init))
public macro NonInitializable() = #externalMacro(
    module: "VCoreMacros",
    type: "UninitializableMacro"
)
