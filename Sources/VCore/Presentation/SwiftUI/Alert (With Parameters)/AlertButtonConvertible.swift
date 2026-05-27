//
//  AlertButtonConvertible.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.23.
//

public import SwiftUI

/// Type that allows for conversion to `AlertButtonProtocol`.
public protocol AlertButtonConvertible {
    /// Converts self to `AlertButtonProtocol` `Array`.
    func toButtons() -> [any AlertButtonProtocol]
}

extension [any AlertButtonProtocol]: AlertButtonConvertible {
    public func toButtons() -> [any AlertButtonProtocol] {
        self
    }
}

extension Never: AlertButtonConvertible {
    public func toButtons() -> [any AlertButtonProtocol] {
        fatalError()
    }
}

extension EmptyView: AlertButtonConvertible {
    public func toButtons() -> [any AlertButtonProtocol] {
        []
    }
}
