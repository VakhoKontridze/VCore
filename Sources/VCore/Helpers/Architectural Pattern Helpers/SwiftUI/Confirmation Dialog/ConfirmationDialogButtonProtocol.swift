//
//  ConfirmationDialogButtonProtocol.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.23.
//

import SwiftUI

// MARK: - Confirmation Dialog Button Protocol
/// `ConfirmationDialog` button protocol.
public protocol ConfirmationDialogButtonProtocol: ConfirmationDialogButtonConvertible {
    /// Body type.
    typealias Body = AnyView

    /// Creates a `View` that represents the body of a button.
    func makeBody(
        animateOutHandler: @escaping (/*completion*/ (() -> Void)?) -> Void
    ) -> Body
}

extension ConfirmationDialogButtonProtocol {
    public func toButtons() -> [any ConfirmationDialogButtonProtocol] { [self] }
}
