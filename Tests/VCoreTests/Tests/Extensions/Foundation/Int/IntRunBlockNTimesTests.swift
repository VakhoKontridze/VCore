//
//  IntRunBlockNTimesTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct IntRunBlockNTimesTests {
    @Test
    func testBlock() {
        let number: Int = 5
        
        var sum: Int = 0
        number.times { sum += 1 }
        
        #expect(sum == 5)
    }
    
    @Test
    func testBlockNumbered() {
        let number: Int = 5
        
        var sum: Int = 0
        number.times { sum += $0 }
        
        #expect(sum == 10)
    }
}
