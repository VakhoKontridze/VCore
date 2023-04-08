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
    private typealias SomeObject = IsEqualToByKeyPathTests.SomeObject
    
    // MARK: Tests
    func test1() {
        XCTAssertTrue(VCore.isLessThanOrEqual(
            SomeObject(),
            to: .init(a: 1),
            by: \.a
        ))
        
        XCTAssertTrue(VCore.isLessThanOrEqual(
            SomeObject(),
            to: SomeObject(),
            by: \.a
        ))
        
        XCTAssertFalse(VCore.isLessThanOrEqual(
            SomeObject(),
            to: .init(a: -1),
            by: \.a
        ))
    }
    
    func test2() {
        XCTAssertTrue(VCore.isLessThanOrEqual(
            SomeObject(),
            to: .init(b: 1),
            by: \.a, \.b
        ))
        
        XCTAssertTrue(VCore.isLessThanOrEqual(
            SomeObject(),
            to: SomeObject(),
            by: \.a, \.b
        ))
        
        XCTAssertFalse(VCore.isLessThanOrEqual(
            SomeObject(),
            to: .init(b: -1),
            by: \.a, \.b
        ))
    }
    
    func test3() {
        XCTAssertTrue(VCore.isLessThanOrEqual(
            SomeObject(),
            to: .init(c: 1),
            by: \.a, \.b, \.c
        ))
        
        XCTAssertTrue(VCore.isLessThanOrEqual(
            SomeObject(),
            to: SomeObject(),
            by: \.a, \.b, \.c
        ))
        
        XCTAssertFalse(VCore.isLessThanOrEqual(
            SomeObject(),
            to: .init(c: -1),
            by: \.a, \.b, \.c
        ))
    }
    
    func test4() {
        XCTAssertTrue(VCore.isLessThanOrEqual(
            SomeObject(),
            to: .init(d: 1),
            by: \.a, \.b, \.c, \.d
        ))
        
        XCTAssertTrue(VCore.isLessThanOrEqual(
            SomeObject(),
            to: SomeObject(),
            by: \.a, \.b, \.c, \.d
        ))
        
        XCTAssertFalse(VCore.isLessThanOrEqual(
            SomeObject(),
            to: .init(d: -1),
            by: \.a, \.b, \.c, \.d
        ))
    }
    
    func test5() {
        XCTAssertTrue(VCore.isLessThanOrEqual(
            SomeObject(),
            to: .init(e: 1),
            by: \.a, \.b, \.c, \.d, \.e
        ))
        
        XCTAssertTrue(VCore.isLessThanOrEqual(
            SomeObject(),
            to: SomeObject(),
            by: \.a, \.b, \.c, \.d, \.e
        ))
        
        XCTAssertFalse(VCore.isLessThanOrEqual(
            SomeObject(),
            to: .init(e: -1),
            by: \.a, \.b, \.c, \.d, \.e
        ))
    }
    
    func test6() {
        XCTAssertTrue(VCore.isLessThanOrEqual(
            SomeObject(),
            to: .init(f: 1),
            by: \.a, \.b, \.c, \.d, \.e, \.f
        ))
        
        XCTAssertTrue(VCore.isLessThanOrEqual(
            SomeObject(),
            to: SomeObject(),
            by: \.a, \.b, \.c, \.d, \.e, \.f
        ))
        
        XCTAssertFalse(VCore.isLessThanOrEqual(
            SomeObject(),
            to: .init(f: -1),
            by: \.a, \.b, \.c, \.d, \.e, \.f
        ))
    }
    
    func test7() {
        XCTAssertTrue(VCore.isLessThanOrEqual(
            SomeObject(),
            to: .init(g: 1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g
        ))
        
        XCTAssertTrue(VCore.isLessThanOrEqual(
            SomeObject(),
            to: SomeObject(),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g
        ))
        
        XCTAssertFalse(VCore.isLessThanOrEqual(
            SomeObject(),
            to: .init(g: -1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g
        ))
    }
    
    func test8() {
        XCTAssertTrue(VCore.isLessThanOrEqual(
            SomeObject(),
            to: .init(h: 1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h
        ))
        
        XCTAssertTrue(VCore.isLessThanOrEqual(
            SomeObject(),
            to: SomeObject(),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h
        ))
        
        XCTAssertFalse(VCore.isLessThanOrEqual(
            SomeObject(),
            to: .init(h: -1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h
        ))
    }
    
    func test9() {
        XCTAssertTrue(VCore.isLessThanOrEqual(
            SomeObject(),
            to: .init(i: 1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i
        ))
        
        XCTAssertTrue(VCore.isLessThanOrEqual(
            SomeObject(),
            to: SomeObject(),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i
        ))
        
        XCTAssertFalse(VCore.isLessThanOrEqual(
            SomeObject(),
            to: .init(i: -1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i
        ))
    }
    
    func test10() {
        XCTAssertTrue(VCore.isLessThanOrEqual(
            SomeObject(),
            to: .init(j: 1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i, \.j
        ))
        
        XCTAssertTrue(VCore.isLessThanOrEqual(
            SomeObject(),
            to: SomeObject(),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i, \.j
        ))
        
        XCTAssertFalse(VCore.isLessThanOrEqual(
            SomeObject(),
            to: .init(j: -1),
            by: \.a, \.b, \.c, \.d, \.e, \.f, \.g, \.h, \.i, \.j
        ))
    }
}
