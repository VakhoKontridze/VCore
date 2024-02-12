//
//  LocaleIsEquivalentTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.02.23.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class LocaleIsEquivalentTests: XCTestCase {
    // MARK: Test Data
    private let regionCode: String? = Locale.current.regionCode
    private lazy var otherRegionCode: String = { regionCode == "GB" ? "CA" : "GB" }()
    
    private let scriptCode: String? = Locale.current.scriptCode
    private lazy var otherScriptCode: String = { scriptCode == "JP" ? "CN" : "JP" }()
    
    // MARK: Tests
    func testIsSameLocaleLanguageCode() {
        let lhs: Locale = .init(identifier: "en")
        let rhs: Locale = .init(identifier: "es")
        
        XCTAssertFalse(lhs.isEquivalent(to: rhs))
    }
    
    func testIsSameLocaleRegionCode() {
        do {
            let lhs: Locale = .init(identifier: "en")
            let rhs: Locale = .init(identifier: "en_\(otherRegionCode)")
            
            XCTAssertFalse(lhs.isEquivalent(to: rhs))
        }
        
        do {
            if let regionCode {
                let lhs: Locale = .init(identifier: "en")
                let rhs: Locale = .init(identifier: "en_\(regionCode)")
                
                XCTAssertTrue(lhs.isEquivalent(to: rhs))
            }
        }
    }
    
    func testIsSameLocaleScriptCode() {
        do {
            let lhs: Locale = .init(identifier: "zh_Hans")
            let rhs: Locale = .init(identifier: "zh_Hans-\(otherScriptCode)")
            
            XCTAssertFalse(lhs.isEquivalent(to: rhs))
        }
        
        do {
            if let scriptCode {
                let lhs: Locale = .init(identifier: "zh_Hans")
                let rhs: Locale = .init(identifier: "zh_Hans-\(scriptCode)")
                
                XCTAssertTrue(lhs.isEquivalent(to: rhs))
            }
        }
    }
}
