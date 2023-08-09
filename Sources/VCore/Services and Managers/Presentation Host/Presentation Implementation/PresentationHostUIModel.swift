//
//  PresentationHostUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 09.08.23.
//

import SwiftUI

// MARK: - Presentation Host UI Model
/// Model that describes UI.
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct PresentationHostUIModel {
    // MARK: Properties
    /// Indicates if modal allows hit tests. Set to `true`.
    public var allowsHitTests: Bool = true

    /// Indicates if keyboard responsiveness is handled internally. Set to `true`.
    ///
    /// Changing this property after modal is presented may cause unintended behaviors.
    ///
    /// When `true`, `ignoredContainerSafeAreaEdgesByHost` and `ignoredKeyboardSafeAreaEdgesByHost` must be set to `all`
    public var isKeyboardResponsivenessHandledInternally: Bool = true

    /// Container edges ignored by host. Set to `all`.
    @available(iOS 14.0, *)
    public var ignoredContainerSafeAreaEdgesByHost: Edge.Set {
        get { _ignoredContainerSafeAreaEdgesByHost }
        set { _ignoredContainerSafeAreaEdgesByHost = newValue }
    }
    var _ignoredContainerSafeAreaEdgesByHost: Edge.Set = .all

    /// Keyboard edges ignored by host. Set to `all`.
    @available(iOS 14.0, *)
    public var ignoredKeyboardSafeAreaEdgesByHost: Edge.Set {
        get { _ignoredKeyboardSafeAreaEdgesByHost }
        set { _ignoredKeyboardSafeAreaEdgesByHost = newValue }
    }
    var _ignoredKeyboardSafeAreaEdgesByHost: Edge.Set = .all

    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}
}
