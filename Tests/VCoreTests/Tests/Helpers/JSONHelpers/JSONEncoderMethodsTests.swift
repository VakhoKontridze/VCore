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
    private struct SomeObject: Codable {
        let key: String?
    }
    
    // MARK: Tests
    func testAnyToData() {
        let json: [String: Any?] = ["key": "value"]
        
        do {
            let data: Data = try JSONEncoder().encodeAnyToData(json)
            
            let json2: [String: Any?] = try! JSONDecoder().decodeJSONFromData(data) // Force-unwrap
            XCTAssertEqual(json2["key"]?.toString, "value")
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testObjectToJSON() {
        let object: SomeObject = .init(key: "value")
        
        do {
            let json: [String: Any?] = try JSONEncoder().encodeObjectToJSON(object)
            
            let object2: SomeObject = try! JSONDecoder().decodeObjectFromJSON(json) // Force-unwrap
            XCTAssertEqual(object2.key, object.key)
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testObjectsToJSONArray() {
        let objects: [SomeObject] = [.init(key: "value1"), .init(key: "value2")]
        
        do {
            let jsonArray: [[String: Any?]] = try JSONEncoder().encodeObjectToJSONArray(objects)
            
            let objects2: [SomeObject] = try! JSONDecoder().decodeObjectFromJSONArray(jsonArray) // Force-unwrap
            for i in objects.indices {
                XCTAssertEqual(objects2[i].key, objects[i].key)
            }
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
