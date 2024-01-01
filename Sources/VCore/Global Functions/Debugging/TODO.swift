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
    _ message: @autoclosure () -> String? = nil,
    fileID: String = #fileID,
    file: String = #file,
    line: UInt = #line,
    function: String = #function
) -> Never {
#if DEBUG
    let module: String = moduleDescription(
        fileID: fileID
    )

    let callSite: String = callSiteDescription(
        file: file,
        line: line,
        function: function
    )

    var string: String = "[\(module)] TODO not implemented in '\(callSite)'"
    message().map { string += ": \($0)" }

    NSLog(string)
#endif

    fatalError()
}
