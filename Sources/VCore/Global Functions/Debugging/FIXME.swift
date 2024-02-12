//
//  FIXME.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 31.12.23.
//

import Foundation

// MARK: - FIXME
/// Calls `fatalError` because feature is not implemented.
///
///     func didTapContinueButton() {
///         FIXME()
///     }
///
public func FIXME(
    _ message: @autoclosure () -> String? = nil
) -> Never {
    var string: String = "FIXME not implemented"
    message().map { string += ": \($0)" }

    fatalError(string)
}
