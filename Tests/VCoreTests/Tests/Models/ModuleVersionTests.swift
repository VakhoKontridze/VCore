//
//  ModuleVersionTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class ModuleVersionTests: XCTestCase {
    func testInitWithString() {
        XCTAssertNil(ModuleVersion(string: nil))
        XCTAssertNil(ModuleVersion(string: ""))
        XCTAssertNil(ModuleVersion(string: "A"))
        XCTAssertNil(ModuleVersion(string: "1.0.A"))
        XCTAssertNil(ModuleVersion(string: "1.0.0.0"))
        
        XCTAssertEqual(ModuleVersion(string: "1")?.major, 1)
        XCTAssertEqual(ModuleVersion(string: "1")?.minor, 0)
        XCTAssertEqual(ModuleVersion(string: "1")?.patch, nil)

        XCTAssertEqual(ModuleVersion(string: "1.0")?.major, 1)
        XCTAssertEqual(ModuleVersion(string: "1.0")?.minor, 0)
        XCTAssertEqual(ModuleVersion(string: "1.0")?.patch, nil)

        XCTAssertEqual(ModuleVersion(string: "1.0.0")?.major, 1)
        XCTAssertEqual(ModuleVersion(string: "1.0.0")?.minor, 0)
        XCTAssertEqual(ModuleVersion(string: "1.0.0")?.patch, 0)
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
        XCTAssertEqual(ModuleVersion(string: "1")?.description, "1.0")
        XCTAssertEqual(ModuleVersion(string: "1.0")?.description, "1.0")
        XCTAssertEqual(ModuleVersion(string: "1.0.0")?.description, "1.0.0")
    }
}
