//
//  _PresentationHostViewController.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 4/14/22.
//

#if canImport(UIKit) && !os(watchOS)

import SwiftUI

// MARK: - _ Presentation Host View Controller
@available(tvOS, unavailable)
final class _PresentationHostViewController: UIViewController, UIViewControllerTransitioningDelegate {
    // MARK: Properties
    private let id: String
    private let allowsHitTests: Bool

    typealias HostingViewControllerType = UIHostingController<AnyView>
    private var hostingController: HostingViewControllerType?
    
    var isPresentingView: Bool { hostingController != nil }

    private var failedToPresentDueToAlreadyPresentingViewController: Bool = false
    private var dismissNotificationName: Notification.Name { .init(rawValue: "_PresentationHostViewController.DidDismissViewController") }
    
    // MARK: Initializers
    init(
        id: String,
        allowsHitTests: Bool
    ) {
        self.id = id
        self.allowsHitTests = allowsHitTests
        
        super.init(nibName: nil, bundle: nil)

        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: Setup
    private func setUp() {
        addObserversForQueueing()
    }

    // MARK: Presentation
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: { [weak self] in
            guard let self else { return }

            postDidDismissNotificationForQueueing()
        })
    }

    // MARK: View Controller Transitioning Delegate
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        PresentationHostAnimatedTransitioner(allowsHitTests: allowsHitTests)
    }
    
    // MARK: Presentation API - Present
    func presentHostedView(_ content: some View) {
        let hostingController: UIHostingController = .init(rootView: AnyView(content))
        self.hostingController = hostingController
        
        hostingController.modalPresentationStyle = .overFullScreen
        hostingController.modalTransitionStyle = .crossDissolve
        hostingController.transitioningDelegate = self
        
        hostingController.view.backgroundColor = .clear

        _present(hostingController: hostingController)
    }

    @discardableResult
    private func _present(
        hostingController: HostingViewControllerType
    ) -> Bool {
        if presentedViewController == nil {
            present(hostingController, animated: true, completion: nil)

            PresentationHostViewControllerStorage.shared.storage[id] = self

            return true

        } else {
            failedToPresentDueToAlreadyPresentingViewController = true

            return false
        }
    }

    // MARK: Presentation API - Update
    func updateHostedView(with content: some View) {
        hostingController?.rootView = AnyView(content)
    }

    // MARK: Presentation API - Dismiss
    func dismissHostedView() {
        _dismissHostedView(force: false)
    }
    
    static func forceDismiss(id: String) {
        PresentationHostViewControllerStorage.shared.storage[id]?._dismissHostedView(force: true)
    }
    
    private func _dismissHostedView(force: Bool) {
        if force {
            if
                let rootViewController: UIViewController = UIApplication.shared.firstWindow(where: { window in
                    window.rootViewController?.presentedViewController == hostingController
                })?.rootViewController
            {
                rootViewController.dismiss(animated: false, completion: nil)
            }
            
        } else {
            dismiss(animated: false, completion: nil)
        }
        
        hostingController = nil
        _ = PresentationHostViewControllerStorage.shared.storage.removeValue(forKey: id)
        
        PresentationHostDataSourceCache.shared.remove(key: id)
    }

    // MARK: Queueing
    private func addObserversForQueueing() {
        NotificationCenter.default.addObserver(
            forName: dismissNotificationName,
            object: nil,
            queue: .main,
            using: { [weak self] _ in
                guard let self else { return }

                guard failedToPresentDueToAlreadyPresentingViewController else {
                    return
                }

                guard let hostingController else {
                    failedToPresentDueToAlreadyPresentingViewController = false
                    return
                }

                let flag: Bool = _present(hostingController: hostingController)
                if flag { failedToPresentDueToAlreadyPresentingViewController = false }
            }
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
