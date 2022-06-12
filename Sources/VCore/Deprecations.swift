//
//  Deprecations.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import Foundation

// MARK: - Network Reachability Service
extension NetworkReachabilityService {
    @available(*, deprecated, message: "Use dynamic member of the same name")
    public static var isConnectedToNetwork: Bool { shared.isConnectedToNetwork }
    
    @available(*, deprecated, message: "Use dynamic member of the same name")
    public static func configure() { shared.configure() }
}

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

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - KeyPath Initializable Enumeration
@available(*, deprecated, renamed: "KeyPathInitializableEnumeration")
public typealias KVInitializableEnumeration = KeyPathInitializableEnumeration

// MARK: - UI Alert Viewable
extension UIAlertViewModel {
    @available(*, deprecated, message: "Use `init` with new API")
    public static func oneButton(viewModel: OneButtonViewModel) -> Self {
        self.init(
            title: viewModel.title,
            message: viewModel.message,
            action: .init(
                title: viewModel.dismissButton.title,
                action: viewModel.dismissButton.action
            )
        )
    }
    
    @available(*, deprecated, message: "Use `init` with new API")
    public static func twoButtons(viewModel: TwoButtonsViewModel) -> Self {
        self.init(
            title: viewModel.title,
            message: viewModel.message,
            actions: [
                .init(
                    title: viewModel.primaryButton.title,
                    action: viewModel.primaryButton.action
                ),
                .init(
                    title: viewModel.secondaryButton.title,
                    action: viewModel.secondaryButton.action
                )
            ]
        )
    }

    public struct OneButtonViewModel {
        public var title: String?
        public var message: String
        public var dismissButton: ButtonViewModel
        
        public init(
            title: String?,
            message: String,
            dismissButton: ButtonViewModel
        ) {
            self.title = title
            self.message = message
            self.dismissButton = dismissButton
        }
    }

    public struct TwoButtonsViewModel {
        public var title: String?
        public var message: String
        public var primaryButton: ButtonViewModel
        public var secondaryButton: ButtonViewModel
        
        public init(
            title: String?,
            message: String,
            primaryButton: ButtonViewModel,
            secondaryButton: ButtonViewModel
        ) {
            self.title = title
            self.message = message
            self.primaryButton = primaryButton
            self.secondaryButton = secondaryButton
        }
    }
    
    @available(*, deprecated, message: "Use `UIAlertController.init(viewModel:)` instead")
    public var uiAlertController: UIAlertController {
        .init(viewModel: self)
    }
}

#endif

// MARK: - Extensions - Foundation
extension Array where Element == Optional<String> {
    @available(*, deprecated, renamed: "compactMapNonNilNonEmpty")
    public func compactMapNonEmpty(_ transform: (String) throws -> String?) rethrows -> [String] {
        try compactMapNonNilNonEmpty(transform)
    }
}

extension Calendar {
    @available(*, deprecated, message: "Use method with `date` parameter name")
    public func numberOfDaysInMonth(for date: Date) -> Int? {
        numberOfDaysInMonth(date: date)
    }
}

#if canImport(UIKit) && !os(watchOS)

extension UIApplication {
    @available(*, deprecated, message: "Use `Bundle.main.displayName`")
    public var displayName: String? {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
    
    @available(*, deprecated, message: "Use `Bundle.main.version`")
    public var version: String? {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    @available(*, deprecated, message: "Use `Bundle.main.buildNumber`")
    public var buildNumber: String? {
        Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
    
    @available(*, deprecated, message: "Use native `Bundle.main.bundleIdentifier`")
    public var bundleID: String? {
        Bundle.main.bundleIdentifier
    }
}

#endif

// MARK: - Extensions - SwiftUI
@available(*, deprecated, renamed: "MinIdealMaxSizes")
public typealias SizeConfiguration = MinIdealMaxSizes

// MARK: - VCore Localization Service
extension VCoreLocalizationProvider {
    @available(*, deprecated, message: "Renamed to `networkErrorDescription(_:)`")
    public func value(networkError: NetworkError) -> String {
        networkErrorDescription(networkError)
    }
    
    @available(*, deprecated, message: "Renamed to `jsonEncoderErrorDescription(_:)`")
    public func value(jsonEncoderError: JSONEncoderError) -> String {
        jsonEncoderErrorDescription(jsonEncoderError)
    }
    
    @available(*, deprecated, message: "Renamed to `jsonDecoderErrorDescription(_:)`")
    public func value(jsonDecoderError: JSONDecoderError) -> String {
        jsonDecoderErrorDescription(jsonDecoderError)
    }
}
