//
//  Deprecations.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import Foundation

// MARK: - Multi Part Form Data Builder
@available(*, deprecated, renamed: "AnyMultiPartFormDataFile")
public typealias AnyMultiPartFormFile = AnyMultiPartFormDataFile

// MARK: - JSON Type Casts
extension Optional where Wrapped == Any {
    @available(*, deprecated, renamed: "toUnwrappedJSON")
    public var toWrappedJSON: [String: Any?] {
        return toUnwrappedJSON
    }

    @available(*, deprecated, renamed: "toUnwrappedJSONArray")
    public var toWrappedJSONArray: [[String: Any?]] {
        toUnwrappedJSONArray
    }
}

// MARK: - Swift UI Base Button
#if os(iOS)

import SwiftUI

extension SwiftUIBaseButton {
    @available(*, unavailable, message: "Use `init` without `state` parameter and use `.disabled()` modifer")
    public init(
        state: SwiftUIBaseButtonState,
        gesture gestureHandler: @escaping (BaseButtonGestureState) -> Void,
        @ViewBuilder content: @escaping () -> Label
    ) {
        fatalError()
    }
    
    @available(*, unavailable, message: "Use `init` without `state` parameter and use `.disabled()` modifer")
    public init(
        state: SwiftUIBaseButtonState,
        action: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Label
    ) {
        fatalError()
    }

    @available(*, unavailable, message: "Use `init` without `state` parameter and use `.disabled()` modifer")
    public init(
        isEnabled: Bool,
        gesture gestureHandler: @escaping (BaseButtonGestureState) -> Void,
        @ViewBuilder content: @escaping () -> Label
    ) {
        fatalError()
    }
    
    @available(*, unavailable, message: "Use `init` without `state` parameter and use `.disabled()` modifer")
    public init(
        isEnabled: Bool,
        action: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Label
    ) {
        fatalError()
    }
}

#endif

// MARK: - VCore Localization Service
extension VCoreLocalizationProvider {
    public func value(networkError: NetworkError) -> String {
        networkErrorDescription(networkError)
    }
    
    public func value(jsonEncoderError: JSONEncoderError) -> String {
        jsonEncoderErrorDescription(jsonEncoderError)
    }
    
    public func value(jsonDecoderError: JSONDecoderError) -> String {
        jsonDecoderErrorDescription(jsonDecoderError)
    }
}
