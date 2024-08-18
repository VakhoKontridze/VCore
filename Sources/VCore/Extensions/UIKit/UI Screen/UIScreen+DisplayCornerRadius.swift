//
//  UIScreen+DisplayCornerRadius.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/9/21.
//

#if canImport(UIKit) && !(os(watchOS) || os(visionOS))

import UIKit

// MARK: - UI Screen + Display Corner Radius
extension UIScreen {
    /// The corner radius of the display.
    ///
    /// Can be used to round corner of half modal component.
    /// Accessed private API and may be deprecated.
    ///
    ///     view.window?.screen.displayCornerRadius.map {
    ///         view.roundCorners(.layerMinYCorners, by: $0)
    ///     }
    ///
    public var displayCornerRadius: CGFloat? {
        value(forKey: "_displayCornerRadius") as? CGFloat
    }
}

#endif
