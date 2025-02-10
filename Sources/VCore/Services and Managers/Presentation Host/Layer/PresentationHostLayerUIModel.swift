//
//  PresentationHostLayerUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11.07.24.
//

import SwiftUI

// MARK: - Presentation Host Layer UI Model
/// Model that describes UI.
public struct PresentationHostLayerUIModel: Sendable {
    // MARK: Properties - Global
    /// Frame. Set to `default`.
    ///
    /// Changing this property conditionally will cause view state to be reset.
    public var frame: Frame = .default

    // MARK: Properties - Dimming View
    /// Shared dimming view color in the layer.
    ///
    /// Dimming view will appear if at least on modal is presented.
    /// If only one modal is presented, this property will be overridden by `preferredDimmingViewColor` from `PresentationHostUIModel`.
    public var dimmingViewColor: Color = .platformDynamic(Color(100, 100, 100, 0.3), Color.black.opacity(0.4))

    /// Dimming view tap action. Set to `default`.
    ///
    /// Dimming view will appear if at least on modal is presented.
    public var dimmingViewTapAction: DimmingViewTapAction = .default

    // MARK: Properties - Keyboard Responsiveness
#if os(iOS)
    /// Model for customizing keyboard responsiveness.
    public var keyboardObserverSubUIModel: KeyboardObserverUIModel = .init()
#endif

    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}

    // MARK: Frame
    /// Frame.
    public enum Frame: Sendable {
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
    public enum DimmingViewTapAction: Int, Sendable, CaseIterable {
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
