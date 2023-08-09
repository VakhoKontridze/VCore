//
//  PresentationHostHostingViewControllerContainerViewController.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 09.08.23.
//

#if canImport(UIKit) && !os(watchOS)

import SwiftUI

// MARK: - Presentation Host Hosting View Controller Container View Controller
final class PresentationHostHostingViewControllerContainerViewController: KeyboardResponsiveUIViewControllerOffsettingContainerByObscuredSubviewHeight {
    // MARK: Subviews
    let hostingController: HostingViewControllerType

    // MARK: Properties
    typealias HostingViewControllerType = UIHostingController<AnyView>

    // MARK: Initializers
    init(hostingController: HostingViewControllerType) {
        self.hostingController = hostingController
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(hostingController)

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(hostingController.view)

        NSLayoutConstraint.activate([
            hostingController.view.constraintLeading(to: view),
            hostingController.view.constraintTrailing(to: view),
            hostingController.view.constraintTop(to: view),
            hostingController.view.constraintBottom(to: view)
        ])
    }
}

#endif
