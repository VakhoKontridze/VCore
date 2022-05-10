//
//  JSONTypeCastsTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class JSONTypeCastsTests: XCTestCase {
    private let json: [String: Any?] = ["key": "value"]
    private let jsonArray: [[String: Any?]] = [["key": "value"]]
    
    private let int: Int = 10
    private let float: Float = 10
    private let double: Double = 10
    private let bool: Bool = true
    private let char: Character = "1"
    private let string: String = "10"
    
    func testJSONCast() {
        XCTAssertEqual(
            (json as Any?).toJSON?["key"]?.toString,
            "value"
        )
    }
    
    func testJSONArrayCast() {
        XCTAssertEqual(
            (jsonArray as Any?).toJSONArray?[0]["key"]?.toString,
            "value"
        )
    }
    
    func testWrappedJSONCast() {
        XCTAssertEqual(
            (json as Any?).toWrappedJSON["key"]?.toString,
            "value"
        )
    }
    
    func testWrappedJSONArrayCast() {
        XCTAssertEqual(
            (jsonArray as Any?).toWrappedJSONArray[0]["key"]?.toString,
            "value"
        )
    }
    
    func testIntCast() {
        XCTAssertEqual((int as Any?).toInt, 10)
        XCTAssertEqual((float as Any?).toInt, 10)
        XCTAssertEqual((double as Any?).toInt, 10)
        XCTAssertEqual((bool as Any?).toInt, 1)
        XCTAssertEqual((char as Any?).toInt, 1)
        XCTAssertEqual((string as Any?).toInt, 10)
    }
    
    func testFloatCast() {
        XCTAssertEqual((int as Any?).toFloat, 10)
        XCTAssertEqual((float as Any?).toFloat, 10)
        XCTAssertEqual((double as Any?).toFloat, 10)
        XCTAssertEqual((bool as Any?).toFloat, 1)
        XCTAssertEqual((char as Any?).toFloat, 1)
        XCTAssertEqual((string as Any?).toFloat, 10)
    }
    
    func testDoubleCast() {
        XCTAssertEqual((int as Any?).toDouble, 10)
        XCTAssertEqual((float as Any?).toDouble, 10)
        XCTAssertEqual((double as Any?).toDouble, 10)
        XCTAssertEqual((bool as Any?).toDouble, 1)
        XCTAssertEqual((char as Any?).toDouble, 1)
        XCTAssertEqual((string as Any?).toDouble, 10)
    }
    
    func testBoolCast() {
        let string: String = "true"
        
        XCTAssertEqual((int as Any?).toBool, true)
        XCTAssertEqual((float as Any?).toBool, true)
        XCTAssertEqual((double as Any?).toBool, true)
        XCTAssertEqual((bool as Any?).toBool, true)
        XCTAssertEqual((char as Any?).toBool, true)
        XCTAssertEqual((string as Any?).toBool, true)
    }
    
    func testCharCast() {
        let int: Int = 1
        let float: Float = 1
        let double: Double = 1
        //let bool: Bool = true
        //let char: Character = "1"
        let string: String = "1"
        
        XCTAssertEqual((int as Any?).toChar, "1")
        XCTAssertEqual((float as Any?).toChar, "1")
        XCTAssertEqual((double as Any?).toChar, "1")
        XCTAssertEqual((bool as Any?).toChar, "1")
        XCTAssertEqual((char as Any?).toChar, "1")
        XCTAssertEqual((string as Any?).toChar, "1")
    }
    
    func testStringCast() {
        XCTAssertEqual((int as Any?).toString, "10")
        XCTAssertEqual((float as Any?).toString, "10.0")
        XCTAssertEqual((double as Any?).toString, "10.0")
        XCTAssertEqual((bool as Any?).toString, "true")
        XCTAssertEqual((char as Any?).toString, "1")
        XCTAssertEqual((string as Any?).toString, "10")
    }
}
