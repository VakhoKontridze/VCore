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
    private struct Object {
        var a: Int = 0
        var b: Int = 0
        var c: Int = 0
        var d: Int = 0
        var e: Int = 0
        var f: Int = 0
        var g: Int = 0
        var h: Int = 0
        var i: Int = 0
        var j: Int = 0
    }

    // MARK: Tests
    func test1() {
        XCTAssertTrue(VCore.isGreater(
            Object(),
            than: Object(a: -1),
            by: \.a
        ))
        
        XCTAssertFalse(VCore.isGreater(
            Object(),
            than: Object(),
            by: \.a
        ))
    }
    
    func test2() {
        XCTAssertTrue(VCore.isGreater(
            Object(),
            than: Object(b: -1),
            by: \.a, \.b
        ))
        
        XCTAssertFalse(VCore.isGreater(
            Object(),
            than: Object(),
            by: \.a, \.b
        ))
    }
    
    func test3() {
        XCTAssertTrue(VCore.isGreater(
            Object(),
            than: Object(c: -1),
            by: \.a, \.b, \.c
        ))
        
        XCTAssertFalse(VCore.isGreater(
            Object(),
            than: Object(),
            by: \.a, \.b, \.c
        ))
    }
    
    func test4() {
        XCTAssertTrue(VCore.isGreater(
            Object(),
            than: Object(d: -1),
            by: \.a, \.b, \.c, \.d
        ))
        
        XCTAssertFalse(VCore.isGreater(
            Object(),
            than: Object(),
            by: \.a, \.b, \.c, \.d
        ))
    }
    
    func test5() {
        XCTAssertTrue(VCore.isGreater(
            Object(),
            than: Object(e: -1),
            by: \.a, \.b, \.c, \.d, \.e
        ))
        
        XCTAssertFalse(VCore.isGreater(
            Object(),
            than: Object(),
            by: \.a, \.b, \.c, \.d, \.e
        ))
    }
    
    func test6() {
        XCTAssertTrue(VCore.isGreater(
            Object(),
            than: Object(f: -1),
            by: \.a, \.b, \.c, \.d, \.e, \.f
        ))
        
        XCTAssertFalse(VCore.isGreater(
            Object(),
            than: Object(),
            by: \.a, \.b, \.c, \.d, \.e, \.f
        ))
    }
    
    func test7() {
        XCTAssertTrue(VCore.isGreater(
            Object(),
            than: Object(g: -1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g
        ))
        
        XCTAssertFalse(VCore.isGreater(
            Object(),
            than: Object(),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g
        ))
    }
    
    func test8() {
        XCTAssertTrue(VCore.isGreater(
            Object(),
            than: Object(h: -1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h
        ))
        
        XCTAssertFalse(VCore.isGreater(
            Object(),
            than: Object(),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h
        ))
    }
    
    func test9() {
        XCTAssertTrue(VCore.isGreater(
            Object(),
            than: Object(i: -1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i
        ))
        
        XCTAssertFalse(VCore.isGreater(
            Object(),
            than: Object(),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i
        ))
    }
    
    func test10() {
        XCTAssertTrue(VCore.isGreater(
            Object(),
            than: Object(j: -1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i, \.j
        ))
        
        XCTAssertFalse(VCore.isGreater(
            Object(),
            than: Object(),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i, \.j
        ))
    }
}
