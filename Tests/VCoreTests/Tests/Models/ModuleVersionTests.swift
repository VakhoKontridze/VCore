//
//  ModuleVersionTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct ModuleVersionTests {
    @Test
    func testInitWithString() {
        #expect(ModuleVersion(string: nil) == nil)
        #expect(ModuleVersion(string: "") == nil)
        #expect(ModuleVersion(string: "A") == nil)
        #expect(ModuleVersion(string: "1.0.A") == nil)
        #expect(ModuleVersion(string: "1.0.0.0") == nil)
        #expect(ModuleVersion(string: "1") == ModuleVersion(1, 0, nil))
        #expect(ModuleVersion(string: "1.0") == ModuleVersion(1, 0, nil))
        #expect(ModuleVersion(string: "1.0.0") == ModuleVersion(1, 0, 0))
    }
    
    @Test
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
                    #expect(versions[i] < versions[j])
                }
            }
        }
    }
    
    @Test
    func testDescription() {
        #expect(ModuleVersion(string: "1")?.description == "1.0")
        #expect(ModuleVersion(string: "1.0")?.description == "1.0")
        #expect(ModuleVersion(string: "1.0.0")?.description == "1.0.0")
    }
}
