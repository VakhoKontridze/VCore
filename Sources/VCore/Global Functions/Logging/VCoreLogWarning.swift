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
    file: String = #file,
    line: Int = #line,
    function: String = #function
) {
    let file: String = file.components(separatedBy: "/").last ?? file
    
    NSLog("[VCore] Warning in \(function) in \(file)(\(line)): \(message)")
}
