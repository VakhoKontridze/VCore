//
//  AlertButtonConvertible.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.23.
//

import SwiftUI

// MARK: - Alert Button Convertible
/// Type that allows for conversion to `AlertButtonProtocol`.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public protocol AlertButtonConvertible {
    /// Converts self to `AlertButtonProtocol` `Array`.
    func toButtons() -> [any AlertButtonProtocol]
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension Array: AlertButtonConvertible where Element == any AlertButtonProtocol {
    public func toButtons() -> [any AlertButtonProtocol] { self }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension EmptyView: AlertButtonConvertible {
    public func toButtons() -> [any AlertButtonProtocol] { [] }
}
