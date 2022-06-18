//
//  IsGreaterThanOrEqualToByKeyPathTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 18.06.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class IsGreaterThanOrEqualToByKeyPathTests: XCTestCase {
    // MARK: Test Data
    private typealias SomeObject = IsEqualToByKeyPathTests.SomeObject

    // MARK: Tests
    func test1() {
        XCTAssertTrue(VCore.isGreaterThanOrEqual(
            SomeObject(),
            to: .init(a: -1),
            by: \.a
        ))
        
        XCTAssertTrue(VCore.isGreaterThanOrEqual(
            SomeObject(),
            to: .init(),
            by: \.a
        ))
        
        XCTAssertFalse(VCore.isGreaterThanOrEqual(
            SomeObject(),
            to: .init(a: 1),
            by: \.a
        ))
    }
    
    func test2() {
        XCTAssertTrue(VCore.isGreaterThanOrEqual(
            SomeObject(),
            to: .init(b: -1),
            by: \.a, \.b
        ))
        
        XCTAssertTrue(VCore.isGreaterThanOrEqual(
            SomeObject(),
            to: .init(),
            by: \.a, \.b
        ))
        
        XCTAssertFalse(VCore.isGreaterThanOrEqual(
            SomeObject(),
            to: .init(b: 1),
            by: \.a, \.b
        ))
    }
    
    func test3() {
        XCTAssertTrue(VCore.isGreaterThanOrEqual(
            SomeObject(),
            to: .init(c: -1),
            by: \.a, \.b, \.c
        ))
        
        XCTAssertTrue(VCore.isGreaterThanOrEqual(
            SomeObject(),
            to: .init(),
            by: \.a, \.b, \.c
        ))
        
        XCTAssertFalse(VCore.isGreaterThanOrEqual(
            SomeObject(),
            to: .init(c: 1),
            by: \.a, \.b, \.c
        ))
    }
    
    func test4() {
        XCTAssertTrue(VCore.isGreaterThanOrEqual(
            SomeObject(),
            to: .init(d: -1),
            by: \.a, \.b, \.c, \.d
        ))
        
        XCTAssertTrue(VCore.isGreaterThanOrEqual(
            SomeObject(),
            to: .init(),
            by: \.a, \.b, \.c, \.d
        ))
        
        XCTAssertFalse(VCore.isGreaterThanOrEqual(
            SomeObject(),
            to: .init(d: 1),
            by: \.a, \.b, \.c, \.d
        ))
    }
    
    func test5() {
        XCTAssertTrue(VCore.isGreaterThanOrEqual(
            SomeObject(),
            to: .init(e: -1),
            by: \.a, \.b, \.c, \.d, \.e
        ))
        
        XCTAssertTrue(VCore.isGreaterThanOrEqual(
            SomeObject(),
            to: .init(),
            by: \.a, \.b, \.c, \.d, \.e
        ))
        
        XCTAssertFalse(VCore.isGreaterThanOrEqual(
            SomeObject(),
            to: .init(e: 1),
            by: \.a, \.b, \.c, \.d, \.e
        ))
    }
    
    func test6() {
        XCTAssertTrue(VCore.isGreaterThanOrEqual(
            SomeObject(),
            to: .init(f: -1),
            by: \.a, \.b, \.c, \.d, \.e, \.f
        ))
        
        XCTAssertTrue(VCore.isGreaterThanOrEqual(
            SomeObject(),
            to: .init(),
            by: \.a, \.b, \.c, \.d, \.e, \.f
        ))
        
        XCTAssertFalse(VCore.isGreaterThanOrEqual(
            SomeObject(),
            to: .init(f: 1),
            by: \.a, \.b, \.c, \.d, \.e, \.f
        ))
    }
}
