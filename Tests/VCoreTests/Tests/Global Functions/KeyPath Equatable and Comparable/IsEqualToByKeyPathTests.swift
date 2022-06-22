//
//  IsEqualToByKeyPathTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 18.06.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class IsEqualToByKeyPathTests: XCTestCase {
    // MARK: Test Data
    struct SomeObject {
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
        XCTAssertTrue(VCore.isEqual(
            SomeObject(),
            to: .init(),
            by: \.a
        ))
        
        XCTAssertFalse(VCore.isEqual(
            SomeObject(),
            to: .init(a: 1),
            by: \.a
        ))
    }
    
    func test2() {
        XCTAssertTrue(VCore.isEqual(
            SomeObject(),
            to: .init(),
            by: \.a, \.b
        ))
        
        XCTAssertFalse(VCore.isEqual(
            SomeObject(),
            to: .init(b: 1),
            by: \.a, \.b
        ))
    }
    
    func test3() {
        XCTAssertTrue(VCore.isEqual(
            SomeObject(),
            to: .init(),
            by: \.a, \.b, \.c
        ))
        
        XCTAssertFalse(VCore.isEqual(
            SomeObject(),
            to: .init(c: 1),
            by: \.a, \.b, \.c
        ))
    }
    
    func test4() {
        XCTAssertTrue(VCore.isEqual(
            SomeObject(),
            to: .init(),
            by: \.a, \.b, \.c, \.d
        ))
        
        XCTAssertFalse(VCore.isEqual(
            SomeObject(),
            to: .init(d: 1),
            by: \.a, \.b, \.c, \.d
        ))
    }
    
    func test5() {
        XCTAssertTrue(VCore.isEqual(
            SomeObject(),
            to: .init(),
            by: \.a, \.b, \.c, \.d, \.e
        ))
        
        XCTAssertFalse(VCore.isEqual(
            SomeObject(),
            to: .init(e: 1),
            by: \.a, \.b, \.c, \.d, \.e
        ))
    }
    
    func test6() {
        XCTAssertTrue(VCore.isEqual(
            SomeObject(),
            to: .init(),
            by: \.a, \.b, \.c, \.d, \.e, \.f
        ))
        
        XCTAssertFalse(VCore.isEqual(
            SomeObject(),
            to: .init(f: 1),
            by: \.a, \.b, \.c, \.d, \.e, \.f
        ))
    }
    
    func test7() {
        XCTAssertTrue(VCore.isEqual(
            SomeObject(),
            to: .init(),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g
        ))
        
        XCTAssertFalse(VCore.isEqual(
            SomeObject(),
            to: .init(g: 1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g
        ))
    }
    
    func test8() {
        XCTAssertTrue(VCore.isEqual(
            SomeObject(),
            to: .init(),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h
        ))
        
        XCTAssertFalse(VCore.isEqual(
            SomeObject(),
            to: .init(h: 1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h
        ))
    }
    
    func test9() {
        XCTAssertTrue(VCore.isEqual(
            SomeObject(),
            to: .init(),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i
        ))
        
        XCTAssertFalse(VCore.isEqual(
            SomeObject(),
            to: .init(i: 1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i
        ))
    }
    
    func test10() {
        XCTAssertTrue(VCore.isEqual(
            SomeObject(),
            to: .init(),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i, \.j
        ))
        
        XCTAssertFalse(VCore.isEqual(
            SomeObject(),
            to: .init(j: 1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i, \.j
        ))
    }
}
