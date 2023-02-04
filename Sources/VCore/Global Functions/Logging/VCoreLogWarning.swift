//
//  VCoreLogWarning.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.02.23.
//

import Foundation

/// Logs a warning message to the Apple System Log facility.
///
///     VCoreLogError(error)
///
public func VCoreLogWarning(
    _ description: String,
    file: String = #file,
    line: Int = #line,
    function: String = #function
) {
    let file: String = file.components(separatedBy: "/").last ?? file
    
    NSLog("[VCore] Warning in \(function) in \(file)(\(line)): \(description)")
}
