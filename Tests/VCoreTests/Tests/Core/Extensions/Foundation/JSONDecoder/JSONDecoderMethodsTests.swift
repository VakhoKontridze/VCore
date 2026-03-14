//
//  JSONDecoderMethodsTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 15.05.22.
//

import Foundation
import Testing
@testable import VCore

@Suite
nonisolated struct JSONDecoderMethodsTests {
    // MARK: Tests
    @Test
    func testDataToJSON() throws {
        let json: [String: Any] = ["key": "value"]
        let jsonData: Data = try JSONEncoder.encodeAnyToData(json)

        let json2: [String: Any] = try JSONDecoder.decodeJSONFromData(jsonData)

        #expect(json2["key"] as? String == json["key"] as? String)
    }
    
    @Test
    func testDataToJSONArray() throws {
        let json: [String: Any] = ["key": "value"]
        let jsonArray: [[String: Any]] = [json]
        let jsonArrayData = try JSONEncoder.encodeAnyToData(jsonArray)

        let jsonArray2: [[String: Any]] = try JSONDecoder.decodeJSONArrayFromData(jsonArrayData)
        
        #expect(jsonArray2[0]["key"] as? String == jsonArray[0]["key"] as? String)
    }
    
    @Test
    func testJSONToObject() throws {
        let object: Object = .init(key: "value")
        let objectJSON: [String: Any] = try JSONEncoder().encodeObjectToJSON(object)

        let objects2: Object = try JSONDecoder().decodeObjectFromJSON(objectJSON)

        #expect(objects2.key == object.key)
    }
    
    @Test
    func testJSONArrayToObjects() throws {
        let objects: [Object] = [.init(key: "value1"), .init(key: "value2")]
        let objectsJSONArray: [[String: Any]] = try JSONEncoder().encodeObjectToJSONArray(objects)

        let objects2: [Object] = try JSONDecoder().decodeObjectFromJSONArray(objectsJSONArray)

        for i in objects.indices {
            #expect(objects2[i].key == objects[i].key)
        }
    }
    
    // MARK: Types
    nonisolated private struct Object: Codable {
        let key: String?
    }
}
