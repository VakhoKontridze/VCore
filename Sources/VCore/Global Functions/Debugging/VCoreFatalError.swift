//
//  VCoreFatalError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11.09.23.
//

import Foundation

// MARK: - V Core Fatal Error
/// Logs an error message to the Apple System Log facility and stops execution.
///
///     VCoreFatalError(error)
///
public func VCoreFatalError(
    _ items: Any...,
    dsohandle: UnsafeRawPointer = #dsohandle,
    file: String = #file,
    line: UInt = #line,
    function: String = #function
) -> Never {
    VCoreLogError(items, dsohandle: dsohandle, file: file, line: line, function: function)
    fatalError()
}
