//
//  JSONEncoderMethodsTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 15.05.22.
//

import Foundation
import Testing
@testable import VCore

@Suite
nonisolated struct JSONEncoderMethodsTests {
    // MARK: Tests
    @Test
    func testAnyToData() throws {
        let json: [String: Any] = ["key": "value"]
        let data: Data = try JSONEncoder.encodeAnyToData(json)

        let json2: [String: Any] = try JSONDecoder.decodeJSONFromData(data)

        #expect(json2["key"] as? String == "value")
    }
    
    @Test
    func testObjectToJSON() throws {
        let object: Object = .init(key: "value")
        let json: [String: Any] = try JSONEncoder().encodeObjectToJSON(object)

        let object2: Object = try JSONDecoder().decodeObjectFromJSON(json)

        #expect(object2.key == object.key)
    }
    
    @Test
    func testObjectsToJSONArray() throws {
        let objects: [Object] = [.init(key: "value1"), .init(key: "value2")]
        let jsonArray: [[String: Any]] = try JSONEncoder().encodeObjectToJSONArray(objects)

        let objects2: [Object] = try JSONDecoder().decodeObjectFromJSONArray(jsonArray)

        for i in objects.indices {
            #expect(objects2[i].key == objects[i].key)
        }
    }
    
    // MARK: Types
    private nonisolated struct Object: Codable {
        let key: String?
    }
}
