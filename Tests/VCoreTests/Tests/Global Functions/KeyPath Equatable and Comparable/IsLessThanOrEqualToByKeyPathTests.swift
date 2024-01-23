//
//  IsLessThanOrEqualToByKeyPathTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 18.06.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class IsLessThanOrEqualToByKeyPathTests: XCTestCase {
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
        XCTAssertTrue(VCore.isLessThanOrEqual(
            Object(),
            to: .init(a: 1),
            by: \.a
        ))
        
        XCTAssertTrue(VCore.isLessThanOrEqual(
            Object(),
            to: Object(),
            by: \.a
        ))
        
        XCTAssertFalse(VCore.isLessThanOrEqual(
            Object(),
            to: .init(a: -1),
            by: \.a
        ))
    }
    
    func test2() {
        XCTAssertTrue(VCore.isLessThanOrEqual(
            Object(),
            to: .init(b: 1),
            by: \.a, \.b
        ))
        
        XCTAssertTrue(VCore.isLessThanOrEqual(
            Object(),
            to: Object(),
            by: \.a, \.b
        ))
        
        XCTAssertFalse(VCore.isLessThanOrEqual(
            Object(),
            to: .init(b: -1),
            by: \.a, \.b
        ))
    }
    
    func test3() {
        XCTAssertTrue(VCore.isLessThanOrEqual(
            Object(),
            to: .init(c: 1),
            by: \.a, \.b, \.c
        ))
        
        XCTAssertTrue(VCore.isLessThanOrEqual(
            Object(),
            to: Object(),
            by: \.a, \.b, \.c
        ))
        
        XCTAssertFalse(VCore.isLessThanOrEqual(
            Object(),
            to: .init(c: -1),
            by: \.a, \.b, \.c
        ))
    }
    
    func test4() {
        XCTAssertTrue(VCore.isLessThanOrEqual(
            Object(),
            to: .init(d: 1),
            by: \.a, \.b, \.c, \.d
        ))
        
        XCTAssertTrue(VCore.isLessThanOrEqual(
            Object(),
            to: Object(),
            by: \.a, \.b, \.c, \.d
        ))
        
        XCTAssertFalse(VCore.isLessThanOrEqual(
            Object(),
            to: .init(d: -1),
            by: \.a, \.b, \.c, \.d
        ))
    }
    
    func test5() {
        XCTAssertTrue(VCore.isLessThanOrEqual(
            Object(),
            to: .init(e: 1),
            by: \.a, \.b, \.c, \.d, \.e
        ))
        
        XCTAssertTrue(VCore.isLessThanOrEqual(
            Object(),
            to: Object(),
            by: \.a, \.b, \.c, \.d, \.e
        ))
        
        XCTAssertFalse(VCore.isLessThanOrEqual(
            Object(),
            to: .init(e: -1),
            by: \.a, \.b, \.c, \.d, \.e
        ))
    }
    
    func test6() {
        XCTAssertTrue(VCore.isLessThanOrEqual(
            Object(),
            to: .init(f: 1),
            by: \.a, \.b, \.c, \.d, \.e, \.f
        ))
        
        XCTAssertTrue(VCore.isLessThanOrEqual(
            Object(),
            to: Object(),
            by: \.a, \.b, \.c, \.d, \.e, \.f
        ))
        
        XCTAssertFalse(VCore.isLessThanOrEqual(
            Object(),
            to: .init(f: -1),
            by: \.a, \.b, \.c, \.d, \.e, \.f
        ))
    }
    
    func test7() {
        XCTAssertTrue(VCore.isLessThanOrEqual(
            Object(),
            to: .init(g: 1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g
        ))
        
        XCTAssertTrue(VCore.isLessThanOrEqual(
            Object(),
            to: Object(),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g
        ))
        
        XCTAssertFalse(VCore.isLessThanOrEqual(
            Object(),
            to: .init(g: -1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g
        ))
    }
    
    func test8() {
        XCTAssertTrue(VCore.isLessThanOrEqual(
            Object(),
            to: .init(h: 1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h
        ))
        
        XCTAssertTrue(VCore.isLessThanOrEqual(
            Object(),
            to: Object(),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h
        ))
        
        XCTAssertFalse(VCore.isLessThanOrEqual(
            Object(),
            to: .init(h: -1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h
        ))
    }
    
    func test9() {
        XCTAssertTrue(VCore.isLessThanOrEqual(
            Object(),
            to: .init(i: 1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i
        ))
        
        XCTAssertTrue(VCore.isLessThanOrEqual(
            Object(),
            to: Object(),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i
        ))
        
        XCTAssertFalse(VCore.isLessThanOrEqual(
            Object(),
            to: .init(i: -1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i
        ))
    }
    
    func test10() {
        XCTAssertTrue(VCore.isLessThanOrEqual(
            Object(),
            to: .init(j: 1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i, \.j
        ))
        
        XCTAssertTrue(VCore.isLessThanOrEqual(
            Object(),
            to: Object(),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i, \.j
        ))
        
        XCTAssertFalse(VCore.isLessThanOrEqual(
            Object(),
            to: .init(j: -1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i, \.j
        ))
    }
}
