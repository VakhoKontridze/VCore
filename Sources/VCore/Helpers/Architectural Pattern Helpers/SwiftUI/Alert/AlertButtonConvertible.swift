//
//  AlertButtonConvertible.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.23.
//

import SwiftUI

// MARK: - Alert Button Convertible
/// Type that allows for conversion to `AlertButtonProtocol`.
@MainActor
public protocol AlertButtonConvertible {
    /// Converts self to `AlertButtonProtocol` `Array`.
    func toButtons() -> [any AlertButtonProtocol]
}

extension Array: AlertButtonConvertible where Element == any AlertButtonProtocol {
    public func toButtons() -> [any AlertButtonProtocol] { self }
}

extension EmptyView: AlertButtonConvertible {
    public func toButtons() -> [any AlertButtonProtocol] { [] }
}
