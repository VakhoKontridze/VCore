//
//  PlainDisclosureGroupUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 22.06.22.
//

import SwiftUI

// MARK: - Plain Disclosure Group UI Model
/// Model that describes UI.
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct PlainDisclosureGroupUIModel {
    // MARK: Properties - Global
    /// Content height in system disclosure group which includes the chevron button. Set to `14`.
    ///
    /// Value is used during the frame calculations, and must be provided.
    ///
    /// To achieve desired result, label height must be greater than or equal to `systemDisclosureGroupContentHeight` + `systemDisclosureGroupPadding`.
    ///
    /// In future OS releases, this value may change.
    public var systemDisclosureGroupContentHeight: CGFloat = 14

    /// Padding in system disclosure group. Set to `8`.
    ///
    /// Value is used during the frame calculations, and must be provided.
    ///
    /// To achieve desired result, label height must be greater than or equal to `systemDisclosureGroupContentHeight` + `systemDisclosureGroupPadding`.
    ///
    /// In future OS releases, this value may change.
    public var systemDisclosureGroupPadding: CGFloat = 8

    // MARK: Properties - Background
    /// Background color.
    ///
    /// Needed for setting background color to the label.
    public var backgroundColor: Color = {
#if os(iOS)
        Color(uiColor: UIColor.systemBackground)
#elseif os(macOS)
        Color.clear
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
