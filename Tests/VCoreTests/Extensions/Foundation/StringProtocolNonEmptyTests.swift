//
//  StringProtocolNonEmptyTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class StringProtocolNonEmptyTests: XCTestCase {
    func testIsEmptyOrWhiteSpace() {
        let input1: String = ""
        let input2: String = " "
        let input3: String = "Lorem Ipsum"
        
        let output1: Bool = true
        let output2: Bool = true
        let output3: Bool = false
        
        let result1: Bool = input1.isEmptyOrWhiteSpace
        let result2: Bool = input2.isEmptyOrWhiteSpace
        let result3: Bool = input3.isEmptyOrWhiteSpace
        
        XCTAssertEqual(result1, output1)
        XCTAssertEqual(result2, output2)
        XCTAssertEqual(result3, output3)
    }
    
    func testIsEmptyWhiteSpaceOrNewLines() {
        let input1: String = ""
        let input2: String = " "
        let input3: String = "\n"
        let input4: String = "Lorem Ipsum"
        
        let output1: Bool = true
        let output2: Bool = true
        let output3: Bool = true
        let output4: Bool = false
        
        let result1: Bool = input1.isEmptyWhiteSpaceOrNewLines
        let result2: Bool = input2.isEmptyWhiteSpaceOrNewLines
        let result3: Bool = input3.isEmptyWhiteSpaceOrNewLines
        let result4: Bool = input4.isEmptyWhiteSpaceOrNewLines
        
        XCTAssertEqual(result1, output1)
        XCTAssertEqual(result2, output2)
        XCTAssertEqual(result3, output3)
        XCTAssertEqual(result4, output4)
    }
    
    func testNonEmpty() {
        let input1: String = ""
        let input2: String = "Lorem Ipsum"
        
        let output1: String? = nil
        let output2: String? = "Lorem Ipsum"
        
        let result1: String? = input1.nonEmpty
        let result2: String? = input2.nonEmpty
        
        XCTAssertEqual(result1, output1)
        XCTAssertEqual(result2, output2)
    }
    
    func testNonEmptyOrWhitespace() {
        let input1: String = ""
        let input2: String = " "
        let input3: String = "Lorem Ipsum"
        
        let output1: String? = nil
        let output2: String? = nil
        let output3: String? = "Lorem Ipsum"
        
        let result1: String? = input1.nonEmptyOrWhiteSpace
        let result2: String? = input2.nonEmptyOrWhiteSpace
        let result3: String? = input3.nonEmptyOrWhiteSpace
        
        XCTAssertEqual(result1, output1)
        XCTAssertEqual(result2, output2)
        XCTAssertEqual(result3, output3)
    }
    
    func testNonEmptyWhitespaceOrNewLines() {
        let input1: String = ""
        let input2: String = " "
        let input3: String = "\n"
        let input4: String = "Lorem Ipsum"
        
        let output1: String? = nil
        let output2: String? = nil
        let output3: String? = nil
        let output4: String? = "Lorem Ipsum"
        
        let result1: String? = input1.nonEmptyWhiteSpaceOrNewLines
        let result2: String? = input2.nonEmptyWhiteSpaceOrNewLines
        let result3: String? = input3.nonEmptyWhiteSpaceOrNewLines
        let result4: String? = input4.nonEmptyWhiteSpaceOrNewLines
        
        XCTAssertEqual(result1, output1)
        XCTAssertEqual(result2, output2)
        XCTAssertEqual(result3, output3)
        XCTAssertEqual(result4, output4)
    }
}
