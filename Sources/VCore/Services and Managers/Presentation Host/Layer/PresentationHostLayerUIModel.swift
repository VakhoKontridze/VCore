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

    /// Ignored safe area. Set to `container` regions and `all` edges.
    ///
    /// Changing this property conditionally will cause view state to be reset.
    public var ignoredSafeArea: IgnoredSafeArea? = .init(
        regions: .container,
        edges: .all
    )

    // MARK: Properties - Dimming View
    /// Shared dimming view color in the layer.
    ///
    /// Dimming view will appear if at least on modal is presented.
    public var dimmingViewColor: Color = {
#if os(iOS)
        return Color.dynamic(
            Color(red: 100/255, green: 100/255, blue: 100/255, opacity: 0.3),
            Color.black.opacity(0.4)
        )
#elseif os(macOS)
        return Color.dynamic(
            Color(red: 100/255, green: 100/255, blue: 100/255, opacity: 0.3),
            Color.black.opacity(0.4)
        )
#elseif os(tvOS)
        return Color.dynamic(
            Color(red: 100/255, green: 100/255, blue: 100/255, opacity: 0.3),
            Color.black.opacity(0.4)
        )
#elseif os(watchOS)
        Color.black.opacity(0.4)
#elseif os(visionOS)
        Color(red: 100/255, green: 100/255, blue: 100/255, opacity: 0.3)
#endif
    }()

    /// Dimming view tap action. Set to `default`.
    public var dimmingViewTapAction: DimmingViewTapAction = .default

    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}

    // MARK: Frame
    /// Enumeration that represents frame.
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

    // MARK: Ignores Safe Area
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
    /// Enumeration that represents dimming view tap action.
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
