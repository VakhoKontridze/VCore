//
//  VCoreLogWarning.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.02.23.
//

import Foundation

// MARK: - V Core Log Warning
/// Logs a warning message to the Apple System Log facility.
///
///     VCoreLogWarning(error)
///
public func VCoreLogWarning(
    _ items: Any...,
    fileID: String = #fileID,
    file: String = #file,
    line: UInt = #line,
    function: String = #function
) {
#if DEBUG
    let module: String = moduleDescription(
        fileID: fileID
    )

    let callSite: String = callSiteDescription(
        file: file,
        line: line
    )

    let message: String = .combiningDebugItems(items)

    let string: String = "[\(module)] Warning in '\(function)' at '\(callSite)': \(message)"

    NSLog(string)
#endif
}
