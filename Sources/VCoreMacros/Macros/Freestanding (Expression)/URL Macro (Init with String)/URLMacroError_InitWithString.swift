//
//  URLMacroError_InitWithString.swift
//  VCoreMacros
//
//  Created by Vakhtang Kontridze on 02.03.24.
//

import Foundation

// MARK: - URL Macro Error (Init with String)
struct URLMacroError_InitWithString: Error, CustomStringConvertible {
    // MARK: Properties
    let description: String

    // MARK: Initializers
    private init(
        _ description: String
    ) {
        self.description = description
    }

    static var invalidURLStringParameter: Self { .init("Invalid 'URL' 'String' parameter") }
    static var malformedURL: Self { .init("Malformed 'URL'") }
}
