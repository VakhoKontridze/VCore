//
//  ModalPresenterRootUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 28.05.25.
//

import SwiftUI

// MARK: - Modal Presenter Root UI Model
/// Model that describes UI.
public struct ModalPresenterRootUIModel: Sendable {
    // MARK: Properties - Global
#if !(os(macOS) || os(tvOS) || os(watchOS) || os(visionOS))
    /// Window level. Set to `normal`.
    ///
    /// Only used in `window` configuration.
    public var windowLevel: UIWindow.Level = .normal
#endif
    
    /// Frame. Set to `default`.
    ///
    /// Changing this property conditionally will cause view state to be reset.
    public var frame: Frame = .default

    // MARK: Properties - Dimming View
    /// Shared dimming view color in the root.
    ///
    /// Dimming view will appear if at least on modal is presented.
    /// If only one modal is presented, this property can be overridden by `preferredDimmingViewColor` from `ModalPresenterLinkUIModel`.
    public var dimmingViewColor: Color = .platformDynamic(Color(100, 100, 100, 0.3), Color.black.opacity(0.4))

    /// Dimming view tap action. Set to `default`.
    ///
    /// Dimming view will appear if at least on modal is presented.
    public var dimmingViewTapAction: DimmingViewTapAction = .default

    // MARK: Properties - Keyboard Responsiveness
#if !(os(macOS) || os(tvOS) || os(watchOS) || os(visionOS))
    /// Model for customizing keyboard responsiveness.
    ///
    /// Changes made to this property conditionally will not be reflected.
    public var keyboardObserverSubUIModel: KeyboardObserverUIModel = .init()
#endif

    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}

    // MARK: Frame
    /// Frame.
    public enum Frame: Equatable, Sendable {
        // MARK: Cases
        /// Fixed frame.
        case fixed(size: CGSize, alignment: Alignment, offset: CGSize)

        /// Infinite frame.
        case infinite

        // MARK: Initializers
        /// Default value. Set to `infinite`.
        public static var `default`: Self { .infinite }
    }

    // MARK: Dimming View Tap Action
    /// Dimming view tap action.
    public enum DimmingViewTapAction: Int, Equatable, Sendable, CaseIterable {
        // MARK: Cases
        /// None.
        case none

        /// Passes taps through.
        case passTapsThrough

        /// Sends action to topmost modal.
        case sendActionToTopmostModal

        // MARK: Properties
        var allowsHitTesting: Bool {
            switch self {
            case .none: true
            case .passTapsThrough: false
            case .sendActionToTopmostModal: true
            }
        }

        // MARK: Initializers
        /// Default value. Set to `sendActionToTopmostModal`.
        public static var `default`: Self { .sendActionToTopmostModal }
    }
}
