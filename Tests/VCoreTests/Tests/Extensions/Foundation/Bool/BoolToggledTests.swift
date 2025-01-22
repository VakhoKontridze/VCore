//
//  BoolToggledTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 03.09.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct BoolToggledTests {
    @Test
    func test() {
        #expect(false.toggled() == true)
        #expect(true.toggled() == false)
    }
}
