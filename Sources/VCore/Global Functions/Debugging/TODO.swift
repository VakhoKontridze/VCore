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
    _ message: String? = nil,
    file: String = #file,
    line: Int = #line,
    function: String = #function
) -> Never {
    let callSite: String = callSiteDescription(
        file: file,
        line: line,
        function: function
    )

    var string: String = ""
    string += "TODO: Feature not implemented in '\(callSite)'"
    message.map { string += ": \($0)" }

    fatalError(string)
}
