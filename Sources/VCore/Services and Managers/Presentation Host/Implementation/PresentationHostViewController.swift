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

    var isPresentingView: Bool { hostingControllerContainer != nil }

    private var failedToPresentDueToAlreadyPresentingViewController: Bool = false
    private var dismissNotificationName: Notification.Name { .init(rawValue: "PresentationHostViewController.DidDismissViewController") }
    
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

        presentQueuedViewController() // Just in case `isPresented` was set to `true` during `State` initialization
    }

    // MARK: Setup
    private func setUp() {
        view.backgroundColor = nil

        addObserversForQueueing()
    }

    // MARK: Presentation
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: { [weak self] in
            guard let self else { return }

            postDidDismissNotificationForQueueing()
            completion?()
        })
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
    
    // MARK: Presentation API - Present
    func presentHostedView(_ content: AnyView) {
        let hostingControllerContainer: PresentationHostHostingViewControllerContainerViewController = .init(
            uiModel: uiModel,
            content: content
        )
        self.hostingControllerContainer = hostingControllerContainer

        hostingControllerContainer.modalPresentationStyle = .overFullScreen
        hostingControllerContainer.modalTransitionStyle = .crossDissolve
        hostingControllerContainer.transitioningDelegate = self

        _present(hostingControllerContainer)
    }

    @discardableResult
    private func _present(_ viewController: UIViewController) -> Bool {
        guard
            view.window != nil,
            presentedViewController == nil
        else {
            failedToPresentDueToAlreadyPresentingViewController = true

            return false
        }

        present(viewController, animated: true, completion: nil)

        PresentationHostViewControllerStorage.shared.storage[id] = self

        return true
    }

    // MARK: Presentation API - Update
    func updateHostedView(with content: AnyView) {
        hostingControllerContainer?.hostingController.rootView = content
    }

    // MARK: Presentation API - Dismiss
    func dismissHostedView(completion: (() -> Void)? = nil) {
        _dismissHostedView(force: false, completion: completion)
    }
    
    static func forceDismiss(id: String) {
        PresentationHostViewControllerStorage.shared.storage[id]?._dismissHostedView(force: true, completion: nil)
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

    // MARK: Queueing
    private func presentQueuedViewController() {
        guard failedToPresentDueToAlreadyPresentingViewController else {
            return
        }

        guard let hostingControllerContainer else {
            failedToPresentDueToAlreadyPresentingViewController = false
            return
        }

        let flag: Bool = _present(hostingControllerContainer)
        if flag { failedToPresentDueToAlreadyPresentingViewController = false }
    }

    private func addObserversForQueueing() {
        NotificationCenter.default.addObserver(
            forName: dismissNotificationName,
            object: nil,
            queue: .main,
            using: { [weak self] _ in self?.presentQueuedViewController() }
        )
    }

    private func postDidDismissNotificationForQueueing() {
        NotificationCenter.default.post(
            name: dismissNotificationName,
            object: nil,
            userInfo: nil
        )
    }
}

#endif
