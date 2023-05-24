//
//  ResponderChainToolBarManager.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 24.05.23.
//

#if os(iOS) || targetEnvironment(macCatalyst)

import UIKit

// MARK: - Input Responder View
/// Object that supports input and can become a first responder.
///
/// `UITextField` and `UITextView` automatically conform to this `protocol`.
public protocol InputResponderView: AnyObject {
    /// Custom input accessory `UIView` to display when the responder becomes the first responder.
    var inputAccessoryView: UIView? { get set }

    /// Asks `UIKit` to make this object the first responder in its `UIWindow`.
    func becomeFirstResponder() -> Bool

    /// Notifies this object that it has been asked to relinquish its status as first responder in its `UIWindow`.
    func resignFirstResponder() -> Bool
}

extension UITextField: InputResponderView {}

extension UITextView: InputResponderView {}

// MARK: - Responder Chain Tool Bar Manager
/// Object that manages focus navigation in the responder chain.
///
///     final class ViewController: UIViewController {
///         private let textField: UITextField = { ... }()
///         private let textView: UITextView = { ... }()
///
///         private let responderChainToolBarManager: ResponderChainToolBarManager = .init()
///
///         override func viewDidLoad() {
///             super.viewDidLoad()
///
///             view.backgroundColor = .white
///
///             view.addSubview(textField)
///             view.addSubview(textView)
///
///             NSLayoutConstraint.activate(...)
///
///             responderChainToolBarManager.setResponders([
///                 textField,
///                 textView
///             ])
///         }
///     }
///
open class ResponderChainToolBarManager {
    // MARK: Properties
    /// Model that describes UI.
    ///
    /// To change current UI model, use `configure(uiModel)` method.
    private(set) public var uiModel: ResponderChainToolBarUIModel

    /// List of responders managed by `ResponderChainToolBarManager`.
    private(set) open var responders: [any InputResponderView] = []

    // MARK: Initializers
    /// Initializes `ResponderChainToolBarManager`.
    public init(
        uiModel: ResponderChainToolBarUIModel = .init()
    ) {
        self.uiModel = uiModel
    }

    /// Initializes `ResponderChainToolBarManager` with responders.
    public convenience init(
        uiModel: ResponderChainToolBarUIModel = .init(),
        responders: [any InputResponderView]
    ) {
        self.init(uiModel: uiModel)

        setResponders(responders)
    }

    // MARK: Configuration - UI Model
    /// Configures `ResponderChainToolBarManager` with `ResponderChainToolBarUIModel`.
    open func configure(uiModel: ResponderChainToolBarUIModel) {
        self.uiModel = uiModel

        reloadData()
    }

    // MARK: Configuration - Responders
    /// Sets and configures responders.
    open func setResponders(_ responders: [any InputResponderView]) {
        self.responders = responders

        reloadData()
    }

    // MARK: Configuration - Reload Data
    private func reloadData() {
        for (i, responder) in responders.enumerated() {
            let previousResponder: (any InputResponderView)? = responders[safe: i-1]
            let nextResponder: (any InputResponderView)? = responders[safe: i+1]

            let toolbar: ResponderChainToolBar = .init(
                uiModel: uiModel,
                arrowUpButtonAction: { [weak previousResponder] in _ = previousResponder?.becomeFirstResponder() },
                arrowDownButtonAction: { [weak nextResponder] in _ = nextResponder?.becomeFirstResponder() },
                doneButtonAction: { [weak responder] in _ = responder?.resignFirstResponder() }
            )
            toolbar.arrowUpButton.isEnabled = previousResponder != nil
            toolbar.arrowDownButton.isEnabled = nextResponder != nil

            responder.inputAccessoryView = toolbar
        }
    }
}

#endif
