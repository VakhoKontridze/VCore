//
//  AlertButtonConvertible.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.05.23.
//

import SwiftUI

// MARK: - Alert Button Convertible
/// Type that allows for conversion to `AlertButton`.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public protocol AlertButtonConvertible {
    /// Converts self to `AlertButton` `Array`.
    func toButtons() -> [AlertButton]
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension AlertButton: AlertButtonConvertible {
    public func toButtons() -> [AlertButton] { [self] }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension Array: AlertButtonConvertible where Element == AlertButton {
    public func toButtons() -> [AlertButton] { self }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension EmptyView: AlertButtonConvertible {
    public func toButtons() -> [AlertButton] { [] }
}
