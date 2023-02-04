//
//  Deprecations.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import Foundation

// MARK: - Multi Part Form Data Builder
extension MultiPartFormDataBuilder {
    @available(*, unavailable, message: "Use empty init with new `build` method")
    public init(
        json: [String: Any?],
        files: [String: (some AnyMultiPartFormDataFile)?]
    ) {
        fatalError()
    }
    
    @available(*, unavailable, message: "Use build method that takes parameters")
    public func build() -> (String, Data) {
        fatalError()
    }
}

// MARK: - Keychain Service
extension KeychainService {
    @available(*, deprecated, message: "Use instance method")
    public class func get(key: String) throws -> Data {
        try KeychainService.default.get(key: key)
    }
    
    @available(*, deprecated, message: "Use instance method")
    public class func set(key: String, data: Data?) throws {
        try KeychainService.default.set(key: key, data: data)
    }
    
    @available(*, deprecated, message: "Use instance method")
    public class func delete(key: String) throws {
        try KeychainService.default.delete(key: key)
    }
    
    @available(*, deprecated, message: "Use instance method")
    public class subscript(_ key: String) -> Data? {
        get { try? Self.default.get(key: key) } // Logged internally
        set { try? Self.default.set(key: key, data: newValue) } // Logged internally
    }
}

// MARK: - Architectural Pattern Helpers
import SwiftUI

@available(iOS 14.0, *)
@available(macOS 11.0, *)
@available(tvOS 14.0, *)
@available(watchOS 7.0, *)
extension ProgressViewParameters {
    @available(*, deprecated, message: "Use init without default value for `isInteractionDisabled`")
    public init(
        isInteractionDisabled: Bool = false,
        scalingFactor: CGFloat?
    ) {
        self.init(
            scalingFactor: scalingFactor,
            color: nil,
            isInteractionDisabled: isInteractionDisabled
        )
    }
    
    @available(*, deprecated, message: "Use init without default value for `isInteractionDisabled`")
    public init(
        isInteractionDisabled: Bool = false,
        color: Color?
    ) {
        self.init(
            scalingFactor: nil,
            color: color,
            isInteractionDisabled: isInteractionDisabled
        )
    }
    
    @available(*, deprecated, message: "Use init without default value for `isInteractionDisabled`")
    public init(
        isInteractionDisabled: Bool = false,
        scalingFactor: CGFloat?,
        color: Color?
    ) {
        self.init(
            scalingFactor: scalingFactor,
            color: color,
            isInteractionDisabled: isInteractionDisabled
        )
    }
}

// MARK: - Extensions - Foundation
extension String {
    @available(*, deprecated, message: "Use method instead")
    public var localized: String {
        NSLocalizedString(
            self,
            tableName: nil,
            bundle: .main,
            value: "",
            comment: ""
        )
    }
}

extension Date {
    @available(*, deprecated, message: "Use method instead")
    public var age: Int? {
        age()
    }
}

// MARK: - Extensions UI Kit
#if canImport(UIKit)

import UIKit

extension UIImage {
    @available(*, deprecated, renamed: "jpegCompressed")
    public func compressed(quality: CGFloat) -> UIImage? {
        jpegCompressed(quality: quality)
    }
}

#endif

// MARK: - Extensions - Swift UI
extension View {
    @available(*, deprecated, message: "Use method without flag argument name")
    public func onFirstAppear(
        didAppear didAppearForTheFirstTime: Binding<Bool>,
        perform action: (() -> Void)? = nil
    ) -> some View {
        self
            .onAppear(perform: {
                guard !didAppearForTheFirstTime.wrappedValue else { return }
                
                didAppearForTheFirstTime.wrappedValue = true
                action?()
            })
    }
}

#if os(iOS)

extension View {
    @available(*, deprecated, renamed: "inlineNavigationTitle")
    public func standardNavigationTitle(_ title: String) -> some View {
        self
            .inlineNavigationTitle(title)
    }
}

#endif

// MARK: - V Core Localization Manager
@available(*, deprecated, renamed: "VCoreLocalizationManager")
public typealias VCoreLocalizationService = VCoreLocalizationManager
