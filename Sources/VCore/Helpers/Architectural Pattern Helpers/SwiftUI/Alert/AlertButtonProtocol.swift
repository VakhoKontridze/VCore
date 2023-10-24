//
//  AlertButtonProtocol.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.23.
//

import SwiftUI

// MARK: - Alert Button Protocol
/// `Alert` button protocol.
public protocol AlertButtonProtocol: AlertButtonConvertible {
    /// The stable identity of the entity associated with this instance.
    var id: Int { get }

    /// Body type.
    typealias Body = AnyView

    /// Creates a `View` that represents the body of a button.
    func makeBody(
        animateOutHandler: @escaping (/*completion*/ (() -> Void)?) -> Void
    ) -> Body
}

extension AlertButtonProtocol {
    public func toButtons() -> [any AlertButtonProtocol] { [self] }
}
