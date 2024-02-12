//
//  TODO.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import Foundation

// MARK: - TODO
/// Calls `fatalError` because feature is not implemented.
///
///     func didTapContinueButton() {
///         TODO()
///     }
///
public func TODO(
    _ message: String? = nil
) -> Never {
    var string: String = "TODO not implemented"
    message.map { string += ": \($0)" }

    fatalError(string)
}
