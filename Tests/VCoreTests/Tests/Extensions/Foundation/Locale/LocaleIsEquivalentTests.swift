//
//  LocaleIsEquivalentTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 03.02.23.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct LocaleIsEquivalentTests {
    // MARK: Test Data
    private let regionIdentifier: String? = Locale.current.region?.identifier
    private var otherRegionIdentifier: String { regionIdentifier == "GB" ? "CA" : "GB" }

    private let languageScriptIdentifier: String? = Locale.current.language.script?.identifier
    private var otherLanguageScriptIdentifier: String { languageScriptIdentifier == "JP" ? "CN" : "JP" }

    // MARK: Tests
    @Test
    func testIsSameLocaleLanguageCode() {
        let lhs: Locale = .init(identifier: "en")
        let rhs: Locale = .init(identifier: "es")
        
        #expect(!lhs.isEquivalent(to: rhs))
    }
    
    @Test
    func testIsSameLocaleRegionIdentifier() {
        do {
            let lhs: Locale = .init(identifier: "en")
            let rhs: Locale = .init(identifier: "en_\(otherRegionIdentifier)")

            #expect(!lhs.isEquivalent(to: rhs))
        }
        
        do {
            if let regionIdentifier {
                let lhs: Locale = .init(identifier: "en")
                let rhs: Locale = .init(identifier: "en_\(regionIdentifier)")

                #expect(lhs.isEquivalent(to: rhs))
            }
        }
    }
    
    @Test
    func testIsSameLocaleLanguageScriptIdentifier() {
        do {
            let lhs: Locale = .init(identifier: "zh_Hans")
            let rhs: Locale = .init(identifier: "zh_Hans-\(otherLanguageScriptIdentifier)")

            #expect(!lhs.isEquivalent(to: rhs))
        }
        
        do {
            if let languageScriptIdentifier {
                let lhs: Locale = .init(identifier: "zh_Hans")
                let rhs: Locale = .init(identifier: "zh_Hans-\(languageScriptIdentifier)")

                #expect(lhs.isEquivalent(to: rhs))
            }
        }
    }
}
