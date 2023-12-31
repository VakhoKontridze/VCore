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

    let string: String = {
        var string: String = ""
        
        string += "[\(module)] TODO not implemented in '\(callSite)'"

        message.map { string += ": \($0)" }

        return string
    }()

    NSLog(string)
#endif

    fatalError()
}
