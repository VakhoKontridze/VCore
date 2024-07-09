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
    private let regionIdentifier: String? = Locale.current.region?.identifier
    private lazy var otherRegionIdentifier: String = regionIdentifier == "GB" ? "CA" : "GB"

    private let languageScriptIdentifier: String? = Locale.current.language.script?.identifier
    private lazy var otherLanguageScriptIdentifier: String = languageScriptIdentifier == "JP" ? "CN" : "JP"

    // MARK: Tests
    func testIsSameLocaleLanguageCode() {
        let lhs: Locale = .init(identifier: "en")
        let rhs: Locale = .init(identifier: "es")
        
        XCTAssertFalse(lhs.isEquivalent(to: rhs))
    }
    
    func testIsSameLocaleRegionIdentifier() {
        do {
            let lhs: Locale = .init(identifier: "en")
            let rhs: Locale = .init(identifier: "en_\(otherRegionIdentifier)")

            XCTAssertFalse(lhs.isEquivalent(to: rhs))
        }
        
        do {
            if let regionIdentifier {
                let lhs: Locale = .init(identifier: "en")
                let rhs: Locale = .init(identifier: "en_\(regionIdentifier)")

                XCTAssertTrue(lhs.isEquivalent(to: rhs))
            }
        }
    }
    
    func testIsSameLocaleLanguageScriptIdentifier() {
        do {
            let lhs: Locale = .init(identifier: "zh_Hans")
            let rhs: Locale = .init(identifier: "zh_Hans-\(otherLanguageScriptIdentifier)")

            XCTAssertFalse(lhs.isEquivalent(to: rhs))
        }
        
        do {
            if let languageScriptIdentifier {
                let lhs: Locale = .init(identifier: "zh_Hans")
                let rhs: Locale = .init(identifier: "zh_Hans-\(languageScriptIdentifier)")

                XCTAssertTrue(lhs.isEquivalent(to: rhs))
            }
        }
    }
}
