//
//  PlainDisclosureGroupUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 22.06.22.
//

import SwiftUI

// MARK: - Plain Disclosure Group UI Model
/// Model that describes UI.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct PlainDisclosureGroupUIModel {
    // MARK: Properties - Global Layout
    /// Default padding in native disclosure group. Set to `8`.
    ///
    /// Value is used during the frame calculations, and must be provided.
    ///
    /// In future releases of `iOS`/`macOS`, this value may change.
    public var defaultDisclosureGroupPadding: CGFloat = 8

    // MARK: Properties - Background
    /// Background color.
    ///
    /// Needed for setting background color to the label.
    public var backgroundColor: Color = {
#if os(iOS) || targetEnvironment(macCatalyst)
        return Color(UIColor.systemBackground)
#elseif os(macOS)
        return Color(NSColor.windowBackgroundColor)
#else
        fatalError() // Not supported
#endif
    }()

    // MARK: Properties - Transition
    /// Expand and collapse animation. Set to `default`.
    public var expandCollapseAnimation: Animation? = .default

    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}
}
