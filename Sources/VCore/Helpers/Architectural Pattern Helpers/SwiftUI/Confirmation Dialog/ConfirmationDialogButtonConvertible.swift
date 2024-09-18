//
//  ConfirmationDialogButtonConvertible.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.23.
//

import SwiftUI

// MARK: - Confirmation Dialog Button Convertible
/// Type that allows for conversion to `ConfirmationDialogButtonProtocol`.
@MainActor
public protocol ConfirmationDialogButtonConvertible {
    /// Converts self to `ConfirmationDialogButtonProtocol` `Array`.
    func toButtons() -> [any ConfirmationDialogButtonProtocol]
}

extension Array: ConfirmationDialogButtonConvertible where Element == any ConfirmationDialogButtonProtocol {
    public func toButtons() -> [any ConfirmationDialogButtonProtocol] { self }
}

extension EmptyView: ConfirmationDialogButtonConvertible {
    public func toButtons() -> [any ConfirmationDialogButtonProtocol] { [] }
}
