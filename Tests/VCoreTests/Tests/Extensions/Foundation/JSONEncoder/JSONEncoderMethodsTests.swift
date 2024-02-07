//
//  JSONEncoderMethodsTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 15.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class JSONEncoderMethodsTests: XCTestCase {
    // MARK: Test Data
    private struct Object: Codable {
        let key: String?
    }
    
    // MARK: Tests
    func testAnyToData() throws {
        let json: [String: Any?] = ["key": "value"]
        
        let data: Data = try JSONEncoder.encodeAnyToData(json)

        guard
            let json2: [String: Any?] = try? JSONDecoder.decodeJSONFromData(data)
        else {
            VCoreLogError("Failed to generate test data")
            fatalError()
        }

        XCTAssertEqual(json2["key"]?.toString, "value")
    }
    
    func testObjectToJSON() throws {
        let object: Object = .init(key: "value")

        let json: [String: Any?] = try JSONEncoder().encodeObjectToJSON(object)

        guard
            let object2: Object = try? JSONDecoder().decodeObjectFromJSON(json)
        else {
            VCoreLogError("Failed to generate test data")
            fatalError()
        }

        XCTAssertEqual(object2.key, object.key)
    }
    
    func testObjectsToJSONArray() throws {
        let objects: [Object] = [.init(key: "value1"), .init(key: "value2")]

        let jsonArray: [[String: Any?]] = try JSONEncoder().encodeObjectToJSONArray(objects)

        guard
            let objects2: [Object] = try? JSONDecoder().decodeObjectFromJSONArray(jsonArray)
        else {
            VCoreLogError("Failed to generate test data")
            fatalError()
        }

        for i in objects.indices {
            XCTAssertEqual(objects2[i].key, objects[i].key)
        }
    }
}

// MARK: - Helpers
extension Optional where Wrapped == Any {
    fileprivate var toString: String? {
        self as? String
    }
}
