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
    private struct SomeObject: Codable {
        let key: String?
    }
    
    // MARK: Tests
    func testDataToJSON() {
        let json: [String: Any?] = ["key": "value"]
        let jsonData: Data = try! JSONEncoder().encodeAnyToData(json) // Force-unwrap
        
        do {
            let json2: [String: Any?] = try JSONDecoder().decodeJSONFromData(jsonData)
            
            XCTAssertEqual(
                json2["key"]?.toString,
                json["key"]?.toString
            )
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testDataToJSONArray() {
        let json: [String: Any?] = ["key": "value"]
        let jsonArray: [[String: Any?]] = [json]
        let jsonArrayData = try! JSONEncoder().encodeAnyToData(jsonArray) // Force-unwrap
        
        do {
            let jsonArray2: [[String: Any?]] = try JSONDecoder().decodeJSONArrayFromData(jsonArrayData)
            XCTAssertEqual(
                jsonArray2[0]["key"]?.toString,
                jsonArray[0]["key"]?.toString
            )
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testJSONToObject() {
        let object: SomeObject = .init(key: "value")
        let objectJSON: [String: Any?] = try! JSONEncoder().encodeObjectToJSON(object) // Force-unwrap
        
        do {
            let objects2: SomeObject = try JSONDecoder().decodeObjectFromJSON(objectJSON)
            XCTAssertEqual(objects2.key, object.key)
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testJSONArrayToObjects() {
        let objects: [SomeObject] = [.init(key: "value1"), .init(key: "value2")]
        let objectsJSONArray: [[String: Any?]] = try! JSONEncoder().encodeObjectToJSONArray(objects) // Force-unwrap
        
        do {
            let objects2: [SomeObject] = try JSONDecoder().decodeObjectFromJSONArray(objectsJSONArray)
            for i in objects.indices {
                XCTAssertEqual(objects2[i].key, objects[i].key)
            }
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
