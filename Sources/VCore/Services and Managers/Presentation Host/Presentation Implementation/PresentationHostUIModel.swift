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
    // MARK: Properties - Hit Tests
    /// Indicates if modal allows hit tests. Set to `true`.
    public var allowsHitTests: Bool = true

    // MARK: Properties - Keyboard
    /// Indicates if keyboard responsiveness is handled internally. Set to `true`.
    ///
    /// Changing this property after modal is presented may cause unintended behaviors.
    ///
    /// When `true`, all `Edge.Set` properties must be set to `all`.
    public var isKeyboardResponsivenessHandledInternally: Bool = true

    // MARK: Properties - Safe Area
    /// Container safe area edges ignored by host. Set to `all`.
    ///
    /// For `iOS` `13.x` and lower, use `ignoresSafeArea`.
    ///
    /// Property can conflict with `isKeyboardResponsivenessHandledInternally`.
    @available(iOS 14.0, *)
    public var ignoredContainerSafeAreaEdgesByHost: Edge.Set {
        get { _ignoredContainerSafeAreaEdgesByHost }
        set { _ignoredContainerSafeAreaEdgesByHost = newValue }
    }
    var _ignoredContainerSafeAreaEdgesByHost: Edge.Set = .all

    /// Keyboard safe area edges ignored by host. Set to `all`.
    ///
    /// For `iOS` `13.x` and lower, use `ignoresSafeArea`.
    ///
    /// Property can conflict with `isKeyboardResponsivenessHandledInternally`.
    @available(iOS 14.0, *)
    public var ignoredKeyboardSafeAreaEdgesByHost: Edge.Set {
        get { _ignoredKeyboardSafeAreaEdgesByHost }
        set { _ignoredKeyboardSafeAreaEdgesByHost = newValue }
    }
    var _ignoredKeyboardSafeAreaEdgesByHost: Edge.Set = .all

    /// Safe area edges ignored by host. Set to `all`.
    ///
    /// For `iOS` `14.0` and up, use `ignoredContainerSafeAreaEdgesByHost` and `ignoredKeyboardSafeAreaEdgesByHost`.
    ///
    /// Property can conflict with `isKeyboardResponsivenessHandledInternally`.
    public var ignoredKeyboardSafeAreaEdges: Edge.Set = .all

    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}
}
