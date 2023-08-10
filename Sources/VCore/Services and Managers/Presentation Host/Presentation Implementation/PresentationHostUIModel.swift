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
    ///
    /// For `false` to have an effect, underlying `SwiftUI` `View` shouldn't have gestures.
    public var allowsHitTests: Bool = true

    // MARK: Properties - Safe Area
    /// Indicates if Presentation Host handles keyboard responsiveness. Set to `true`.
    ///
    /// Changing this property after modal is presented may cause unintended behaviors.
    ///
    /// When `true`, all `Edge.Set` properties must be set to `all`.
    public var handlesKeyboardResponsiveness: Bool = true

    /// Keyboard safe area inset on focused view. Set to `20`.
    public var focusedViewKeyboardSafeAreInset: CGFloat = 20

    /// Container safe area edges ignored by the Presentation Host. Set to `all`.
    ///
    /// For `iOS` `13.x` and lower, use `ignoresSafeArea`.
    ///
    /// Property can conflict with `handlesKeyboardResponsiveness`.
    @available(iOS 14.0, *)
    public var ignoredContainerSafeAreaEdges: Edge.Set {
        get { _ignoredContainerSafeAreaEdges }
        set { _ignoredContainerSafeAreaEdges = newValue }
    }
    var _ignoredContainerSafeAreaEdges: Edge.Set = .all

    /// Keyboard safe area edges ignored by the Presentation Host. Set to `all`.
    ///
    /// For `iOS` `13.x` and lower, use `ignoresSafeArea`.
    ///
    /// Property can conflict with `handlesKeyboardResponsiveness`.
    @available(iOS 14.0, *)
    public var ignoredKeyboardSafeAreaEdges: Edge.Set {
        get { _ignoredKeyboardSafeAreaEdges }
        set { _ignoredKeyboardSafeAreaEdges = newValue }
    }
    var _ignoredKeyboardSafeAreaEdges: Edge.Set = .all

    /// Safe area edges ignored by the Presentation Host. Set to `all`.
    ///
    /// For `iOS` `14.0` and up, use `ignoredContainerSafeAreaEdges` and `ignoredKeyboardSafeAreaEdges`.
    ///
    /// Property can conflict with `handlesKeyboardResponsiveness`.
    public var ignoredSafeAreaEdges: Edge.Set = .all

    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}
}
