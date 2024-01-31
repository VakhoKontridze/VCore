//
//  JSONDecoderMethodsTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 15.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class JSONDecoderMethodsTests: XCTestCase {
    // MARK: Test Data
    private struct Object: Codable {
        let key: String?
    }
    
    // MARK: Tests
    func testDataToJSON() throws {
        let json: [String: Any?] = ["key": "value"]
        guard
            let jsonData: Data = try? JSONEncoder.encodeAnyToData(json)
        else {
            VCoreLogError("Failed to generate test data")
            fatalError()
        }

        let json2: [String: Any?] = try JSONDecoder.decodeJSONFromData(jsonData)

        XCTAssertEqual(
            json2["key"]?.toString,
            json["key"]?.toString
        )
    }
    
    func testDataToJSONArray() throws {
        let json: [String: Any?] = ["key": "value"]
        let jsonArray: [[String: Any?]] = [json]
        guard
            let jsonArrayData = try? JSONEncoder.encodeAnyToData(jsonArray)
        else {
            VCoreLogError("Failed to generate test data")
            fatalError()
        }

        let jsonArray2: [[String: Any?]] = try JSONDecoder.decodeJSONArrayFromData(jsonArrayData)
        
        XCTAssertEqual(
            jsonArray2[0]["key"]?.toString,
            jsonArray[0]["key"]?.toString
        )
    }
    
    func testJSONToObject() throws {
        let object: Object = .init(key: "value")
        guard
            let objectJSON: [String: Any?] = try? JSONEncoder().encodeObjectToJSON(object)
        else {
            VCoreLogError("Failed to generate test data")
            fatalError()
        }

        let objects2: Object = try JSONDecoder().decodeObjectFromJSON(objectJSON)

        XCTAssertEqual(objects2.key, object.key)
    }
    
    func testJSONArrayToObjects() throws {
        let objects: [Object] = [.init(key: "value1"), .init(key: "value2")]
        guard
            let objectsJSONArray: [[String: Any?]] = try? JSONEncoder().encodeObjectToJSONArray(objects)
        else {
            VCoreLogError("Failed to generate test data")
            fatalError()
        }

        let objects2: [Object] = try JSONDecoder().decodeObjectFromJSONArray(objectsJSONArray)

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
