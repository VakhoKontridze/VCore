//
//  UIView.WithTranslatesAutoresizingMaskIntoConstraints.swift
//  
//  VCore
//  Created by Vakhtang Kontridze on 10.06.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI View with Translates Autoresizing Mask into Constraints
extension UIView {
    /// Applies flag to `translatesAutoresizingMaskIntoConstraints` property of `UIView`, and returns it.
    ///
    ///     let button: UILabel = .init()
    ///         .withTranslatesAutoresizingMaskIntoConstraints(false)
    ///
    public func withTranslatesAutoresizingMaskIntoConstraints(_ flag: Bool) -> Self {
        translatesAutoresizingMaskIntoConstraints = flag
        return self
    }
}

#endif
