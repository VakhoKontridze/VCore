//
//  RawStringError.swift
//  VCoreMacrosImplementation
//
//  Created by Vakhtang Kontridze on 08.02.25.
//

import Foundation

nonisolated struct RawStringError: Error, CustomStringConvertible {
    // MARK: Properties
    let description: String
    
    // MARK: Initializers
    init(
        _ description: String
    ) {
        self.description = description
    }
}
