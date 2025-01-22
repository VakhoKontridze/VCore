//
//  StringProtocolNonEmptyTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct StringProtocolNonEmptyTests {
    @Test
    func testIsEmptyOrWhiteSpace() {
        #expect("".isEmptyOrWhiteSpace)
        #expect(" ".isEmptyOrWhiteSpace)
        #expect(!"Lorem Ipsum".isEmptyOrWhiteSpace)
    }
    
    @Test
    func testIsEmptyWhiteSpaceOrNewLines() {
        #expect("".isEmptyWhiteSpaceOrNewLines)
        #expect(" ".isEmptyWhiteSpaceOrNewLines)
        #expect("\n".isEmptyWhiteSpaceOrNewLines)
        #expect(!"Lorem Ipsum".isEmptyWhiteSpaceOrNewLines)
    }
    
    @Test
    func testNonEmpty() {
        #expect("".nonEmpty == nil)
        #expect("Lorem Ipsum".nonEmpty == "Lorem Ipsum")
    }
    
    @Test
    func testNonEmptyOrWhitespace() {
        #expect("".nonEmptyOrWhiteSpace == nil)
        #expect(" ".nonEmptyOrWhiteSpace == nil)
        #expect("Lorem Ipsum".nonEmptyOrWhiteSpace == "Lorem Ipsum")
    }
    
    @Test
    func testNonEmptyWhitespaceOrNewLines() {
        #expect("".nonEmptyWhiteSpaceOrNewLines == nil)
        #expect(" ".nonEmptyWhiteSpaceOrNewLines == nil)
        #expect("\n".nonEmptyWhiteSpaceOrNewLines == nil)
        #expect("Lorem Ipsum".nonEmptyWhiteSpaceOrNewLines == "Lorem Ipsum")
    }
}
