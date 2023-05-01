//
//  UIActionSheetButtonConvertible.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.23.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Action Sheet Button Convertible
/// Type that allows for conversion to `UIActionSheetButton`.
public protocol UIActionSheetButtonConvertible {
    /// Converts self to `UIActionSheetButton` `Array`.
    func toButtons() -> [UIActionSheetButton]
}

extension UIActionSheetButton: UIActionSheetButtonConvertible {
    public func toButtons() -> [UIActionSheetButton] { [self] }
}

extension Array: UIActionSheetButtonConvertible where Element == UIActionSheetButton {
    public func toButtons() -> [UIActionSheetButton] { self }
}

#endif
