//
//  URLMacro.swift
//  VCoreMacros
//
//  Created by Vakhtang Kontridze on 07.01.24.
//

import Foundation

// MARK: - URL Macro
/// Returns non-optional `URL` from a `String`, checked during the compile time.
///
///     let url: URL = #url("https://example.com")
///
@freestanding(expression)
public macro url(
    _ urlString: String
) -> URL = #externalMacro(
    module: "VCoreMacros",
    type: "URLMacro"
)
