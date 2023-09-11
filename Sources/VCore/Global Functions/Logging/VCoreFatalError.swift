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
    module: String = "VCore",
    file: String = #file,
    line: Int = #line,
    function: String = #function
) -> Never {
    VCoreLogError(items, module: module, file: file, line: line, function: function)
    fatalError()
}
