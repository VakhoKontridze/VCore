//
//  ResponderChainToolBar.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 24.05.23.
//

#if os(iOS) || targetEnvironment(macCatalyst)

import UIKit

// MARK: - Responder Chain Tool Bar
/// Toolbar that handles focus navigation in the responder chain.
///
///     final class ViewController: UIViewController {
///         private let textField: UITextField = { ... }()
///         private let textView: UITextView = { ... }()
///
///         override func viewDidLoad() {
///             super.viewDidLoad()
///
///             view.backgroundColor = .white
///
///             textField.inputAccessoryView = {
///                 let toolbar: ResponderChainToolBar = .init(
///                     arrowUpButtonAction: nil,
///                     arrowDownButtonAction: { [weak self] in _ = self?.textField2.becomeFirstResponder() },
///                     doneButtonAction: { [weak self] in _ = self?.textField1.resignFirstResponder() }
///                 )
///                 toolbar.arrowUpButton.isEnabled = false
///                 return toolbar
///             }()
///
///             textView.inputAccessoryView = {
///                 let toolbar: ResponderChainToolBar = .init(
///                     arrowUpButtonAction: { [weak self] in _ = self?.textField1.becomeFirstResponder() },
///                     arrowDownButtonAction: nil,
///                     doneButtonAction: { [weak self] in _ = self?.textField2.resignFirstResponder() }
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
/// Alternately, consider using `ResponderChainToolBarManager`
open class ResponderChainToolBar: UIToolbar {
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
        title: uiModel.layout.doneButtonTitle,
        style: .done,
        target: self,
        action: #selector(didTapDoneButton)
    )

    // MARK: Properties
    /// Model that describes UI.
    ///
    /// To change current UI model, use `configure(uiModel)` method.
    private(set) public var uiModel: ResponderChainToolBarUIModel

    /// Action that runs when arrow up button is tapped.
    open var arrowUpButtonAction: (() -> Void)?

    /// Action that runs when arrow down button is tapped.
    open var arrowDownButtonAction: (() -> Void)?

    /// Action that runs when done button is tapped.
    open var doneButtonAction: (() -> Void)?

    // MARK: Initializers
    /// Initializes `ResponderChainToolBar.
    public init(
        uiModel: ResponderChainToolBarUIModel = .init()
    ) {
        self.uiModel = uiModel

        super.init(frame: CGRect(
            origin: .zero,
            size: CGSize( // Automatically handles landscape
                width: UIScreen.main.bounds.width,
                height: 50
            )
        ))

        setUp()
        configure(uiModel: uiModel)
    }

    /// Initializes `ResponderChainToolBar` with actions.
    public convenience init(
        uiModel: ResponderChainToolBarUIModel = .init(),
        arrowUpButtonAction: (() -> Void)?,
        arrowDownButtonAction: (() -> Void)?,
        doneButtonAction: (() -> Void)?
    ) {
        self.init(uiModel: uiModel)

        self.arrowUpButtonAction = arrowUpButtonAction
        self.arrowDownButtonAction = arrowDownButtonAction
        self.doneButtonAction = doneButtonAction
    }

    required public init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: Setup
    /// Sets up `ResponderChainToolBar`.
    open func setUp() {
        sizeToFit()
    }

    // MARK: Configuration
    /// Configures `ResponderChainToolBar` with `ResponderChainToolBarUIModel`.
    open func configure(uiModel: ResponderChainToolBarUIModel) {
        self.uiModel = uiModel

        barStyle = uiModel.colors.style
        isTranslucent = uiModel.colors.isTranslucent
        barTintColor = uiModel.colors.tintColor

        items = {
            var items: [UIBarButtonItem] = []

            if uiModel.layout.hasButtons {
                if uiModel.layout.hasNavigationButtons {
                    items.append(contentsOf: [
                        arrowUpButton,
                        arrowDownButton,
                    ])
                }

                items.append(spacer)

                if uiModel.layout.hasDoneButton {
                    items.append(doneButton)
                }
            }

            return items
        }()
    }

    // MARK: Actions
    /// Selector that runs when arrow up button is tapped.
    @objc open func didTapArrowUpButton(sender: UIBarButtonItem) -> Void {
        arrowUpButtonAction?()
    }

    /// Selector that runs when arrow down button is tapped.
    @objc open func didTapArrowDownButton(sender: UIBarButtonItem) -> Void {
        arrowDownButtonAction?()
    }

    /// Selector that runs when done button is tapped.
    @objc open func didTapDoneButton(sender: UIBarButtonItem) -> Void {
        doneButtonAction?()
    }
}

#endif