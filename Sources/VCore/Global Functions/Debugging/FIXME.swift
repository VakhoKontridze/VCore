//
//  FIXME.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 31.12.23.
//

import Foundation

/// Calls `fatalError` because feature is not implemented.
///
///     func doSomething() {
///         FIXME()
///     }
///
public nonisolated func FIXME(
    _ message: String? = nil
) -> Never {
    var string: String = "FIXME not implemented"
    message.map { string += ": \($0)" }

    fatalError(string) // Unsafe (intentional)
}
