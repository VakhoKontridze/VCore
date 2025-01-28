//
//  JSONDecoderMethodsTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 15.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct JSONDecoderMethodsTests {
    // MARK: Test Data
    private struct Object: Codable {
        let key: String?
    }
    
    // MARK: Tests
    @Test
    func testDataToJSON() throws {
        let json: [String: Any?] = ["key": "value"]
        let jsonData: Data = try JSONEncoder.encodeAnyToData(json)

        let json2: [String: Any?] = try JSONDecoder.decodeJSONFromData(jsonData)

        #expect(json2["key"]?.toString == json["key"]?.toString)
    }
    
    @Test
    func testDataToJSONArray() throws {
        let json: [String: Any?] = ["key": "value"]
        let jsonArray: [[String: Any?]] = [json]
        let jsonArrayData = try JSONEncoder.encodeAnyToData(jsonArray)

        let jsonArray2: [[String: Any?]] = try JSONDecoder.decodeJSONArrayFromData(jsonArrayData)
        
        #expect(jsonArray2[0]["key"]?.toString == jsonArray[0]["key"]?.toString)
    }
    
    @Test
    func testJSONToObject() throws {
        let object: Object = .init(key: "value")
        let objectJSON: [String: Any?] = try JSONEncoder().encodeObjectToJSON(object)

        let objects2: Object = try JSONDecoder().decodeObjectFromJSON(objectJSON)

        #expect(objects2.key == object.key)
    }
    
    @Test
    func testJSONArrayToObjects() throws {
        let objects: [Object] = [.init(key: "value1"), .init(key: "value2")]
        let objectsJSONArray: [[String: Any?]] = try JSONEncoder().encodeObjectToJSONArray(objects)

        let objects2: [Object] = try JSONDecoder().decodeObjectFromJSONArray(objectsJSONArray)

        for i in objects.indices {
            #expect(objects2[i].key == objects[i].key)
        }
    }
}

// MARK: - Helpers
extension Optional where Wrapped == Any {
    fileprivate var toString: String? {
        self as? String
    }
}
