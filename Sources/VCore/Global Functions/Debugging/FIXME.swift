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
    string += "FIXME: Feature not implemented in '\(callSite)'"
    message.map { string += ": \($0)" }

    fatalError(string)
}
