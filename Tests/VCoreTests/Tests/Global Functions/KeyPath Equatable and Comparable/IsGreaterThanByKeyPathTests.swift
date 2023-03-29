//
//  IsGreaterThanByKeyPathTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 18.06.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class IsGreaterThanByKeyPathTests: XCTestCase {
    // MARK: Test Data
    private typealias SomeObject = IsEqualToByKeyPathTests.SomeObject

    // MARK: Tests
    func test1() {
        XCTAssertTrue(VCore.isGreater(
            SomeObject(),
            than: SomeObject(a: -1),
            by: \.a
        ))
        
        XCTAssertFalse(VCore.isGreater(
            SomeObject(),
            than: SomeObject(),
            by: \.a
        ))
    }
    
    func test2() {
        XCTAssertTrue(VCore.isGreater(
            SomeObject(),
            than: SomeObject(b: -1),
            by: \.a, \.b
        ))
        
        XCTAssertFalse(VCore.isGreater(
            SomeObject(),
            than: SomeObject(),
            by: \.a, \.b
        ))
    }
    
    func test3() {
        XCTAssertTrue(VCore.isGreater(
            SomeObject(),
            than: SomeObject(c: -1),
            by: \.a, \.b, \.c
        ))
        
        XCTAssertFalse(VCore.isGreater(
            SomeObject(),
            than: SomeObject(),
            by: \.a, \.b, \.c
        ))
    }
    
    func test4() {
        XCTAssertTrue(VCore.isGreater(
            SomeObject(),
            than: SomeObject(d: -1),
            by: \.a, \.b, \.c, \.d
        ))
        
        XCTAssertFalse(VCore.isGreater(
            SomeObject(),
            than: SomeObject(),
            by: \.a, \.b, \.c, \.d
        ))
    }
    
    func test5() {
        XCTAssertTrue(VCore.isGreater(
            SomeObject(),
            than: SomeObject(e: -1),
            by: \.a, \.b, \.c, \.d, \.e
        ))
        
        XCTAssertFalse(VCore.isGreater(
            SomeObject(),
            than: SomeObject(),
            by: \.a, \.b, \.c, \.d, \.e
        ))
    }
    
    func test6() {
        XCTAssertTrue(VCore.isGreater(
            SomeObject(),
            than: SomeObject(f: -1),
            by: \.a, \.b, \.c, \.d, \.e, \.f
        ))
        
        XCTAssertFalse(VCore.isGreater(
            SomeObject(),
            than: SomeObject(),
            by: \.a, \.b, \.c, \.d, \.e, \.f
        ))
    }
    
    func test7() {
        XCTAssertTrue(VCore.isGreater(
            SomeObject(),
            than: SomeObject(g: -1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g
        ))
        
        XCTAssertFalse(VCore.isGreater(
            SomeObject(),
            than: SomeObject(),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g
        ))
    }
    
    func test8() {
        XCTAssertTrue(VCore.isGreater(
            SomeObject(),
            than: SomeObject(h: -1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h
        ))
        
        XCTAssertFalse(VCore.isGreater(
            SomeObject(),
            than: SomeObject(),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h
        ))
    }
    
    func test9() {
        XCTAssertTrue(VCore.isGreater(
            SomeObject(),
            than: SomeObject(i: -1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i
        ))
        
        XCTAssertFalse(VCore.isGreater(
            SomeObject(),
            than: SomeObject(),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i
        ))
    }
    
    func test10() {
        XCTAssertTrue(VCore.isGreater(
            SomeObject(),
            than: SomeObject(j: -1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i, \.j
        ))
        
        XCTAssertFalse(VCore.isGreater(
            SomeObject(),
            than: SomeObject(),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i, \.j
        ))
    }
}
