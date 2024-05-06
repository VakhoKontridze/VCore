//
//  UIActionSheetButtonProtocol.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.23.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Action Sheet Button Protocol
/// `UIActionSheetController` button protocol.
public protocol UIActionSheetButtonProtocol: UIActionSheetButtonConvertible {
    /// Converts `UIActionSheetButtonProtocol` to `UIAlertAction`.
    func makeBody() -> UIAlertAction
}

extension UIActionSheetButtonProtocol {
    public func toButtons() -> [any UIActionSheetButtonProtocol] { [self] }
}

#endif
