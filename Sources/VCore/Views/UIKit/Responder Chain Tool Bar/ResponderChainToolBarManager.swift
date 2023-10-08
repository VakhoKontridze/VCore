//
//  ResponderChainToolBarManager.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 24.05.23.
//

#if canImport(UIKit) && !(os(tvOS) || os(watchOS))

import UIKit

// MARK: - Responder Chain Tool Bar Responder Parameters
/// Parameter object that wraps `ResponderChainToolBarResponder` and it's UI customization.
public struct ResponderChainToolBarResponderParameters {
    // MARK: Properties
    /// `ResponderChainToolBarResponder`.
    public var responder: any ResponderChainToolBarResponder

    /// Toolbar ui model.
    public var toolBarUIModel: ResponderChainToolBarUIModel

    /// Toolbar size.
    public var toolBarSize: CGSize

    // MARK: Initializers
    /// Initializes `ResponderChainToolBarResponderParameters` with `ResponderChainToolBarResponder` and it's UI customization.
    public init(
        responder: ResponderChainToolBarResponder,
        toolBarUIModel: ResponderChainToolBarUIModel = .init(),
        toolBarSize: CGSize
    ) {
        self.responder = responder
        self.toolBarUIModel = toolBarUIModel
        self.toolBarSize = toolBarSize
    }
}

// MARK: - Responder Chain Tool Bar Responder
/// Object that supports input and can represent a responder in `ResponderChainToolBarManager`.
///
/// `UITextField` and `UITextView` automatically conform to this `protocol`.
public protocol ResponderChainToolBarResponder: AnyObject {
    /// Custom input accessory `UIView` to display when the responder becomes the first responder.
    var inputAccessoryView: UIView? { get set }

    /// Asks `UIKit` to make this object the first responder in its `UIWindow`.
    func becomeFirstResponder() -> Bool

    /// Notifies this object that it has been asked to relinquish its status as first responder in its `UIWindow`.
    func resignFirstResponder() -> Bool
}

extension UITextField: ResponderChainToolBarResponder {}

extension UITextView: ResponderChainToolBarResponder {}

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
///             view.backgroundColor = UIColor.systemBackground
///
///             view.addSubview(textField)
///             view.addSubview(textView)
///
///             NSLayoutConstraint.activate(...)
///
///             responderChainToolBarManager.setResponders([
///                 ResponderChainToolBarResponderParameters(
///                     responder: textField,
///                     toolBarSize: CGSize(width: view.bounds.size.width, height: 0)
///                 ),
///                 ResponderChainToolBarResponderParameters(
///                     responder: textView,
///                     toolBarSize: CGSize(width: view.bounds.size.width, height: 0)
///                 )
///             ])
///         }
///     }
///
open class ResponderChainToolBarManager {
    // MARK: Properties
    /// Managed `ResponderChainToolBarResponderParameters`s.
    private(set) open var responderParameters: [ResponderChainToolBarResponderParameters] = []

    // MARK: Initializers
    /// Initializes `ResponderChainToolBarManager`.
    public init() {}

    /// Initializes `ResponderChainToolBarManager` with responders.
    public convenience init(
        responders responderParameters: [ResponderChainToolBarResponderParameters]
    ) {
        self.init()

        setResponders(responderParameters)
    }

    // MARK: Configuration
    /// Sets and configures responders.
    open func setResponders(_ responderParameters: [ResponderChainToolBarResponderParameters]) {
        self.responderParameters = responderParameters

        reloadData()
    }

    // MARK: Configuration - Reload Data
    private func reloadData() {
        for (i, parameters) in responderParameters.enumerated() {
            let previousParameters: ResponderChainToolBarResponderParameters? = responderParameters[safe: i-1]
            let nextParameters: ResponderChainToolBarResponderParameters? = responderParameters[safe: i+1]

            let toolbar: ResponderChainToolBar = .init(
                uiModel: parameters.toolBarUIModel,
                size: parameters.toolBarSize,
                arrowUpButtonAction: { _ = previousParameters?.responder.becomeFirstResponder() },
                arrowDownButtonAction: { _ = nextParameters?.responder.becomeFirstResponder() },
                doneButtonAction: { _ = parameters.responder.resignFirstResponder() }
            )
            toolbar.arrowUpButton.isEnabled = previousParameters != nil
            toolbar.arrowDownButton.isEnabled = nextParameters != nil

            parameters.responder.inputAccessoryView = toolbar
        }
    }
}

#endif
