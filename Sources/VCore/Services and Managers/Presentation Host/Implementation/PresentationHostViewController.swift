//
//  PresentationHostViewController.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 4/14/22.
//

#if canImport(UIKit) && !os(watchOS)

import SwiftUI
import OSLog

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
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
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
    func presentHostedView(
        _ content: AnyView,
        completion: (() -> Void)?
    ) {
        let hostingControllerContainer: PresentationHostHostingViewControllerContainerViewController = .init(
            id: id,
            uiModel: uiModel,
            content: content
        )

        hostingControllerContainer.modalPresentationStyle = .overFullScreen
        hostingControllerContainer.modalTransitionStyle = .crossDissolve
        hostingControllerContainer.transitioningDelegate = self

        Task(operation: { @MainActor [weak self] in // `Task` is needed here, to retrieve correct values from `presentedViewController`
            guard let self else { return }

            if let presentedViewController {
                if
                    let presentedViewController = presentedViewController as? PresentationHostHostingViewControllerContainerViewController,
                    presentedViewController.id == id
                {
                    return

                } else {
                    Logger.presentationHost.warning("Attempting to present modal with ID '\(self.id)' in 'PresentationHost', which is already presenting '\(presentedViewController.debugDescription)'")
                    return
                }
            }

            present(hostingControllerContainer, animated: true, completion: completion)

            self.hostingControllerContainer = hostingControllerContainer

            PresentationHostViewControllerStorage.shared.storage[id] = self
        })
    }

    // MARK: Presentation - Update
    func updateHostedView(
        with content: AnyView
    ) {
        hostingControllerContainer?.hostingController.rootView = content
    }

    // MARK: Presentation - Dismiss
    func dismissHostedView(
        completion: (() -> Void)?
    ) {
        _dismissHostedView(force: false, completion: completion)
    }
    
    static func forceDismissHostedView(
        id: String
    ) {
        guard
            let viewController: PresentationHostViewController = PresentationHostViewControllerStorage.shared.storage[id]
        else {
            return
        }

        viewController._dismissHostedView(force: true, completion: nil)
    }
    
    private func _dismissHostedView(
        force: Bool,
        completion: (() -> Void)?
    ) {
        let tearDown: () -> Void = { [weak self] in
            guard let self else { return }

            hostingControllerContainer = nil
            _ = PresentationHostViewControllerStorage.shared.storage.removeValue(forKey: id)

            PresentationHostDataSourceCache.shared.remove(key: id)
        }

        switch force {
        case false:
            dismiss(animated: false, completion: {
                tearDown()
                completion?()
            })

        case true:
            if
                let rootViewController: UIViewController = UIApplication.shared
                    .connectedScenes
                    .filter({ $0.activationState == .foregroundActive })
                    .compactMap({ $0 as? UIWindowScene })
                    .flatMap({ $0.windows })
                    .first(where: { $0.rootViewController?.presentedViewController == hostingControllerContainer })?
                    .rootViewController
            {
                rootViewController.dismiss(animated: false, completion: {
                    tearDown()
                    completion?()
                })
            }
        }
    }
}

#endif
