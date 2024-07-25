//
//  PresentationHostLayerUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11.07.24.
//

import SwiftUI

// MARK: - Presentation Host Layer UI Model
/// Model that describes UI.
public struct PresentationHostLayerUIModel {
    // MARK: Properties - Global
    /// Frame. Set to `default`.
    ///
    /// Changing this property conditionally will cause view state to be reset.
    public var frame: Frame = .default

    // MARK: Properties - Dimming View
    /// Shared dimming view color in the layer.
    ///
    /// Dimming view will appear if at least on modal is presented.
    public var dimmingViewColor: Color = .platformDynamic(Color(100, 100, 100, 0.3), Color.black.opacity(0.4))

    /// Dimming view tap action. Set to `default`.
    public var dimmingViewTapAction: DimmingViewTapAction = .default

    // MARK: Properties - Keyboard Responsiveness
#if os(iOS)
    /// Keyboard responsiveness strategy. Set to `default`.
    ///
    /// Changing this property conditionally will cause view state to be reset.
    public var keyboardResponsivenessStrategy: KeyboardObserverUIModel.KeyboardResponsivenessStrategy = .default

    var keyboardObserverSubUIModel: KeyboardObserverUIModel {
        var uiModel: KeyboardObserverUIModel = .init()
        uiModel.keyboardResponsivenessStrategy = keyboardResponsivenessStrategy
        return uiModel
    }
#endif

    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}

    // MARK: Frame
    /// Frame.
    public enum Frame {
        // MARK: Cases
        /// Fixed frame.
        case fixed(size: CGSize, alignment: Alignment, offset: CGSize)

        /// Infinite frame.
        case infinite

        // MARK: Initializers
        /// Default value. Set to `infinite`.
        public static var `default`: Self { .infinite }
    }

    // MARK: Ignored Safe Area
    /// Ignored safe areas.
    @MemberwiseInitializable(
        comment: "/// Initializes `IgnoredSafeArea` with regions and edges."
    )
    public struct IgnoredSafeArea {
        /// Regions.
        public let regions: SafeAreaRegions

        /// Edges.
        public let edges: Edge.Set
    }

    // MARK: Dimming View Tap Action
    /// Dimming view tap action.
    public enum DimmingViewTapAction: Int, CaseIterable {
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
        /// Default value. Set to `sendActionToTopMostModal`.
        public static var `default`: Self { .sendActionToTopmostModal }
    }
}
