//
//  ConfirmationDialogButtonConvertible.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.23.
//

import SwiftUI

// MARK: - Confirmation Dialog Button Convertible
/// Type that allows for conversion to `ConfirmationDialogButtonProtocol`.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public protocol ConfirmationDialogButtonConvertible {
    /// Converts self to `ConfirmationDialogButtonProtocol` `Array`.
    func toButtons() -> [any ConfirmationDialogButtonProtocol]
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension ConfirmationDialogButton: ConfirmationDialogButtonConvertible {
    public func toButtons() -> [any ConfirmationDialogButtonProtocol] { [self] }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension Array: ConfirmationDialogButtonConvertible where Element == any ConfirmationDialogButtonProtocol {
    public func toButtons() -> [any ConfirmationDialogButtonProtocol] { self }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension EmptyView: ConfirmationDialogButtonConvertible {
    public func toButtons() -> [any ConfirmationDialogButtonProtocol] { [] }
}
