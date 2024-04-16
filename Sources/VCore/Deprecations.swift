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

// MARK: - Custom Dismiss Action
@available(*, deprecated, message: "Model will be removed in VCore 7.0")
public struct CustomDismissAction {
    public let action: () -> Void

    public init(
        _ action: @escaping () -> Void
    ) {
        self.action = action
    }

    init() {
        self.action = {}
    }

    public func callAsFunction() {
        action()
    }
}

extension View {
    @available(*, deprecated, message: "Method will be removed in VCore 7.0")
    public func customDismissAction(
        _ customDismissAction: CustomDismissAction
    ) -> some View {
        self
            .environment(\.customDismissAction, customDismissAction)
    }
}

extension EnvironmentValues {
    @available(*, deprecated, message: "Property will be removed in VCore 7.0")
    public var customDismissAction: CustomDismissAction {
        get { self[CustomDismissActionEnvironmentKey.self] }
        set { self[CustomDismissActionEnvironmentKey.self] = newValue }
    }
}

struct CustomDismissActionEnvironmentKey: EnvironmentKey {
    static let defaultValue: CustomDismissAction = .init()
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

// MARK: - Uninitializable
@available(*, deprecated, renamed: "Uninitializable")
@attached(member, names: named(init))
public macro NonInitializable() = #externalMacro(
    module: "VCoreMacros",
    type: "UninitializableMacro"
)
