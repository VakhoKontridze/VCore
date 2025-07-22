//
//  ResponderChainUIToolbar.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 24.05.23.
//

#if canImport(UIKit) && !(os(tvOS) || os(watchOS) || os(visionOS))

import UIKit

// MARK: - Responder Chain UI Toolbar
/// Toolbar that handles focus navigation in the responder chain.
///
///     final class ViewController: UIViewController {
///         private let textField: UITextField = ...
///         private let textView: UITextView = ...
///
///         override func viewDidLoad() {
///             super.viewDidLoad()
///
///             view.backgroundColor = UIColor.systemBackground
///
///             textField.inputAccessoryView = {
///                 let toolbar: ResponderChainUIToolbar = .init(
///                     size: CGSize(width: view.bounds.size.width, height: 0),
///                     arrowUpButtonAction: nil,
///                     arrowDownButtonAction: { [weak self] in _ = self?.textView.becomeFirstResponder() },
///                     doneButtonAction: { [weak self] in _ = self?.textField.resignFirstResponder() }
///                 )
///                 toolbar.arrowUpButton.isEnabled = false
///                 return toolbar
///             }()
///
///             textView.inputAccessoryView = {
///                 let toolbar: ResponderChainUIToolbar = .init(
///                     size: CGSize(width: view.bounds.size.width, height: 0),
///                     arrowUpButtonAction: { [weak self] in _ = self?.textField.becomeFirstResponder() },
///                     arrowDownButtonAction: nil,
///                     doneButtonAction: { [weak self] in _ = self?.textView.resignFirstResponder() }
///                 )
///                 toolbar.arrowDownButton.isEnabled = false
///                 return toolbar
///             }()
///
///             view.addSubview(textField)
///             view.addSubview(textView)
///
///             NSLayoutConstraint.activate(...)
///         }
///     }
///
/// Alternately, consider using `ResponderChainUIToolbarManager`
open class ResponderChainUIToolbar: UIToolbar {
    // MARK: Subviews
    /// Button that focuses responder that's up in responder chain.
    open lazy var arrowUpButton: UIBarButtonItem = .init(
        image: UIImage(systemName: "chevron.up"),
        style: .plain,
        target: self,
        action: #selector(didTapArrowUpButton)
    )

    /// Button that focuses responder that's down in responder chain.
    open lazy var arrowDownButton: UIBarButtonItem = .init(
        image: UIImage(systemName: "chevron.down"),
        style: .plain,
        target: self,
        action: #selector(didTapArrowDownButton)
    )

    private lazy var spacer: UIBarButtonItem = .init(
        barButtonSystemItem: .flexibleSpace,
        target: nil,
        action: nil
    )

    /// Button that dismisses focus.
    open lazy var doneButton: UIBarButtonItem = .init(
        title: VCoreLocalizationManager.shared.localizationProvider.responderChainToolbarDoneButtonTitle,
        style: .done,
        target: self,
        action: #selector(didTapDoneButton)
    )

    // MARK: Properties
    /// Model that describes appearance.
    ///
    /// To change current appearance, use `configure(appearance:)` method.
    private(set) public var appearance: ResponderChainUIToolbarAppearance

    /// Action that runs when arrow up button is tapped.
    open var arrowUpButtonAction: (() -> Void)?

    /// Action that runs when arrow down button is tapped.
    open var arrowDownButtonAction: (() -> Void)?

    /// Action that runs when done button is tapped.
    open var doneButtonAction: (() -> Void)?

    // MARK: Initializers
    /// Initializes `ResponderChainUIToolbar.
    public init(
        appearance: ResponderChainUIToolbarAppearance = .init(),
        size: CGSize
    ) {
        self.appearance = appearance

        super.init(
            frame: CGRect(
                origin: .zero,
                size: size
            )
        )

        setUp()
        configure(appearance: appearance)
    }

    /// Initializes `ResponderChainUIToolbar` with actions.
    convenience public init(
        appearance: ResponderChainUIToolbarAppearance = .init(),
        size: CGSize,
        arrowUpButtonAction: (() -> Void)?,
        arrowDownButtonAction: (() -> Void)?,
        doneButtonAction: (() -> Void)?
    ) {
        self.init(
            appearance: appearance,
            size: size
        )

        self.arrowUpButtonAction = arrowUpButtonAction
        self.arrowDownButtonAction = arrowDownButtonAction
        self.doneButtonAction = doneButtonAction
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: Setup
    /// Sets up `ResponderChainUIToolbar`.
    open func setUp() {
        sizeToFit()
    }

    // MARK: Configuration
    /// Configures `ResponderChainUIToolbar` with `ResponderChainUIToolbarAppearance`.
    open func configure(appearance: ResponderChainUIToolbarAppearance) {
        self.appearance = appearance

        barStyle = appearance.style
        isTranslucent = appearance.isTranslucent
        barTintColor = appearance.toolbarColor

        for button in [arrowUpButton, arrowDownButton, doneButton] {
            button.tintColor = appearance.buttonColor
        }

        items = {
            var items: [UIBarButtonItem] = []

            if appearance.hasButtons {
                if appearance.hasNavigationButtons {
                    items.append(contentsOf: [
                        arrowUpButton,
                        arrowDownButton,
                    ])
                }

                items.append(spacer)

                if appearance.hasDoneButton {
                    items.append(doneButton)
                }
            }

            return items
        }()
    }

    // MARK: Actions
    /// Selector that runs when arrow up button is tapped.
    @objc 
    open func didTapArrowUpButton(sender: UIBarButtonItem) -> Void {
        arrowUpButtonAction?()
    }

    /// Selector that runs when arrow down button is tapped.
    @objc 
    open func didTapArrowDownButton(sender: UIBarButtonItem) -> Void {
        arrowDownButtonAction?()
    }

    /// Selector that runs when done button is tapped.
    @objc 
    open func didTapDoneButton(sender: UIBarButtonItem) -> Void {
        doneButtonAction?()
    }
}

#endif
