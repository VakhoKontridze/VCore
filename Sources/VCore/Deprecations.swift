//
//  Deprecations.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import Foundation

// MARK: - Network Client
extension NetworkClient {
    @available(*, deprecated, renamed: "completionQueue")
    public var completionQeueue: DispatchQueue {
        get { completionQueue }
        set { completionQueue = newValue }
    }
}

extension NetworkError {
    @available(*, deprecated, renamed: "invalidQueryParameters")
    public static var invalidQueryparameters: Self { .invalidQueryParameters }
}

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
    @available(*, unavailable, message: "Use `init` without `state` parameter and use `.disabled()` modifier")
    public init(
        state: SwiftUIBaseButtonState,
        gesture gestureHandler: @escaping (BaseButtonGestureState) -> Void,
        @ViewBuilder content: @escaping () -> Label
    ) {
        fatalError()
    }
    
    @available(*, unavailable, message: "Use `init` without `state` parameter and use `.disabled()` modifier")
    public init(
        state: SwiftUIBaseButtonState,
        action: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Label
    ) {
        fatalError()
    }

    @available(*, unavailable, message: "Use `init` without `state` parameter and use `.disabled()` modifier")
    public init(
        isEnabled: Bool,
        gesture gestureHandler: @escaping (BaseButtonGestureState) -> Void,
        @ViewBuilder content: @escaping () -> Label
    ) {
        fatalError()
    }
    
    @available(*, unavailable, message: "Use `init` without `state` parameter and use `.disabled()` modifier")
    public init(
        isEnabled: Bool,
        action: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Label
    ) {
        fatalError()
    }
}

#endif

// MARK: - Generic State and Models (CED)
@available(*, deprecated, renamed: "GenericState_CollapsedExpanded")
public typealias GenericState_CE = GenericState_CollapsedExpanded

@available(*, deprecated, renamed: "GenericStateModel_CollapsedExpanded")
public typealias GenericStateModel_CE = GenericStateModel_CollapsedExpanded

@available(*, deprecated, renamed: "GenericState_CollapsedExpandedDisabled")
public typealias GenericState_CED = GenericState_CollapsedExpandedDisabled

@available(*, deprecated, renamed: "GenericStateModel_CollapsedExpandedDisabled")
public typealias GenericStateModel_CED = GenericStateModel_CollapsedExpandedDisabled

// MARK: - Generic State and Models (EPD)
@available(*, deprecated, renamed: "GenericState_EnabledDisabled")
public typealias GenericState_ED = GenericState_EnabledDisabled

@available(*, deprecated, renamed: "GenericStateModel_EnabledDisabled")
public typealias GenericStateModel_ED = GenericStateModel_EnabledDisabled

@available(*, deprecated, renamed: "GenericState_EnabledPressed")
public typealias GenericState_EP = GenericState_EnabledPressed

@available(*, deprecated, renamed: "GenericStateModel_EnabledPressed")
public typealias GenericStateModel_EP = GenericStateModel_EnabledPressed

@available(*, deprecated, renamed: "GenericState_EnabledPressedDisabled")
public typealias GenericState_EPD = GenericState_EnabledPressedDisabled

@available(*, deprecated, renamed: "GenericStateModel_EnabledPressedDisabled")
public typealias GenericStateModel_EPD = GenericStateModel_EnabledPressedDisabled

// MARK: - Generic State and Models (EPFD)
@available(*, deprecated, renamed: "GenericState_EnabledFocused")
public typealias GenericState_EF = GenericState_EnabledFocused

@available(*, deprecated, renamed: "GenericStateModel_EnabledFocused")
public typealias GenericStateModel_EF = GenericStateModel_EnabledFocused

@available(*, deprecated, renamed: "GenericState_EnabledFocusedDisabled")
public typealias GenericState_EFD = GenericState_EnabledFocusedDisabled

@available(*, deprecated, renamed: "GenericStateModel_EnabledFocusedDisabled")
public typealias GenericStateModel_EFD = GenericStateModel_EnabledFocusedDisabled

@available(*, deprecated, renamed: "GenericState_EnabledPressedFocused")
public typealias GenericState_EPF = GenericState_EnabledPressedFocused

@available(*, deprecated, renamed: "GenericStateModel_EnabledPressedFocused")
public typealias GenericStateModel_EPF = GenericStateModel_EnabledPressedFocused

@available(*, deprecated, renamed: "GenericState_EnabledPressedFocusedDisabled")
public typealias GenericState_EPFD = GenericState_EnabledPressedFocusedDisabled

@available(*, deprecated, renamed: "GenericStateModel_EnabledPressedFocusedDisabled")
public typealias GenericStateModel_EPFD = GenericStateModel_EnabledPressedFocusedDisabled

// MARK: - Generic State and Models (EPLD)
@available(*, deprecated, renamed: "GenericState_EnabledLoading")
public typealias GenericState_EL = GenericState_EnabledLoading

@available(*, deprecated, renamed: "GenericStateModel_EnabledLoading")
public typealias GenericStateModel_EL = GenericStateModel_EnabledLoading

@available(*, deprecated, renamed: "GenericState_EnabledLoadingDisabled")
public typealias GenericState_ELD = GenericState_EnabledLoadingDisabled

@available(*, deprecated, renamed: "GenericStateModel_EnabledLoadingDisabled")
public typealias GenericStateModel_ELD = GenericStateModel_EnabledLoadingDisabled

@available(*, deprecated, renamed: "GenericState_EnabledPressedLoading")
public typealias GenericState_EPL = GenericState_EnabledPressedLoading

@available(*, deprecated, renamed: "GenericStateModel_EnabledPressedLoading")
public typealias GenericStateModel_EPL = GenericStateModel_EnabledPressedLoading

@available(*, deprecated, renamed: "GenericState_EnabledPressedLoadingDisabled")
public typealias GenericState_EPLD = GenericState_EnabledPressedLoadingDisabled

@available(*, deprecated, renamed: "GenericStateModel_EnabledPressedLoadingDisabled")
public typealias GenericStateModel_EPLD = GenericStateModel_EnabledPressedLoadingDisabled

// MARK: - Generic State and Models (OOIPD)
@available(*, deprecated, renamed: "GenericState_OffOnIndeterminate")
public typealias GenericState_OOI = GenericState_OffOnIndeterminate

@available(*, deprecated, renamed: "GenericStateModel_OffOnIndeterminate")
public typealias GenericStateModel_OOI = GenericStateModel_OffOnIndeterminate

@available(*, deprecated, renamed: "GenericState_OffOnIndeterminateDisabled")
public typealias GenericState_OOID = GenericState_OffOnIndeterminateDisabled

@available(*, deprecated, renamed: "GenericStateModel_OffOnIndeterminateDisabled")
public typealias GenericStateModel_OOID = GenericStateModel_OffOnIndeterminateDisabled

@available(*, deprecated, renamed: "GenericState_OffOnIndeterminatePressed")
public typealias GenericState_OOIP = GenericState_OffOnIndeterminatePressed

@available(*, deprecated, renamed: "GenericStateModel_OffOnIndeterminatePressed")
public typealias GenericStateModel_OOIP = GenericStateModel_OffOnIndeterminatePressed

@available(*, deprecated, renamed: "GenericState_OffOnIndeterminatePressedDisabled")
public typealias GenericState_OOIPD = GenericState_OffOnIndeterminatePressedDisabled

@available(*, deprecated, renamed: "GenericStateModel_OffOnIndeterminatePressedDisabled")
public typealias GenericStateModel_OOIPD = GenericStateModel_OffOnIndeterminatePressedDisabled

// MARK: - Generic State and Models (OOPD)
@available(*, deprecated, renamed: "GenericState_OffOn")
public typealias GenericState_OO = GenericState_OffOn

@available(*, deprecated, renamed: "GenericStateModel_OffOn")
public typealias GenericStateModel_OO = GenericStateModel_OffOn

@available(*, deprecated, renamed: "GenericState_OffOnDisabled")
public typealias GenericState_OOD = GenericState_OffOnDisabled

@available(*, deprecated, renamed: "GenericStateModel_OffOnDisabled")
public typealias GenericStateModel_OOD = GenericStateModel_OffOnDisabled

@available(*, deprecated, renamed: "GenericState_OffOnPressed")
public typealias GenericState_OOP = GenericState_OffOnPressed

@available(*, deprecated, renamed: "GenericStateModel_OffOnPressed")
public typealias GenericStateModel_OOP = GenericStateModel_OffOnPressed

@available(*, deprecated, renamed: "GenericState_OffOnPressedDisabled")
public typealias GenericState_OOPD = GenericState_OffOnPressedDisabled

@available(*, deprecated, renamed: "GenericStateModel_OffOnPressedDisabled")
public typealias GenericStateModel_OOPD = GenericStateModel_OffOnPressedDisabled

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Table View Protocols
@available(*, deprecated, renamed: "UITableViewDelegable")
public typealias UITableViewDelegatable = UITableViewDelegable

// MARK: - Collection View Protocols
@available(*, deprecated, renamed: "UICollectionViewDelegable")
public typealias UICollectionViewDelegatable = UICollectionViewDelegable

// MARK: - KeyPath Initializable Enumeration
@available(*, deprecated, renamed: "KeyPathInitializableEnumeration")
public typealias KVInitializableEnumeration = KeyPathInitializableEnumeration

// MARK: - UI Alert Viewable
extension UIAlertViewable {
    @available(*, deprecated, message: "Use method with `parameter` label")
    public func presentAlert(viewModel: UIAlertViewModel) {
        presentAlert(parameters: viewModel)
    }
}

extension UIAlertViewable where Self: UIViewController {
    @available(*, deprecated, message: "Use method with `parameter` label")
    public func presentAlert(viewModel: UIAlertViewModel) {
        presentAlert(parameters: viewModel)
    }
}

@available(*, deprecated, renamed: "UIAlertParameters")
public typealias UIAlertViewModel = UIAlertParameters

extension UIAlertParameters {
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
    
    @available(*, deprecated, renamed: "UIAlertButton")
    public typealias ButtonViewModel = Button

    public struct OneButtonViewModel {
        public var title: String?
        public var message: String
        public var dismissButton: Button
        
        public init(
            title: String?,
            message: String,
            dismissButton: Button
        ) {
            self.title = title
            self.message = message
            self.dismissButton = dismissButton
        }
    }

    public struct TwoButtonsViewModel {
        public var title: String?
        public var message: String
        public var primaryButton: Button
        public var secondaryButton: Button
        
        public init(
            title: String?,
            message: String,
            primaryButton: Button,
            secondaryButton: Button
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

extension UIAlertController {
    @available(*, deprecated, message: "Use method with `parameter` label")
    public convenience init(viewModel: UIAlertParameters) {
        self.init(parameters: viewModel)
    }
}

#endif

// MARK: - UI Table View Protocols
#if canImport(UIKit) && !os(watchOS)

@available(*, deprecated, renamed: "UITableViewCellParameter")
public typealias UITableViewCellViewModelable = UITableViewCellParameter

extension UITableViewDequeueable {
    @available(*, deprecated, message: "Use method with `parameter` label")
    public func configure(viewModel: any UITableViewCellParameter) {
        configure(parameter: viewModel)
    }
}

extension UITableViewDataSourceable {
    @available(*, deprecated, message: "Renamed to `TableViewCellParameter`")
    public func tableViewCellViewModel(section: Int, row: Int) -> any UITableViewCellParameter {
        tableViewCellParameter(section: section, row: row)
    }
}

extension UITableView {
    @available(*, deprecated, message: "Use method with `parameter` label")
    public func dequeueAndConfigureReusableCell(
        viewModel: any UITableViewCellParameter
    ) -> UITableViewCell {
        dequeueAndConfigureReusableCell(
            parameter: viewModel
        )
    }
}

#endif

// MARK: - UI Collection View Protocols
#if canImport(UIKit) && !os(watchOS)

@available(*, deprecated, renamed: "UICollectionViewCellParameter")
public typealias UICollectionViewCellViewModelable = UICollectionViewCellParameter

extension UICollectionViewDequeueable {
    @available(*, deprecated, message: "Use method with `parameter` label")
    public func configure(viewModel: any UICollectionViewCellParameter) {
        configure(parameter: viewModel)
    }
}

extension UICollectionViewDataSourceable {
    @available(*, deprecated, message: "Renamed to `collectionViewCellParameter`")
    public func collectionViewCellViewModel(section: Int, row: Int) -> any UICollectionViewCellParameter {
        collectionViewCellParameter(section: section, row: row)
    }
}

extension UICollectionView {
    @available(*, deprecated, message: "Use method with `parameter` label")
    public func dequeueAndConfigureReusableCell(
        indexPath: IndexPath,
        viewModel: any UICollectionViewCellParameter
    ) -> UICollectionViewCell {
        dequeueAndConfigureReusableCell(
            indexPath: indexPath,
            parameter: viewModel
        )
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

// MARK: - Extensions - UIKit
#if canImport(UIKit)

import UIKit

extension UIViewController {
    @available(*, deprecated, renamed: "dismissKeyboardOnOutsideTap")
    public func dismissKeyboardOnOutisdeTap() {
        dismissKeyboardOnOutsideTap()
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
