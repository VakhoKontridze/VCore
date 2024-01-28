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
    private let allowsHitTests: Bool
    
    // MARK: Initializers
    init(allowsHitTests: Bool) {
        self.allowsHitTests = allowsHitTests
    }
    
    // MARK: View Controller Animated Transitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let transitionView: UIView = transitionContext.containerView
        transitionView.backgroundColor = .clear
        transitionView.isUserInteractionEnabled = allowsHitTests

        guard let presentedViewController: UIViewController = transitionContext.viewController(forKey: .to) else { return }

        transitionView.addSubview(presentedViewController.view)

        presentedViewController.view.frame = transitionView.frame

        transitionContext.completeTransition(true)
    }
}

#endif
