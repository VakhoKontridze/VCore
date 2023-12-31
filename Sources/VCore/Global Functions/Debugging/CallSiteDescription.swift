//
//  CallSiteDescription.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 31.12.23.
//

import Foundation

// MARK: - Call Site Description
func callSiteDescription(
    file: String,
    line: Int,
    function: String
) -> String {
    let file: String = file.components(separatedBy: "/").last ?? file
    return "\(function)' in '\(file)(\(line))"
}
