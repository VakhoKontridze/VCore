//
//  CollectionFirstAndLastElementOfTypeTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 29.11.22.
//

import Foundation
import Testing
@testable import VCore

@Suite
nonisolated struct CollectionFirstAndLastElementOfTypeTests {
    // MARK: Properties
    private let array: [any P] = [
        S1(value: 1),
        S1(value: 2),
        S2(value: 3),
        S2(value: 4),
        S1(value: 5),
        S1(value: 6)
    ]
    
    // MARK: Tests
    @Test
    func testFirstElement() {
        #expect(array.firstElement(ofType: S1.self)?.value == 1)
        #expect(array.firstElement(ofType: S1.self) { $0.value > 1 }?.value == 2)
    }

    @Test
    func testLastElement() {
        #expect(array.lastElement(ofType: S1.self)?.value == 6)
        #expect(array.lastElement(ofType: S1.self) { $0.value < 6 }?.value == 5)
    }
    
    // MARK: Types
    private nonisolated protocol P {
        var value: Int { get }
    }
    
    private nonisolated struct S1: P {
        let value: Int
    }
    
    private nonisolated struct S2: P {
        let value: Int
    }
}
