//
//  ConfirmationDialogButtonProtocol.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.23.
//

import SwiftUI

// MARK: - Confirmation Dialog Button Protocol
/// `ConfirmationDialog` button protocol.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public protocol ConfirmationDialogButtonProtocol: ConfirmationDialogButtonConvertible {
    /// Body type.
    typealias Body = AnyView

    /// Creates a `View` that represents the body of a button.
    func makeBody(
        animateOut: @escaping (/*completion*/ (() -> Void)?) -> Void
    ) -> Body
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension ConfirmationDialogButtonProtocol {
    public func toButtons() -> [any ConfirmationDialogButtonProtocol] { [self] }
}
