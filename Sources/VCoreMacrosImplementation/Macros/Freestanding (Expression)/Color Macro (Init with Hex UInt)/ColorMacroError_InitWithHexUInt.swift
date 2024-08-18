//
//  ColorMacroError_InitWithHexUInt.swift
//  VCoreMacrosImplementation
//
//  Created by Vakhtang Kontridze on 02.03.24.
//

import Foundation

// MARK: - Color Macro Error (Init with Hex U Int)
struct ColorMacroError_InitWithHexUInt: Error, CustomStringConvertible {
    // MARK: Properties
    let description: String

    // MARK: Initializers
    private init(
        _ description: String
    ) {
        self.description = description
    }

    static var invalidColorSpaceParameter: Self { .init("Invalid `colorSpace` parameter") }
    static var invalidHexParameter: Self { .init("Invalid 'hex' parameter") }
    static var invalidOpacityParameter: Self { .init("Invalid 'opacity' parameter") }
}
