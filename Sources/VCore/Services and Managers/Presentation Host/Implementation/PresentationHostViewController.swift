//
//  PresentationHostViewController.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 4/14/22.
//

#if canImport(UIKit) && !os(watchOS)

import SwiftUI

// MARK: - Presentation Host View Controller
@available(tvOS, unavailable)
@available(visionOS, unavailable)
final class PresentationHostViewController: UIViewController, UIViewControllerTransitioningDelegate {
    // MARK: Subviews
    private var hostingControllerContainer: PresentationHostHostingViewControllerContainerViewController?

    // MARK: Properties
    private let id: String
    private let uiModel: PresentationHostUIModel

    var isPresentingViewController: Bool { hostingControllerContainer != nil }

    private var failedToPresentDueToNoWindow: Bool = false

    // MARK: Initializers
    init(
        id: String,
        uiModel: PresentationHostUIModel
    ) {
        self.id = id
        self.uiModel = uiModel
        
        super.init(nibName: nil, bundle: nil)

        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: Lifecycle
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)

        // Just in case `isPresented` was set to `true` during `State` initialization
        presentFailedViewControllerIfNeeded()
    }

    // MARK: Setup
    private func setUp() {
        view.backgroundColor = .clear
    }

    // MARK: View Controller Transitioning Delegate
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        PresentationHostAnimatedTransitioner(
            allowsHitTests: uiModel.allowsHitTests
        )
    }
    
    // MARK: Presentation - Present
    func presentHostedView(_ content: AnyView) {
        let hostingControllerContainer: PresentationHostHostingViewControllerContainerViewController = .init(
            uiModel: uiModel,
            content: content
        )
        self.hostingControllerContainer = hostingControllerContainer

        hostingControllerContainer.modalPresentationStyle = .overFullScreen
        hostingControllerContainer.modalTransitionStyle = .crossDissolve
        hostingControllerContainer.transitioningDelegate = self

        _presentHostingControllerContainer(hostingControllerContainer)
    }

    @discardableResult
    private func _presentHostingControllerContainer(_ viewController: PresentationHostHostingViewControllerContainerViewController) -> Bool {
        guard
            view.window != nil
        else {
            failedToPresentDueToNoWindow = true
            return false
        }

        if let presentedViewController {
            VCoreLogWarning("Attempting to present modal '\(id)', which is already presenting '\(presentedViewController.debugDescription)'")
            return false
        }

        present(viewController, animated: true, completion: nil)

        PresentationHostViewControllerStorage.shared.storage[id] = self

        return true
    }

    private func presentFailedViewControllerIfNeeded() {
        guard failedToPresentDueToNoWindow else {
            return
        }

        guard let hostingControllerContainer else {
            failedToPresentDueToNoWindow = false
            return
        }

        let flag: Bool = _presentHostingControllerContainer(hostingControllerContainer)
        if flag { failedToPresentDueToNoWindow = false }
    }

    // MARK: Presentation - Update
    func updateHostedView(with content: AnyView) {
        hostingControllerContainer?.hostingController.rootView = content
    }

    // MARK: Presentation - Dismiss
    func dismissHostedView(completion: (() -> Void)? = nil) {
        _dismissHostedView(force: false, completion: completion)
    }
    
    static func forceDismissHostedView(id: String) {
        guard
            let viewController: PresentationHostViewController = PresentationHostViewControllerStorage.shared.storage[id]
        else {
            return
        }

        viewController._dismissHostedView(force: true, completion: nil)
    }
    
    private func _dismissHostedView(force: Bool, completion: (() -> Void)?) {
        let tearDown: () -> Void = { [weak self] in
            guard let self else { return }

            hostingControllerContainer = nil
            _ = PresentationHostViewControllerStorage.shared.storage.removeValue(forKey: id)

            PresentationHostDataSourceCache.shared.remove(key: id)
        }

        if force {
            if
                let rootViewController: UIViewController = UIApplication.shared
                    .firstWindow(
                        activationStates: [.foregroundActive],
                        where: { $0.rootViewController?.presentedViewController == hostingControllerContainer }
                    )?
                    .rootViewController
            {
                rootViewController.dismiss(animated: false, completion: {
                    tearDown()
                    completion?()
                })
            }
            
        } else {
            dismiss(animated: false, completion: {
                tearDown()
                completion?()
            })
        }
    }
}

#endif
