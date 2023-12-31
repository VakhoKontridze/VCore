//
//  DebugDescriptions.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 31.12.23.
//

import Foundation

// MARK: - Call Site Description
func callSiteDescription(
    file: String,
    line: UInt,
    function: String
) -> String {
    let file: String = file.components(separatedBy: "/").last ?? file

    return "\(function)' in '\(file)(\(line))"
}

// MARK: - Module Description
func moduleDescription(
    dsohandle: UnsafeRawPointer = #dsohandle
) -> String {
    var dlInfo: dl_info = .init()
    let _ = dladdr(dsohandle, &dlInfo)

    let filePath: String = .init(cString: dlInfo.dli_fname)
    let bundleURL: URL = .init(fileURLWithPath: filePath).deletingLastPathComponent()
    guard
        let bundle: Bundle = .init(url: bundleURL),
        let bundleID: String = bundle.bundleIdentifier
    else {
        return "VCore"
    }
    let bundleName: String = bundleID.components(separatedBy: ".").last ?? bundleID

    return bundleName
}
