//
//  StringProtocolDiacriticInsensitiveStringTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

import Foundation
import Testing
@testable import VCore

@Suite
struct StringProtocolDiacriticInsensitiveStringTests {
    @Test
    func test() {
        #expect("À".diacriticInsensitiveString() == "A")
    }
}
