//
//  ModuleVersionTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class ModuleVersionTests: XCTestCase {
    // MARK: Test Data
    private let version1: ModuleVersion = .init(string: "1")!
    private let version2: ModuleVersion = .init(string: "1.0")!
    private let version3: ModuleVersion = .init(string: "1.0.0")!
    
    // MARK: Tests
    func testStringInit() {
        XCTAssertNil(ModuleVersion(string: nil))
        XCTAssertNil(ModuleVersion(string: ""))
        XCTAssertNil(ModuleVersion(string: "A"))
        XCTAssertNil(ModuleVersion(string: "1.0.A"))
        XCTAssertNil(ModuleVersion(string: "1.0.0.0"))
        
        XCTAssertEqual(version1.major, 1)
        XCTAssertEqual(version1.minor, 0)
        XCTAssertEqual(version1.patch, nil)
        
        XCTAssertEqual(version2.major, 1)
        XCTAssertEqual(version2.minor, 0)
        XCTAssertEqual(version2.patch, nil)
        
        XCTAssertEqual(version3.major, 1)
        XCTAssertEqual(version3.minor, 0)
        XCTAssertEqual(version3.patch, 0)
    }
    
    func testEquatable() {
        let versions: [ModuleVersion] = [
            .init(1, 0),
            .init(1, 0, 1),
            .init(1, 0, 2),
            .init(1, 1),
            .init(2, 0)
        ]
        
        for i in 0..<versions.count {
            for j in 0..<versions.count - i - 1 {
                if i < j {
                    XCTAssertTrue(versions[i] < versions[j])
                }
            }
        }
    }
    
    func testDescription() {
        XCTAssertEqual(version1.description, "1.0")
        XCTAssertEqual(version2.description, "1.0")
        XCTAssertEqual(version3.description, "1.0.0")
    }
}
