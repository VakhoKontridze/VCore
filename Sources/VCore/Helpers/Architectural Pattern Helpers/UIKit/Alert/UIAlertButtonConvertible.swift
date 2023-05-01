//
//  UIAlertButtonConvertible.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.23.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Alert Button Convertible
/// Type that allows for conversion to `UIAlertButton`.
public protocol UIAlertButtonConvertible {
    /// Converts self to `UIAlertButton` `Array`.
    func toButtons() -> [UIAlertButton]
}

extension UIAlertButton: UIAlertButtonConvertible {
    public func toButtons() -> [UIAlertButton] { [self] }
}

extension Array: UIAlertButtonConvertible where Element == UIAlertButton {
    public func toButtons() -> [UIAlertButton] { self }
}

#endif
