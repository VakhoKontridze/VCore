//
//  Deprecations.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import SwiftUI

// MARK: - Localization Manager
extension LocalizationManager {
    @available(*, unavailable, message: "Use 'currentLocaleChangePublisher' instead")
    public static var currentLocaleDidChangeNotification: Notification.Name { fatalError() }
}

extension LocalizationManager {
    @available(*, deprecated, renamed: "localizedInStringsFile")
    public func localized(
        _ key: String,
        tableName: String? = nil,
        bundle: Bundle = .main,
        value: String = ""
    ) -> String {
        localizedInStringsFile(
            key,
            tableName: tableName,
            bundle: bundle,
            value: value
        )
    }
}

extension String {
    @available(*, deprecated, message: "Use 'LocalizationManager.localized' method instead")
    public func localizedWithManager(
        tableName: String? = nil,
        bundle: Bundle = .main,
        value: String = ""
    ) -> String {
        LocalizationManager.shared.localizedInStringsFile(
            self,
            tableName: tableName,
            bundle: bundle,
            value: value
        )
    }
}

extension String {
    @available(*, deprecated, message: "Use new 'String' catalog API instead")
    public func localized(
        tableName: String? = nil,
        bundle: Bundle = .main,
        value: String = "",
        comment: String = ""
    ) -> String {
        NSLocalizedString(
            self,
            tableName: tableName,
            bundle: bundle,
            value: value,
            comment: comment
        )
    }
}

// MARK: - Network Reachability Service
extension NetworkReachabilityService {
    @available(*, unavailable, message: "Use 'connectedPublisher' instead")
    public static var connectedNotification: Notification.Name { fatalError() }

    @available(*, unavailable, message: "Use 'disconnectedPublisher' instead")
    public static var disconnectedNotification: Notification.Name { fatalError() }
}

// MARK: - Session Manager
extension SessionManager {
    @available(*, deprecated, renamed: "currentID")
    public var currentSessionID: Int {
        currentID
    }

    @available(*, deprecated, renamed: "generateNewID")
    public var newSessionID: Int {
        generateNewID()
    }

    @available(*, deprecated, renamed: "isValidID")
    public func sessionIsValid(id: Int) -> Bool {
        isValidID(id)
    }
}

// MARK: - Fetch Delegating Async Image
@available(*, unavailable, message: "Use 'VFetchingAsyncImage' from 'VComponents")
public struct FetchDelegatingAsyncImage<Parameter, Content, PlaceholderContent>: View
    where
        Parameter: Equatable,
        Content: View,
        PlaceholderContent: View
{
    public init(
        uiModel: FetchDelegatingAsyncImageUIModel = .init(),
        from parameter: Parameter?,
        fetch fetchHandler: @escaping @Sendable (Parameter) async throws -> Image
    )
        where
            Content == Never,
            PlaceholderContent == Never
    {
        fatalError()
    }

    public init(
        uiModel: FetchDelegatingAsyncImageUIModel = .init(),
        from parameter: Parameter?,
        fetch fetchHandler: @escaping @Sendable (Parameter) async throws -> Image,
        @ViewBuilder content: @escaping (Image) -> Content
    )
        where
            PlaceholderContent == Never
    {
        fatalError()
    }

    public init(
        uiModel: FetchDelegatingAsyncImageUIModel = .init(),
        from parameter: Parameter?,
        fetch fetchHandler: @escaping @Sendable (Parameter) async throws -> Image,
        @ViewBuilder content: @escaping (Image) -> Content,
        @ViewBuilder placeholder placeholderContent: @escaping () -> PlaceholderContent
    ) {
        fatalError()
    }

    public init(
        uiModel: FetchDelegatingAsyncImageUIModel = .init(),
        from parameter: Parameter?,
        fetch fetchHandler: @escaping @Sendable (Parameter) async throws -> Image,
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    )
        where PlaceholderContent == Never
    {
        fatalError()
    }

    public var body: some View {
        Color.clear
    }
}

@available(*, unavailable, message: "Use 'VFetchingAsyncImage' from 'VComponents")
public struct FetchDelegatingAsyncImageUIModel {
    public init() {}
}

// MARK: - Fetch Delegating Completion Image
@available(*, unavailable, message: "FetchDelegatingCompletionImage' is removed. Use 'VFetchingAsyncImage' from 'VComponents instead.")
public struct FetchDelegatingCompletionImage<Parameter, Content, PlaceholderContent>: View
    where
        Parameter: Equatable,
        Content: View,
        PlaceholderContent: View
{
    public init(
        uiModel: FetchDelegatingCompletionImageUIModel = .init(),
        from parameter: Parameter?,
        fetch fetchHandler: @escaping (Parameter, @escaping (Result<Image, any Error>) -> Void) -> Void
    )
        where
            Content == Never,
            PlaceholderContent == Never
    {
        fatalError()
    }

    public init(
        uiModel: FetchDelegatingCompletionImageUIModel = .init(),
        from parameter: Parameter?,
        fetch fetchHandler: @escaping (Parameter, @escaping (Result<Image, any Error>) -> Void) -> Void,
        @ViewBuilder content: @escaping (Image) -> Content
    )
        where
            PlaceholderContent == Never
    {
        fatalError()
    }

    public init(
        uiModel: FetchDelegatingCompletionImageUIModel = .init(),
        from parameter: Parameter?,
        fetch fetchHandler: @escaping (Parameter, @escaping (Result<Image, any Error>) -> Void) -> Void,
        @ViewBuilder content: @escaping (Image) -> Content,
        @ViewBuilder placeholder placeholderContent: @escaping () -> PlaceholderContent
    ) {
        fatalError()
    }

    public init(
        uiModel: FetchDelegatingCompletionImageUIModel = .init(),
        from parameter: Parameter?,
        fetch fetchHandler: @escaping (Parameter, @escaping (Result<Image, any Error>) -> Void) -> Void,
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    )
        where PlaceholderContent == Never
    {
        fatalError()
    }

    public var body: some View {
        Color.clear
    }
}

@available(*, unavailable, message: "FetchDelegatingCompletionImage' is removed. Use 'VFetchingAsyncImage' from 'VComponents instead.")
public struct FetchDelegatingCompletionImageUIModel {
    public init() {}
}

// MARK: - Responder Chain UI Toolbar
#if canImport(UIKit) && !(os(tvOS) || os(watchOS))

@available(*, deprecated, renamed: "ResponderChainUIToolbar")
public typealias ResponderChainToolBar = ResponderChainUIToolbar

@available(*, deprecated, renamed: "ResponderChainUIToolbarUIModel")
public typealias ResponderChainToolBarUIModel = ResponderChainUIToolbarResponderParameters

@available(*, deprecated, renamed: "ResponderChainUIToolbarUIModel")
public typealias ResponderChainToolBarResponderParameters = ResponderChainUIToolbarResponderParameters

@available(*, deprecated, renamed: "ResponderChainUIToolbarResponder")
public typealias ResponderChainToolBarResponder = ResponderChainUIToolbarResponder

@available(*, deprecated, renamed: "ResponderChainUIToolbarManager")
public typealias ResponderChainToolBarManager = ResponderChainUIToolbarManager

#endif

@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(*, deprecated, renamed: "ResponderChainToolbarUIModel")
public typealias SwiftUIResponderChainToolBarUIModel = ResponderChainToolbarUIModel

@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension View {
    @available(*, deprecated, renamed: "responderChainToolbar")
    public func responderChainToolBar<Value>(
        uiModel: ResponderChainToolbarUIModel = .init(),
        focus binding: FocusState<Value?>.Binding,
        equals value: Value,
        inResponderChain responderChain: [Value]
    ) -> some View
        where Value: Hashable
    {
        self
            .responderChainToolbar(
                uiModel: uiModel,
                focus: binding,
                equals: value,
                inResponderChain: responderChain
            )
    }

    @available(*, deprecated, renamed: "responderChainToolbar")
    public func responderChainToolBar<Value>(
        uiModel: ResponderChainToolbarUIModel = .init(),
        focus binding: FocusState<Value?>.Binding,
        equals value: Value
    ) -> some View
        where Value: Hashable & CaseIterable
    {
        self
            .responderChainToolbar(
                uiModel: uiModel,
                focus: binding,
                equals: value
            )
    }
}

// MARK: - Models - Generic States and Models
extension GenericStateModel_EnabledFocused {
    @available(*, unavailable, message: "Use init without 'pressed' value")
    public init(
        enabled: Value,
        pressed: Value,
        focused: Value
    ) {
        fatalError()
    }
}

extension GenericStateModel_EnabledLoading {
    @available(*, unavailable, message: "Use init without 'pressed' value")
    public init(
        enabled: Value,
        pressed: Value,
        loading: Value
    ) {
        fatalError()
    }
}

extension GenericStateModel_DeselectedSelectedPressed {
    @available(*, deprecated, message: "Use init with two pressed parameters")
    public init(
        deselected: Value,
        selected: Value,
        pressed: Value
    ) {
        self.deselected = deselected
        self.selected = selected
        self.pressedDeselected = pressed
        self.pressedSelected = pressed
    }
}

extension GenericStateModel_DeselectedSelectedPressedDisabled {
    @available(*, deprecated, message: "Use init with two pressed parameters")
    public init(
        deselected: Value,
        selected: Value,
        pressed: Value,
        disabled: Value
    ) {
        self.deselected = deselected
        self.selected = selected
        self.pressedDeselected = pressed
        self.pressedSelected = pressed
        self.disabled = disabled
    }
}

extension GenericStateModel_OffOnIndeterminatePressed {
    @available(*, deprecated, message: "Use init with two pressed parameters")
    public init(
        off: Value,
        on: Value,
        indeterminate: Value,
        pressed: Value
    ) {
        self.off = off
        self.on = on
        self.indeterminate = indeterminate
        self.pressedOff = pressed
        self.pressedOn = pressed
        self.pressedIndeterminate = pressed
    }
}

extension GenericStateModel_OffOnIndeterminatePressedDisabled {
    @available(*, deprecated, message: "Use init with two pressed parameters")
    public init(
        off: Value,
        on: Value,
        indeterminate: Value,
        pressed: Value,
        disabled: Value
    ) {
        self.off = off
        self.on = on
        self.indeterminate = indeterminate
        self.pressedOff = pressed
        self.pressedOn = pressed
        self.pressedIndeterminate = pressed
        self.disabled = disabled
    }
}

extension GenericStateModel_OffOnPressed {
    @available(*, deprecated, message: "Use init with two pressed parameters")
    public init(
        off: Value,
        on: Value,
        pressed: Value
    ) {
        self.off = off
        self.on = on
        self.pressedOff = pressed
        self.pressedOn = pressed
    }
}

extension GenericStateModel_OffOnPressedDisabled {
    @available(*, deprecated, message: "Use init with two pressed parameters")
    public init(
        off: Value,
        on: Value,
        pressed: Value,
        disabled: Value
    ) {
        self.off = off
        self.on = on
        self.pressedOff = pressed
        self.pressedOn = pressed
        self.disabled = disabled
    }
}

// MARK: - Extensions - SwiftUI
#if canImport(UIKit) && !os(watchOS)

import SwiftUI

@available(*, deprecated, renamed: "OverridableUIHostingControllerBehavior")
public typealias OverridenUIHostingControllerBehavior = OverridableUIHostingControllerBehavior

#endif

extension View {
    @available(*, deprecated, message: "Use method without 'Bool' parameter")
    public func onFirstAppear(
        _ didAppearForTheFirstTime: Binding<Bool>,
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

// MARK: - Extensions - UIKit
#if canImport(UIKit) && !os(watchOS)

import UIKit

extension UIApplication {
    @available(*, deprecated, message: "Use method with 'activationStates' parameter")
    public func firstWindow(
        where predicate: (UIWindow) throws -> Bool
    ) rethrows -> UIWindow? {
        try firstWindow(
            activationStates: [.foregroundActive],
            where: predicate
        )
    }
}

#endif

// MARK: - Debugging
@available(*, unavailable, message: "Use method without 'module' parameter")
public func VCoreLogWarning(
    _ message: String,
    module: String,
    file: String = #file,
    line: UInt = #line,
    function: String = #function
) {}

@available(*, unavailable, message: "Use method without 'module' parameter")
public func VCoreLogError(
    _ items: Any...,
    module: String,
    file: String = #file,
    line: UInt = #line,
    function: String = #function
) {}

@available(*, deprecated, message: "Use logging methods with 'fatalError'")
public func VCoreFatalError(
    _ items: Any...,
    fileID: String = #fileID,
    file: String = #file,
    line: UInt = #line,
    function: String = #function
) -> Never {
    VCoreLogError(items, fileID: fileID, file: file, line: line, function: function)
    fatalError()
}
