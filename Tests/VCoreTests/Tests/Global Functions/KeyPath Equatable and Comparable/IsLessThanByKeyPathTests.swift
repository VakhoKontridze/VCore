//
//  IsLessThanByKeyPathTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 18.06.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class IsLessThanByKeyPathTests: XCTestCase {
    // MARK: Test Data
    private typealias SomeObject = IsEqualToByKeyPathTests.SomeObject

    // MARK: Tests
    func test1() {
        XCTAssertTrue(VCore.isLess(
            SomeObject(),
            than: .init(a: 1),
            by: \.a
        ))
        
        XCTAssertFalse(VCore.isLess(
            SomeObject(),
            than: .init(),
            by: \.a
        ))
    }
    
    func test2() {
        XCTAssertTrue(VCore.isLess(
            SomeObject(),
            than: .init(b: 1),
            by: \.a, \.b
        ))
        
        XCTAssertFalse(VCore.isLess(
            SomeObject(),
            than: .init(),
            by: \.a, \.b
        ))
    }
    
    func test3() {
        XCTAssertTrue(VCore.isLess(
            SomeObject(),
            than: .init(c: 1),
            by: \.a, \.b, \.c
        ))
        
        XCTAssertFalse(VCore.isLess(
            SomeObject(),
            than: .init(),
            by: \.a, \.b, \.c
        ))
    }
    
    func test4() {
        XCTAssertTrue(VCore.isLess(
            SomeObject(),
            than: .init(d: 1),
            by: \.a, \.b, \.c, \.d
        ))
        
        XCTAssertFalse(VCore.isLess(
            SomeObject(),
            than: .init(),
            by: \.a, \.b, \.c, \.d
        ))
    }
    
    func test5() {
        XCTAssertTrue(VCore.isLess(
            SomeObject(),
            than: .init(e: 1),
            by: \.a, \.b, \.c, \.d, \.e
        ))
        
        XCTAssertFalse(VCore.isLess(
            SomeObject(),
            than: .init(),
            by: \.a, \.b, \.c, \.d, \.e
        ))
    }
    
    func test6() {
        XCTAssertTrue(VCore.isLess(
            SomeObject(),
            than: .init(f: 1),
            by: \.a, \.b, \.c, \.d, \.e, \.f
        ))
        
        XCTAssertFalse(VCore.isLess(
            SomeObject(),
            than: .init(),
            by: \.a, \.b, \.c, \.d, \.e, \.f
        ))
    }
    
    func test7() {
        XCTAssertTrue(VCore.isLess(
            SomeObject(),
            than: .init(g: 1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g
        ))
        
        XCTAssertFalse(VCore.isLess(
            SomeObject(),
            than: .init(),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g
        ))
    }
    
    func test8() {
        XCTAssertTrue(VCore.isLess(
            SomeObject(),
            than: .init(h: 1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h
        ))
        
        XCTAssertFalse(VCore.isLess(
            SomeObject(),
            than: .init(),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h
        ))
    }
    
    func test9() {
        XCTAssertTrue(VCore.isLess(
            SomeObject(),
            than: .init(i: 1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i
        ))
        
        XCTAssertFalse(VCore.isLess(
            SomeObject(),
            than: .init(),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i
        ))
    }
    
    func test10() {
        XCTAssertTrue(VCore.isLess(
            SomeObject(),
            than: .init(j: 1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i, \.j
        ))
        
        XCTAssertFalse(VCore.isLess(
            SomeObject(),
            than: .init(),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i, \.j
        ))
    }
}
