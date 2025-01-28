//
//  SequenceSortedByKeyPathTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 06.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct SequenceSortedByKeyPathTests {
    // MARK: Test Data
    private struct City: Equatable {
        let name: String
    }
    
    private let array: [City] = [
        City(name: "London"),
        City(name: "Paris"),
        City(name: "New York")
    ]
    
    private let sortedArray: [City] = [
        City(name: "London"),
        City(name: "New York"),
        City(name: "Paris")
    ]
    
    // MARK: Tests
    @Test
    func test() {
        #expect(array.sorted(by: \.name) == sortedArray)
        
        do {
            var array = array
            array.sort(by: \.name)
            
            #expect(array == sortedArray)
        }
    }
}
