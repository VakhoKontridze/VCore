//
//  UIAlertButtonConvertible.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.23.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Alert Button Convertible
/// Type that allows for conversion to `UIAlertButtonProtocol`.
public protocol UIAlertButtonConvertible {
    /// Converts self to `UIAlertButtonProtocol` `Array`.
    func toButtons() -> [any UIAlertButtonProtocol]
}

extension Array: UIAlertButtonConvertible where Element == any UIAlertButtonProtocol {
    public func toButtons() -> [any UIAlertButtonProtocol] {
        self
    }
}

extension Never: UIAlertButtonConvertible {
    public func toButtons() -> [any UIAlertButtonProtocol] {
        fatalError()
    }
}

#endif
