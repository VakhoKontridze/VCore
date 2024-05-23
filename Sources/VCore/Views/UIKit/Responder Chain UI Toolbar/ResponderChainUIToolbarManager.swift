//
//  ResponderChainUIToolbarManager.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 24.05.23.
//

#if canImport(UIKit) && !(os(tvOS) || os(watchOS) || os(visionOS))

import UIKit

// MARK: - Responder Chain UI Toolbar Manager
/// Object that manages focus navigation in the responder chain.
///
///     final class ViewController: UIViewController {
///         private let textField: UITextField = ...
///         private let textView: UITextView = ...
///
///         private let responderChainToolbarManager: ResponderChainUIToolbarManager = .init()
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
///             responderChainToolbarManager.setResponders([
///                 ResponderChainUIToolbarResponderParameters(
///                     responder: textField,
///                     toolBarSize: CGSize(width: view.bounds.size.width, height: 0)
///                 ),
///                 ResponderChainUIToolbarResponderParameters(
///                     responder: textView,
///                     toolBarSize: CGSize(width: view.bounds.size.width, height: 0)
///                 )
///             ])
///         }
///     }
///
open class ResponderChainUIToolbarManager {
    // MARK: Properties
    /// Managed `ResponderChainUIToolbarResponderParameters`s.
    private(set) open var responderParameters: [ResponderChainUIToolbarResponderParameters] = []

    // MARK: Initializers
    /// Initializes `ResponderChainUIToolbarManager`.
    public init() {}

    /// Initializes `ResponderChainUIToolbarManager` with responders.
    convenience public init(
        responders responderParameters: [ResponderChainUIToolbarResponderParameters]
    ) {
        self.init()

        setResponders(responderParameters)
    }

    // MARK: Configuration
    /// Sets and configures responders.
    open func setResponders(_ responderParameters: [ResponderChainUIToolbarResponderParameters]) {
        self.responderParameters = responderParameters

        reloadData()
    }

    // MARK: Configuration - Reload Data
    private func reloadData() {
        for (i, parameters) in responderParameters.enumerated() {
            let previousParameters: ResponderChainUIToolbarResponderParameters? = responderParameters[safe: i-1]
            let nextParameters: ResponderChainUIToolbarResponderParameters? = responderParameters[safe: i+1]

            let toolbar: ResponderChainUIToolbar = .init(
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
