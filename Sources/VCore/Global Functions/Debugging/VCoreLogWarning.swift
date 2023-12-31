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
    _ message: String,
    dsohandle: UnsafeRawPointer = #dsohandle,
    file: String = #file,
    line: UInt = #line,
    function: String = #function
) {
#if DEBUG
    let module: String = moduleDescription(
        dsohandle: dsohandle
    )

    let callSite: String = callSiteDescription(
        file: file,
        line: line,
        function: function
    )

    NSLog("[\(module)] Warning in '\(callSite)': \(message)")
#endif
}
