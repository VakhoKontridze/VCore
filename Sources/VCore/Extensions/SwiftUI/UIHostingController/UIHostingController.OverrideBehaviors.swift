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

// MARK: - Overridable UI Hosting Controller Behavior
/// `UIHostingController` behavior overriding option.
@OptionSetRepresentation<Int>(accessLevelModifier: "public")
public struct OverridableUIHostingControllerBehavior {
    private enum Options: Int {
        case disablesSafeAreaInsets
        case disablesKeyboardAvoidance
    }
}

// MARK: - Hosting Controller Override Behavior
extension UIHostingController {
    /// Overrides default `UIHostingController` behaviors, indicated by `OverridableUIHostingControllerBehavior`.
    ///
    ///     let hostingController: UIHostingController = ...
    ///     hostingController.overrideBehaviors([.disablesSafeAreaInsets, .disablesKeyboardAvoidance])
    ///
    @discardableResult 
    public func overrideBehaviors(
        _ behaviors: OverridableUIHostingControllerBehavior
    ) -> Bool {
        guard !behaviors.isEmpty else { return false }

        guard let viewClass: AnyClass = object_getClass(view) else {
            VCoreLogError("Couldn't retrieve class type when overriding behaviors in 'UIHostingController'")
            return false
        }

        let viewSubclassName: String = String(cString: class_getName(viewClass)).appending("_OverridenBehaviors")

        if let viewSubclass: AnyClass = NSClassFromString(viewSubclassName) {
            object_setClass(view, viewSubclass)
            return true
        }

        guard
            let viewSubclassNameUTF8: UnsafePointer<CChar> = (viewSubclassName as NSString).utf8String,
            let viewSubclass: AnyClass = objc_allocateClassPair(viewClass, viewSubclassNameUTF8, 0)
        else {
            VCoreLogError("Couldn't retrieve class name when overriding behaviors in 'UIHostingController'")
            return false
        }

        if behaviors.contains(.disablesSafeAreaInsets) {
            overrideDisablesSafeAreaInsets(viewSubclass: viewSubclass)
        }

        if behaviors.contains(.disablesKeyboardAvoidance) {
            overrideDisabledKeyboardAvoidance(viewClass: viewClass, viewSubclass: viewSubclass)
        }

        objc_registerClassPair(viewSubclass)
        object_setClass(view, viewSubclass)

        return true
    }

    private func overrideDisablesSafeAreaInsets(
        viewSubclass: AnyClass
    ) {
        let selector: Selector = #selector(getter: UIView.safeAreaInsets)

        guard let method: Method = class_getInstanceMethod(UIView.self, selector) else {
            VCoreLogError("Couldn't retrieve 'UIView.safeAreaInsets' when overriding 'disablesSafeAreaInsets' in 'UIHostingController'")
            return
        }

        let block: @convention(block) (AnyObject) -> UIEdgeInsets = { _ in .zero }

        class_addMethod(
            viewSubclass,
            selector,
            imp_implementationWithBlock(block),
            method_getTypeEncoding(method)
        )
    }

    private func overrideDisabledKeyboardAvoidance(
        viewClass: AnyClass,
        viewSubclass: AnyClass
    ) {
        let selector: Selector = NSSelectorFromString("keyboardWillShowWithNotification:")

        guard let method: Method = class_getInstanceMethod(viewClass, selector) else {
            VCoreLogError("Couldn't retrieve 'UIView.keyboardWillShowNotification' when overriding 'disablesKeyboardAvoidance' in 'UIHostingController'")
            return
        }

        let block: @convention(block) (AnyObject, AnyObject) -> Void = { (_, _) in }

        class_addMethod(
            viewSubclass,
            selector,
            imp_implementationWithBlock(block),
            method_getTypeEncoding(method)
        )
    }
}

#endif
