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
    dsohandle: UnsafeRawPointer = #dsohandle,
    file: String = #file,
    line: UInt = #line,
    function: String = #function
) -> Never {
#if DEBUG
    let module: String = moduleDescription(
        dsohandle: dsohandle
    )

    let callSite: String = callSiteDescription(
        file: file,
        line: line,
        function: function
    )

    var string: String = ""
    string += "[\(module)] FIXME not implemented in '\(callSite)'"
    message.map { string += ": \($0)" }

    NSLog(string)
#endif

    fatalError()
}
