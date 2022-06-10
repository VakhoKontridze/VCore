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

#if canImport(UIKit) && !os(watchOS)

// MARK: - KeyPath Initializable Enumeration
@available(*, deprecated, renamed: "KeyPathInitializableEnumeration")
public typealias KVInitializableEnumeration = KeyPathInitializableEnumeration

// MARK: - UI Alert Viewable
extension UIAlertViewable {
    @available(*, deprecated, message: "Use new `struct` based ViewModel")
    public func presentAlert(viewModel: UIAlertViewModel_OLD) {
        switch viewModel {
        case .oneButton(let viewModel):
            presentAlert(viewModel: .init(
                title: viewModel.title,
                message: viewModel.message,
                action: .init(
                    title: viewModel.dismissButton.title,
                    action: viewModel.dismissButton.action
                )
            ))
            
        case .twoButtons(let viewModel):
            presentAlert(viewModel: .init(
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
            ))
        }
    }
}

@available(*, deprecated, message: "Use new `struct` based ViewModel")
public enum UIAlertViewModel_OLD {
    case oneButton(viewModel: OneButtonViewModel)
    case twoButtons(viewModel: TwoButtonsViewModel)

    public struct ButtonViewModel {
        public var title: String
        public var action: (() -> Void)?
        
        public init(
            title: String,
            action: (() -> Void)?
        ) {
            self.title = title
            self.action = action
        }
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
    
    @available(*, deprecated, message: "Use new `struct` based ViewModel")
    public var uiAlertController: UIAlertController {
        switch self {
        case .oneButton(let viewModel):
            let alert: UIAlertController = .init(
                title: viewModel.title ?? "", // Fixes weird bold bug when nil
                message: viewModel.message,
                preferredStyle: .alert
            )
            
            alert.addAction(.init(
                title: viewModel.dismissButton.title,
                style: .cancel,
                handler: { _ in viewModel.dismissButton.action?() }
            ))
            
            return alert
            
        case .twoButtons(let viewModel):
            let alert: UIAlertController = .init(
                title: viewModel.title ?? "", // Fixes weird bold bug when nil
                message: viewModel.message,
                preferredStyle: .alert
            )
            
            alert.addAction(.init(
                title: viewModel.primaryButton.title,
                style: .default,
                handler: { _ in viewModel.primaryButton.action?() }
            ))
            
            alert.addAction(.init(
                title: viewModel.secondaryButton.title,
                style: .cancel,
                handler: { _ in viewModel.secondaryButton.action?() }
            ))
            
            return alert
        }
    }
}

#endif

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
