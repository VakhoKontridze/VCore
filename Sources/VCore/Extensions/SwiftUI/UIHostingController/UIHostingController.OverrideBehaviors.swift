//
//  UIHostingController.OverrideBehaviors.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 21.10.23.
//

// https://github.com/scenee/FloatingPanel/issues/454
// https://defagos.github.io/swiftui_collection_part3
// https://steipete.com/posts/disabling-keyboard-avoidance-in-swiftui-uihostingcontroller

#if canImport(UIKit) && !os(watchOS)

import SwiftUI

// MARK: - Overriden UI Hosting Controller Behavior
/// `UIHostingController` behavior overriding option.
public struct OverridenUIHostingControllerBehavior: OptionSet {
    // MARK: Options
    /// Disables safe area insets.
    public static let disableSafeAreaInsets: Self = .init(rawValue: 1 << 0)

    /// Disables keyboard responsiveness.
    public static let disableKeyboardAvoidance: Self = .init(rawValue: 1 << 1)

    // MARK: Properties
    public let rawValue: Int

    // MARK: Initializers
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

// MARK: - Hosting Controller Override Behavior
extension UIHostingController {
    /// Overrides default `UIHostingController` behaviors, indicated by `OverridenUIHostingControllerBehavior`.
    ///
    ///     let hostingController: UIHostingController = ...
    ///     hostingController.overrideBehaviors([.disableSafeAreaInsets, .disableKeyboardAvoidance])
    ///
    @discardableResult public func overrideBehaviors(
        _ behaviors: OverridenUIHostingControllerBehavior
    ) -> Bool {
        guard let viewClass: AnyClass = object_getClass(view) else { return false }
        let viewSubclassName: String = String(cString: class_getName(viewClass)).appending("_OverridenBehaviors")

        if let viewSubclass: AnyClass = NSClassFromString(viewSubclassName) {
            object_setClass(view, viewSubclass)
            return true
        }

        if
            let viewSubclassNameUtf8: UnsafePointer<CChar> = (viewSubclassName as NSString).utf8String,
            let viewSubclass: AnyClass = objc_allocateClassPair(viewClass, viewSubclassNameUtf8, 0)
        {
            if
                behaviors.contains(.disableSafeAreaInsets),
                let method: Method = class_getInstanceMethod(UIView.self, #selector(getter: UIView.safeAreaInsets))
            {
                let block: @convention(block) (AnyObject) -> UIEdgeInsets = { _ in .zero }

                class_addMethod(
                    viewSubclass,
                    #selector(getter: UIView.safeAreaInsets),
                    imp_implementationWithBlock(block),
                    method_getTypeEncoding(method)
                )
            }

            if
                behaviors.contains(.disableKeyboardAvoidance),
                let method: Method = class_getInstanceMethod(viewClass, NSSelectorFromString("keyboardWillShowWithNotification:"))
            {
                let block: @convention(block) (AnyObject, AnyObject) -> Void = { (_, _) in }

                class_addMethod(
                    viewSubclass,
                    NSSelectorFromString("keyboardWillShowWithNotification:"),
                    imp_implementationWithBlock(block),
                    method_getTypeEncoding(method)
                )
            }

            objc_registerClassPair(viewSubclass)
            object_setClass(view, viewSubclass)

            return true
        }

        return false
    }
}

#endif
