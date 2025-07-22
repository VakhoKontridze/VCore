//
//  InnerShadowUIViewAppearance.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Inner Shadow UI View Appearance
/// Model that describes appearance.
public struct InnerShadowUIViewAppearance: Sendable {
    // MARK: Properties
    /// Shadow color.
    public var shadowColor: UIColor = .black.withAlphaComponent(0.1)

    /// Shadow color.
    public var shadowRadius: CGFloat = 5

    /// Shadow color.
    public var shadowOffset: CGSize = .init(width: 5, height: 5)
    
    // MARK: Initializers
    /// Initializes appearance with default values.
    public init() {}
}

#endif
