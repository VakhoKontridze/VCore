//
//  Deprecations.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import SwiftUI

// MARK: - Aligned Grid Layout
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension AlignedGridLayout {
    @available(*, deprecated, renamed: "init(horizontalAlignment:verticalAlignment:spacingHorizontal:spacingVertical:)")
    public init(
        alignment: HorizontalAlignment,
        verticalAlignment: VerticalAlignment = .center,
        spacingHorizontal: CGFloat,
        spacingVertical: CGFloat
    ) {
        self.init(
            horizontalAlignment: alignment,
            verticalAlignment: verticalAlignment,
            spacingHorizontal: spacingHorizontal,
            spacingVertical: spacingVertical
        )
    }

    @available(*, deprecated, renamed: "init(horizontalAlignment:verticalAlignment:spacing:)")
    public init(
        alignment: HorizontalAlignment,
        verticalAlignment: VerticalAlignment = .center,
        spacing: CGFloat
    ) {
        self.init(
            horizontalAlignment: alignment,
            verticalAlignment: verticalAlignment,
            spacingHorizontal: spacing,
            spacingVertical: spacing
        )
    }
}

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

// MARK: - Keychain Storage
extension KeychainStorage {
    @available(*, deprecated, message: "User init with 'keychainService' parameter")
    public init(
        wrappedValue defaultValue: Value,
        _ key: String,
        configuration: KeychainServiceConfiguration
    )
        where Value: Codable
    {
        self.init(
            wrappedValue: defaultValue,
            key,
            keychainService: KeychainService(configuration: configuration)
        )
    }

    @available(*, deprecated, message: "User init with 'keychainService' parameter")
    public init(
        _ key: String,
        configuration: KeychainServiceConfiguration
    )
        where Value: Codable & ExpressibleByNilLiteral
    {
        self.init(
            wrappedValue: nil,
            key,
            configuration: configuration
        )
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

// MARK: - Localization Manager
extension LocalizationManager {
    @available(*, unavailable, message: "Use property directly")
    public func setCurrentLocale(to locale: Locale) {
        fatalError()
    }

    @available(*, unavailable, message: "Use property directly")
    public func addLocale(_ locale: Locale) {
        fatalError()
    }

    @available(*, unavailable, message: "Use property directly")
    public func addLocales(_ locales: [Locale]) {
        fatalError()
    }

    @available(*, unavailable, message: "Use property directly")
    public func setDefaultLocale(to locale: Locale) {
        fatalError()
    }

    @available(iOS, deprecated: 16.0, message: "Use `localized` instead")
    @available(macOS, deprecated: 13.0, message: "Use `localized` instead")
    @available(tvOS, deprecated: 16.0, message: "Use `localized` instead")
    @available(watchOS, deprecated: 9.0, message: "Use `localized` instead")
    @available(visionOS, deprecated: 1.0, message: "Use `localized` instead")
    public func localizedInStringsFile(
        _ key: String,
        tableName: String? = nil,
        bundle: Bundle = .main,
        value: String = ""
    ) -> String {
        guard
            let path: String = Self.findStringsFileBundle(bundle: bundle, locale: currentLocale),
            let currentLocaleBundle: Bundle = .init(path: path)
        else {
            return value
        }

        return currentLocaleBundle.localizedString(
            forKey: key,
            value: value,
            table: tableName
        )
    }

    private static func findStringsFileBundle(
        bundle: Bundle,
        locale: Locale
    ) -> String? {
        let fileType: String = "lproj"

        return
            bundle.path(forResource: locale.identifier, ofType: fileType) ??
            bundle.path(forResource: locale.languageCode, ofType: fileType)  // Just in case "en_US" is passed, but file is called "en"
    }

    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    @available(*, deprecated, renamed: "localize")
    public func localizedInStringCatalog(
        _ key: String,
        table: String? = nil,
        bundle: Bundle? = nil,
        locale: Locale = .current,
        comment: StaticString? = nil
    ) -> String {
        localize(
            key,
            table: table,
            bundle: bundle,
            comment: comment
        )
    }
}

// MARK: - Keychain Service
extension KeychainService {
    @available(*, deprecated, message: "Use method without 'Optional' 'data' parameter")
    public func set(
        key: String,
        data: Data?
    ) throws {
        switch data {
        case nil:
            try delete(key: key)

        case let data?:
            try set(key: key, value: data)
        }
    }
}

// MARK: - Extensions - Foundation
extension String {
    @available(*, deprecated, message: "Initializer will be removed in VCore 7.0")
    public init?<Subject>(unwrappedDescribing instance: Subject?) {
        guard let instance else { return nil }
        self.init(describing: instance)
    }
}

extension AttributedString {
    @available(*, deprecated, renamed: "init(string:attributeContainers:)")
    public init(
        _ string: String,
        attributeContainers: [Character: AttributeContainer]
    ) throws {
        self.init(string: string, attributeContainers: attributeContainers)
    }

    @available(*, deprecated, renamed: "init(string:attributeContainers:)")
    public init(
        defaultingIfError string: String,
        attributeContainers: [Character: AttributeContainer]
    ) {
        self.init(string: string, attributeContainers: attributeContainers)
    }

    @available(*, deprecated, renamed: "init(string:attributeContainers:)")
    public init(
        stringAndDefault: String,
        attributeContainers: [Character: AttributeContainer]
    ) {
        self.init(string: stringAndDefault, attributeContainers: attributeContainers)
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

// MARK: - Case Detection
@available(*, unavailable, message: "Use 'AccessLevelModifierKeyword' for 'accessLevelModifier'")
@attached(member, names: arbitrary)
public macro CaseDetection(
    accessLevelModifier: String
) = #externalMacro(
    module: "VCoreMacrosImplementation",
    type: "CaseDetectionMacro"
)

// MARK: - Coding Keys Generation
@available(*, unavailable, message: "Use 'AccessLevelModifierKeyword' for 'accessLevelModifier'")
@attached(member, names: named(CodingKeys))
public macro CodingKeysGeneration(
    accessLevelModifier: String
) = #externalMacro(
    module: "VCoreMacrosImplementation",
    type: "CodingKeysGenerationMacro"
)

@available(*, unavailable, message: "Macro is unavailable. All properties not marked with 'CKGProperty' will be automatically ignored.")
@attached(peer)
public macro CKGCodingKeyIgnored() = #externalMacro(
    module: "VCoreMacrosImplementation",
    type: "CKGCodingKeyIgnoredMacro"
)

@available(*, unavailable, renamed: "CKGProperty")
@attached(peer)
public macro CKGCodingKey(
    _ key: String
) = #externalMacro(
    module: "VCoreMacrosImplementation",
    type: "CKGPropertyMacro"
)

// MARK: - Option Set Representation
@available(*, unavailable, message: "Use 'AccessLevelModifierKeyword' for 'accessLevelModifier'")
@attached(member, names: arbitrary)
@attached(extension, conformances: OptionSet)
public macro OptionSetRepresentation<RawType>(
    accessLevelModifier: String
) = #externalMacro(
    module: "VCoreMacrosImplementation",
    type: "OptionSetRepresentationMacro"
)

// MARK: - Uninitializable
@available(*, deprecated, renamed: "Uninitializable")
@attached(member, names: named(init))
public macro NonInitializable() = #externalMacro(
    module: "VCoreMacrosImplementation",
    type: "UninitializableMacro"
)
