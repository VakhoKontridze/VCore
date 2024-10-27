//
//  UIAlertButtonProtocol.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.23.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Alert Button Protocol
/// `UIAlertController` button protocol.
public protocol UIAlertButtonProtocol: UIAlertButtonConvertible {
    /// Converts `UIAlertButtonProtocol` to `UIAlertAction`.
    @MainActor
    func makeBody() -> UIAlertAction
}

extension UIAlertButtonProtocol {
    public func toButtons() -> [any UIAlertButtonProtocol] {
        [self]
    }
}

#endif
