//
//  Deprecations.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import Foundation

// MARK: - Multipart Form Data Builder
extension MultipartFormDataBuilder {
    @available(*, unavailable, message: "Use empty init with new `build` method")
    public init(
        json: [String: Any?],
        files: [String: (some AnyMultipartFormDataFile)?]
    ) {
        fatalError()
    }
    
    @available(*, unavailable, message: "Use build method that takes parameters")
    public func build() -> (String, Data) {
        fatalError()
    }
}

@available(*, deprecated, renamed: "MultipartFormDataAuthorizedRequestHeaders")
public typealias MultiPartFormDataAuthorizedRequestHeaders = MultipartFormDataAuthorizedRequestHeaders

@available(*, deprecated, renamed: "MultipartFormDataRequestHeaders")
public typealias MultiPartFormDataRequestHeaders = MultipartFormDataRequestHeaders

@available(*, deprecated, renamed: "MultipartFormDataBuilder")
public typealias MultiPartFormDataBuilder = MultipartFormDataBuilder

@available(*, deprecated, renamed: "AnyMultipartFormDataFile")
public typealias AnyMultiPartFormDataFile = AnyMultipartFormDataFile

@available(*, deprecated, renamed: "MultipartFormDataFile")
public typealias MultiPartFormDataFile = MultipartFormDataFile

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

// MARK: - H Or VStack
@available(*, deprecated, renamed: "HVStack")
public typealias HOrVStack = HVStack

// MARK: - Architectural Pattern Helpers
import SwiftUI

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension ProgressViewParameters {
    @available(*, deprecated, message: "Use init without default value for `isInteractionDisabled`")
    public init(
        isInteractionDisabled: Bool,
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
        isInteractionDisabled: Bool,
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
        isInteractionDisabled: Bool,
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

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension ProgressViewParameters {
    @available(*, deprecated, renamed: "isInteractionEnabled")
    public var isInteractionDisabled: Bool {
        get { !isInteractionEnabled }
        set { isInteractionEnabled = !newValue }
    }
    
    @available(*, deprecated, message: "Use `init` with `isInteractionEnabled` instead")
    public init(
        scalingFactor: CGFloat? = nil,
        color: Color? = nil,
        isInteractionDisabled: Bool
    ) {
        self.scalingFactor = scalingFactor
        self.color = color
        self.isInteractionEnabled = !isInteractionDisabled
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension AlertButton {
    @available(*, deprecated, message: "Use `init` with different parameter order")
    public init(
        role: ButtonRole? = nil,
        title: String,
        action: (() -> Void)?
    ) {
        self.init(
            role: role,
            action: action,
            title: title
        )
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension ConfirmationDialogButton {
    @available(*, deprecated, message: "Use `init` with different parameter order")
    public init(
        role: ButtonRole? = nil,
        title: String,
        action: (() -> Void)?
    ) {
        self.init(
            role: role,
            action: action,
            title: title
        )
    }
}

// MARK: - Base Button
@available(*, deprecated, renamed: "GestureBaseButtonGestureState")
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public typealias BaseButtonGestureState = GestureBaseButtonGestureState

#if os(iOS)

extension GestureBaseButtonGestureState {
    @available(*, deprecated, renamed: "cancelled")
    public static var `none`: Self { .cancelled }
    
    @available(*, deprecated, renamed: "began")
    public static var press: Self { .began }
    
    @available(*, deprecated, renamed: "ended")
    public static var click: Self { .ended }
}

extension UIKitBaseButton {
    @available(*, deprecated, renamed: "stateChangeHandler")
    public var gestureHandler: (GestureBaseButtonGestureState) -> Void {
        get { stateChangeHandler }
        set { stateChangeHandler = newValue }
    }
    
    @available(*, deprecated, message: "Use `init` with `onStateChange` parameter")
    public convenience init(
        gesture gestureHandler: @escaping (GestureBaseButtonGestureState) -> Void
    ) {
        self.init(onStateChange: gestureHandler)
    }
}

extension SwiftUIGestureBaseButton {
    @available(*, deprecated, message: "Use `init` with `onStateChange` parameter")
    public init(
        gesture gestureHandler: @escaping (GestureBaseButtonGestureState) -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.init(onStateChange: gestureHandler, label: label)
    }
}

#endif

#if os(iOS) || os(macOS)

extension SwiftUIBaseButton {
    @available(*, unavailable, message: "This `init` is now defined under `SwiftUIGestureBaseButton`")
    public init(
        onStateChange stateChangeHandler: @escaping (GestureBaseButtonGestureState) -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        fatalError()
    }
}

#endif

// MARK: - Global Functions
@available(*, deprecated, renamed: "VCoreLogError")
public func VCoreLog(
    _ items: Any...,
    file: String = #file,
    line: Int = #line,
    function: String = #function
) {
    VCoreLogError(
        items,
        file: file,
        line: line,
        function: function
    )
}

// MARK: - Extensions - Foundation
extension FloatingPoint {
    @available(*, unavailable, message: "Half-open ranges are only available for `BinaryInteger`s")
    public func clamped(
        to range: Range<Self>,
        step: Self? = nil
    ) -> Self {
        fatalError()
    }
    
    @available(*, unavailable, message: "Half-open ranges are only available for `BinaryInteger`s")
    mutating public func clamp(
        to range: Range<Self>,
        step: Self? = nil
    ) {
        fatalError()
    }
}

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

extension Array where Element == String {
    @available(*, unavailable, message: "Removed due to ambiguous API")
    public func compactMapNonEmpty(_ transform: (String) throws -> String?) rethrows -> [String] {
        try compactMap { element in
            guard
                !element.isEmpty,
                let transformedElement: String = try transform(element),
                !transformedElement.isEmpty
            else {
                return nil
            }
            
            return transformedElement
        }
    }
}

extension Array where Element == Optional<String> {
    @available(*, unavailable, message: "Removed due to ambiguous API")
    public func compactMapNonNilNonEmpty(_ transform: (String) throws -> String?) rethrows -> [String] {
        try compactMap { element in
            guard
                let element,
                !element.isEmpty,
                let transformedElement: String = try transform(element),
                !transformedElement.isEmpty
            else {
                return nil
            }
            
            return transformedElement
        }
    }
}

// MARK: - Extensions Core Frameworks
extension CGSize {
    @available(*, deprecated, renamed: "withReversedDimensions(_:)")
    public func withReversedDimensions(if condition: Bool) -> Self {
        withReversedDimensions(condition)
    }
}

// MARK: - Extensions UIKit
#if canImport(UIKit)

import UIKit

extension UIImage {
    @available(*, deprecated, renamed: "jpegCompressed")
    public func compressed(quality: CGFloat) -> UIImage? {
        jpegCompressed(quality: quality)
    }
}

#endif

#if canImport(UIKit) && !os(watchOS)

extension UIApplication {
    @available(*, deprecated, renamed: "firstWindowInSingleSceneApp")
    public var rootWindow: UIWindow? {
        if #available(iOS 15, tvOS 15, *) {
            return connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .compactMap { $0.keyWindow ?? $0.windows.first }
                .first
            
        } else {
            return connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .first { $0 is UIWindowScene }
                .flatMap { $0 as? UIWindowScene }?
                .windows
                .first { $0.isKeyWindow }
        }
    }
    
    @available(*, deprecated, message: "Use `firstWindowInSingleSceneApp?.rootViewController` instead")
    public var rootViewController: UIViewController? {
        rootWindow?.rootViewController
    }
    
    @available(*, deprecated, message: "Use `firstWindowInSingleSceneApp?.rootViewController?.view` instead")
    public var rootView: UIView? {
        rootViewController?.view
    }
}

extension UIApplication {
    @available(*, deprecated, renamed: "keyActiveWindowInSingleSceneApp")
    public var activeWindow: UIWindow? {
        connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first { $0 is UIWindowScene }
            .flatMap { $0 as? UIWindowScene }?
            .windows
            .first { $0.isKeyWindow }
    }
    
    @available(*, deprecated, message: "Use `keyActiveWindowInSingleSceneApp?.rootViewController` instead")
    public var activeViewController: UIViewController? {
        activeWindow?.rootViewController
    }
    
    @available(*, deprecated, message: "Use `keyActiveWindowInSingleSceneApp?.rootViewController?.view` instead")
    public var activeView: UIView? {
        activeViewController?.view
    }
}

extension UIApplication {
    @available(*, deprecated, message: "Use method with `UIWindow` parameter instead")
    public var topMostViewController: UIViewController? {
        guard
            let activeWindow,
            var topMostViewController: UIViewController = activeWindow.rootViewController
        else {
            return nil
        }
        
        while let presentedViewController = topMostViewController.presentedViewController {
            topMostViewController = presentedViewController
        }
        
        return topMostViewController
    }
    
    @available(*, deprecated, message: "Use `topMostViewController(inWindow:)?.view` instead")
    public var topMostView: UIView? {
        topMostViewController?.view
    }
}

#endif

// MARK: - Extensions - SwiftUI
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

extension View {
    @available(*, deprecated, renamed: "onSizeChange(perform:)")
    public func readSize(
        onChange completion: @escaping (CGSize) -> Void
    ) -> some View {
        self
            .onSizeChange(perform: completion)
    }
}

//#if canImport(UIKit)
//
//extension View {
//    @available(*, deprecated, message: "Use method with `uiCorners` parameter)")
//    public func cornerRadius(
//        _ radius: CGFloat,
//        corners: UIRectCorner
//    ) -> some View {
//        self
//            .cornerRadius(radius, uiCorners: corners)
//    }
//}
//
//#endif

// MARK: - V Core Localization Manager
@available(*, deprecated, renamed: "VCoreLocalizationManager")
public typealias VCoreLocalizationService = VCoreLocalizationManager
