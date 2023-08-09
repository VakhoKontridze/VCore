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
        guard let presentedVC: UIViewController = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(presentedVC.view)
        presentedVC.view.frame = transitionContext.containerView.frame
        
        transitionContext.containerView.backgroundColor = .clear
        transitionContext.containerView.isUserInteractionEnabled = allowsHitTests
        
        transitionContext.completeTransition(true)
    }
}

#endif
