//
//  TODO.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import Foundation

/// Throws `fatalError` that feature is not implemented
public func TODO(_ message: String? = nil) -> Never {
    fatalError(message ?? "TODO: Not implemented")
}
