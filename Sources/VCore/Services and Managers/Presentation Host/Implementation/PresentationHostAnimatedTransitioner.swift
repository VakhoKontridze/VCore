//
//  PresentationHostAnimatedTransitioner.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.03.23.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Presentation Host Animated Transitioner
@available(tvOS, unavailable)
@available(visionOS, unavailable)
final class PresentationHostAnimatedTransitioner: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: Properties
    private let id: String
    private let interactionType: PresentationHostUIModel.InteractionType

    // MARK: Initializers
    init(
        id: String,
        interactionType: PresentationHostUIModel.InteractionType
    ) {
        self.id = id
        self.interactionType = interactionType
    }

    // MARK: View Controller Animated Transitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let transitionView: UIView = transitionContext.containerView

        transitionContext.containerView.backgroundColor = .clear

        switch interactionType {
        case .allowsHitTests:
            break

        case .isPassthrough:
            guard transitionView.isUITransitionView else {
                VCoreLogError("Couldn't find `UITransitionView` in view hierarchy")
                break
            }

            transitionContext.containerView.isUserInteractionEnabled = false

        case .allowsPartialHitTests:
            enablePartialHitTests(
                id: id,
                transitionView: transitionView
            )
        }

        guard let presentedViewController: UIViewController = transitionContext.viewController(forKey: .to) else { return }

        transitionContext.containerView.addSubview(presentedViewController.view)

        presentedViewController.view.frame = transitionContext.containerView.frame

        transitionContext.completeTransition(true)
    }

    // MARK: Interaction
    private func enablePartialHitTests(
        id: String,
        transitionView: UIView
    ) {
        TODO()

        // 1. Overrides all

//        guard
//            transitionView.isUITransitionView,
//            let transitionViewClass: AnyClass = NSClassFromString("UITransitionView")
//        else {
//            VCoreLogError("Couldn't find `UITransitionView` in view hierarchy")
//            return
//        }
//
//        let selector: Selector = #selector(UIView.hitTest(_:with:))
//
//        guard
//            let method: Method = class_getInstanceMethod(transitionViewClass, selector)
//        else {
//            VCoreLogError("Couldn't retrieve 'UIView.hitTest(_:with:)' when configuring Presentation Host '\(id)' with 'allowsPartialHitTests' interaction type")
//            return
//        }
//
//        let originalImplementation: IMP = method_getImplementation(method) // Needs to be stored
//
//        let block: @convention(block) (Any, CGPoint, UIEvent?) -> UIView? = { _self, point, event in
//            let originalBlock = unsafeBitCast(
//                originalImplementation,
//                to: (@convention(c) (Any, Selector, CGPoint, UIEvent?) -> UIView?).self
//            )
//
//            let originalResult: UIView? = originalBlock(_self, selector, point, event)
//
//            if let frame: CGRect = PresentationHostInteractiveViewFrameStorage.shared.get(key: id) {
//                if frame.contains(point) {
//                    print("1")
//                    return originalResult
//                } else {
//                    print("2")
//                    return nil
//                }
//            } else {
//                print("3")
//                return originalResult
//            }
//        }
//
//        method_setImplementation(
//            method,
//            imp_implementationWithBlock(block)
//        )

        // 2. Cases crash because of override: 'UIViewControllerBuiltinTransitionViewAnimator can only operate on a container view of type UITransitionView.'

//        guard
//            transitionView.isUITransitionView,
//            let transitionViewClass: AnyClass = NSClassFromString("UITransitionView")
//        else {
//            VCoreLogError("Couldn't find `UITransitionView` in view hierarchy")
//            return
//        }
//        
//        let transitionViewSubclassName: String = String(cString: class_getName(transitionViewClass)).appending("_PartialHitTestsEnabled")
//
//        if let transitionViewSubclass: AnyClass = NSClassFromString(transitionViewSubclassName) {
//            object_setClass(transitionView, transitionViewSubclass)
//            VCoreLogError("???")
//            return
//        }
//
//        guard
//            let transitionViewSubclassNameUtf8: UnsafePointer<CChar> = (transitionViewSubclassName as NSString).utf8String,
//            let transitionViewSubclass: AnyClass = objc_allocateClassPair(transitionViewClass, transitionViewSubclassNameUtf8, 0)
//        else {
//            VCoreLogError("???")
//            return
//        }
//
//        do {
//            let selector: Selector = #selector(UIView.hitTest(_:with:))
//
//            guard
//                let method: Method = class_getInstanceMethod(transitionViewClass, selector)
//            else {
//                VCoreLogError("Couldn't retrieve 'UIView.hitTest(_:with:)' when configuring Presentation Host '\(id)' with 'allowsPartialHitTests' interaction type")
//                return
//            }
//
//            let originalImplementation: IMP = method_getImplementation(method) // Needs to be stored
//
//            let block: @convention(block) (Any, CGPoint, UIEvent?) -> UIView? = { _self, point, event in
//                let originalBlock = unsafeBitCast(
//                    originalImplementation,
//                    to: (@convention(c) (Any, Selector, CGPoint, UIEvent?) -> UIView?).self
//                )
//
//                let originalResult: UIView? = originalBlock(_self, selector, point, event)
//
//                if let frame: CGRect = PresentationHostInteractiveViewFrameStorage.shared.get(key: id) {
//                    if frame.contains(point) {
//                        print("1")
//                        return originalResult
//                    } else {
//                        print("2")
//                        return nil
//                    }
//                } else {
//                    print("3")
//                    return originalResult
//                }
//            }
//
//            class_addMethod(
//                transitionViewSubclass,
//                selector,
//                imp_implementationWithBlock(block),
//                method_getTypeEncoding(method)
//            )
//        }
//
//        objc_registerClassPair(transitionViewSubclass)
//        object_setClass(transitionView, transitionViewSubclass)
//    }
}

#endif
