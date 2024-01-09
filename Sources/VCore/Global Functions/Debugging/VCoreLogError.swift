//
//  VCoreLogError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11.09.22.
//

import Foundation

// MARK: - V Core Log Error
/// Logs an error message to the Apple System Log facility.
///
///     VCoreLogError(error)
///
public func VCoreLogError(
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

    let string: String = "[\(module)] Error in '\(function)' at '\(callSite)': \(message)"

    NSLog(string)
#endif
}
