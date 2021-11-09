//
//  Deprecations.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import UIKit

// MARK: - Session Manager
@available(*, deprecated, renamed: "SessionManager")
public typealias NetworkSessionManager = SessionManager

// MARK: - Network Service
extension NetworkService {
    @available(*, deprecated, renamed: "default")
    public static var shared: NetworkService { .default }
}

extension NetworkURLParametersRequestMethodService {
    @available(*, deprecated, renamed: "json")
    public func jsonArray<Parameters: Encodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: Parameters,
        completion: @escaping (Result<[String: Any], Error>) -> Void
    ) {
        json(
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion
        )
    }
    
    @available(*, deprecated, renamed: "jsonArray")
    public func json<Parameters: Encodable>(
        endpoint: String,
        headers: [String: Any],
        parameters: Parameters,
        completion: @escaping (Result<[[String: Any]], Error>) -> Void
    ) {
        jsonArray(
            endpoint: endpoint,
            headers: headers,
            parameters: parameters,
            completion: completion
        )
    }
}

// MARK: - VIPER Helpers
@available(*, deprecated, renamed: "StandardNavigable")
public typealias StandardNavigatable = StandardNavigable

// MARK: - UILabel Extensions
extension UILabel {
    @available(*, deprecated, renamed: "singleLineHeight")
    public var singleLineNaturalHeightConstant: CGFloat { singleLineHeight }
}

// MARK: - UITableView Extensions
extension UITableView {
    @available(*, deprecated, message: "Has no effect")
    /// Removes extra separators by inserting a `tableFooterView` of height `0`.
    public func removeExtraSeparators() {
        insertEmptyFooterView(height: 0)
    }
    
    @available(*, deprecated, message: "Has no effect")
    /// Removes extra separators, as well as separator from last cell, by inserting a `tableFooterView` of height `0.1`.
    public func removeExtraAndLastSeparators() {
        insertEmptyFooterView(height: 0.1)
    }
    
    @available(*, deprecated, message: "Has no effect")
    private func insertEmptyFooterView(height: CGFloat) {
        tableFooterView = .init(frame: .init(
            origin: .zero,
            size: .init(width: frame.size.width, height: height)
        ))
    }
}

// MARK: - UIImage Extensions
extension UIImage {
    @available(*, deprecated, message: "Use method without opaque parameter")
    /// Scales `UIImage` to specified height.
    public func scaled(
        toHeight newHeight: CGFloat,
        opaque: Bool = false
    ) -> UIImage? {
        let newSize: CGSize = .init(
            width: size.width * (newHeight / size.height),
            height: newHeight
        )
        
        UIGraphicsBeginImageContextWithOptions(newSize, opaque, scale)
        defer { UIGraphicsEndImageContext() }
        
        draw(in: .init(origin: .zero, size: newSize))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    @available(*, deprecated, message: "Use method without opaque parameter")
    /// Scales `UIImage` to specified width.
    public func scaled(
        toWidth newWidth: CGFloat,
        opaque: Bool = false
    ) -> UIImage? {
        let newSize: CGSize = .init(
            width: newWidth,
            height: size.height * (newWidth / size.width)
        )
        
        UIGraphicsBeginImageContextWithOptions(newSize, opaque, scale)
        defer { UIGraphicsEndImageContext() }
        
        draw(in: .init(origin: .zero, size: newSize))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

// MARK: - UIScreen Exensions
extension UIScreen {
    @available(*, deprecated, message: "Refer to file `UIApplication.AppRootWindow` under `Extra`")
    /// Root view of the app.
    ///
    /// - Root View Controller must be loaded on screen for this property to return a non-`nil` value.
    public static var rootView: UIView? {
        guard
            let window: UIWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
            let viewController: UIViewController = window.rootViewController
        else {
            return nil
        }
        
        switch viewController {
        case let tabBarController as UITabBarController: return tabBarController.view
        case let navigationController as UINavigationController: return navigationController.view
        case let viewController: return viewController.view
        }
    }
}

extension UIScreen {
    @available(*, deprecated, message: "Property has been deprecated")
    /// Object containing information about screen's safe area edge insets.
    ///
    /// - Root View Controller must be loaded on screen for this property to return a non-`nil` value.
    public static var safeAreaInsets: UIEdgeInsets? {
        rootView?.safeAreaInsets
    }
}
