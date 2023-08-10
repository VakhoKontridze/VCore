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

    private let isKeyboardResponsive: Bool
    private let marginBottomToKeyboard: CGFloat

    // MARK: Initializers
    init(
        isKeyboardResponsive: Bool,
        marginBottomToKeyboard: CGFloat,
        hostingController: HostingViewControllerType
    ) {
        self.isKeyboardResponsive = isKeyboardResponsive
        self.marginBottomToKeyboard = marginBottomToKeyboard
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

    // MARK: Keyboard Responsiveness
    override var keyboardResponsivenessFirstResponderViewMarginBottomToKeyboard: CGFloat { marginBottomToKeyboard }

    override func keyboardWillShow(_ systemKeyboardInfo: SystemKeyboardInfo) {
        guard isKeyboardResponsive else { return }

        super.keyboardWillShow(systemKeyboardInfo)
    }

    override func keyboardWillHide(_ systemKeyboardInfo: SystemKeyboardInfo) {
        guard isKeyboardResponsive else { return }

        super.keyboardWillHide(systemKeyboardInfo)
    }
}

#endif
