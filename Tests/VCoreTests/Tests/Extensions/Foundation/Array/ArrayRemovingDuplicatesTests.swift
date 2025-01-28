//
//  ArrayRemovingDuplicatesTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct ArrayRemovingDuplicatesTests {
    @Test
    func test() {
        #expect(
            [1, 1, 3, 5, 5].removingDuplicates() ==
            [1, 3, 5]
        )
        
        do {
            var array: [Int] = [1, 1, 3, 5, 5]
            array.removeDuplicates()

            #expect(array == [1, 3, 5])
        }
    }
}
