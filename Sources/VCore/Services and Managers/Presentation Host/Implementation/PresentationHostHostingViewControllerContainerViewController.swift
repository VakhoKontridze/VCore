//
//  PresentationHostHostingViewControllerContainerViewController.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 09.08.23.
//

#if canImport(UIKit) && !os(watchOS)

import SwiftUI

// MARK: - Presentation Host Hosting View Controller Container View Controller
@available(tvOS, unavailable)
@available(visionOS, unavailable)
final class PresentationHostHostingViewControllerContainerViewController: KeyboardResponsiveUIViewController {
    // MARK: Subviews
    let hostingController: HostingViewControllerType

    // MARK: Properties
    typealias HostingViewControllerType = UIHostingController<AnyView>

    let id: String
    private let uiModel: PresentationHostUIModel

    // MARK: Initializers
    init(
        id: String,
        uiModel: PresentationHostUIModel,
        content: AnyView
    ) {
        self.id = id
        self.uiModel = uiModel

        self.hostingController = {
            let hostingController: UIHostingController = .init(rootView: content)
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            hostingController.view.backgroundColor = .clear
            hostingController.overrideBehaviors([.disablesSafeAreaInsets, .disablesKeyboardAvoidance])
            return hostingController
        }()

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    // MARK: Setup
    private func setUp() {
        setUpView()
        addSubviews()
        setUpLayout()
    }

    private func setUpView() {
        view.backgroundColor = .clear
    }

    private func addSubviews() {
        addChild(hostingController)
        view.addSubview(hostingController.view)
    }

    private func setUpLayout() {
        NSLayoutConstraint.activate([
            hostingController.view.constraintLeading(to: view),
            hostingController.view.constraintTrailing(to: view),
            hostingController.view.constraintTop(to: view),
            hostingController.view.constraintBottom(to: view)
        ])
    }

    // MARK: Keyboard Responsiveness
    override func keyboardWillShow(_ systemKeyboardInfo: SystemKeyboardInfo) {
        super.keyboardWillShow(systemKeyboardInfo)

        switch uiModel.keyboardResponsivenessStrategy.storage {
        case .none:
            break

        case .offset(let offset):
            UIView.animateKeyboardResponsiveness(
                systemKeyboardInfo: systemKeyboardInfo,
                animations: { [weak self] in
                    guard let self else { return }

                    view.bounds.origin.y = offset
                    view.superview?.layoutIfNeeded()
                }
            )

        case .offsetByKeyboardHeight(let additionalOffset):
            UIView.animateKeyboardResponsiveness(
                systemKeyboardInfo: systemKeyboardInfo,
                animations: { [weak self] in
                    guard let self else { return }

                    guard let systemKeyboardHeight: CGFloat = systemKeyboardInfo.frame?.size.height else { return } // Will never fail

                    view.bounds.origin.y = systemKeyboardHeight + additionalOffset
                    view.superview?.layoutIfNeeded()
                }
            )

        case .offsetByObscuredSubviewHeight(let safeAreaInset):
            guard let firstResponderSubview: UIView = view.childFirstResponderView else { return }

            UIView.animateKeyboardResponsivenessByUnObscuringFirstResponderView(
                keyboardWillShow: true,
                firstResponderView: firstResponderSubview,
                containerView: view,
                systemKeyboardInfo: systemKeyboardInfo,
                keyboardSafeAreMargin: safeAreaInset
            )
        }
    }

    override func keyboardWillHide(_ systemKeyboardInfo: SystemKeyboardInfo) {
        super.keyboardWillHide(systemKeyboardInfo)

        switch uiModel.keyboardResponsivenessStrategy.storage {
        case .none:
            break

        case .offset:
            UIView.animateKeyboardResponsiveness(
                systemKeyboardInfo: systemKeyboardInfo,
                animations: { [weak self] in
                    guard let self else { return }

                    view.bounds.origin.y = 0
                    view.superview?.layoutIfNeeded()
                }
            )

        case .offsetByKeyboardHeight:
            UIView.animateKeyboardResponsiveness(
                systemKeyboardInfo: systemKeyboardInfo,
                animations: { [weak self] in
                    guard let self else { return }

                    view.bounds.origin.y = 0
                    view.superview?.layoutIfNeeded()
                }
            )

        case .offsetByObscuredSubviewHeight(let safeAreaInset):
            guard let firstResponderSubview: UIView = view.childFirstResponderView else { return }

            UIView.animateKeyboardResponsivenessByUnObscuringFirstResponderView(
                keyboardWillShow: false,
                firstResponderView: firstResponderSubview,
                containerView: view,
                systemKeyboardInfo: systemKeyboardInfo,
                keyboardSafeAreMargin: safeAreaInset
            )
        }
    }
}

#endif
