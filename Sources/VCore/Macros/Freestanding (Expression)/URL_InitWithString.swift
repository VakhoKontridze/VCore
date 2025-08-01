//
//  URL_InitWithString.swift
//  VCoreMacrosImplementation
//
//  Created by Vakhtang Kontridze on 07.01.24.
//

import Foundation

/// Returns non-optional `URL` from `String`, checked during the compile time.
///
///     let url: URL = #url("https://website.com")
///
@freestanding(expression)
public macro url(
    _ urlString: String
) -> URL = #externalMacro(
    module: "VCoreMacrosImplementation",
    type: "URLMacro_InitWithString"
)
