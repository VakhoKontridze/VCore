//
//  UIActionSheetButtonConvertible.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.23.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Action Sheet Button Convertible
/// Type that allows for conversion to `UIActionSheetButtonProtocol`.
public protocol UIActionSheetButtonConvertible {
    /// Converts self to `UIActionSheetButtonProtocol` `Array`.
    func toButtons() -> [any UIActionSheetButtonProtocol]
}

extension UIActionSheetButton: UIActionSheetButtonConvertible {
    public func toButtons() -> [any UIActionSheetButtonProtocol] { [self] }
}

extension Array: UIActionSheetButtonConvertible where Element == any UIActionSheetButtonProtocol {
    public func toButtons() -> [any UIActionSheetButtonProtocol] { self }
}

#endif
