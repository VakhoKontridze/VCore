//
//  JSONDecoderServiceTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 15.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class JSONDecoderServiceTests: XCTestCase {
    // MARK: Test Data
    private struct SomeObject: Codable {
        let key: String?
    }
    
    // MARK: Tests
    func testDataToJSON() {
        let json: [String: Any?] = ["key": "value"]
        let jsonData: Data = try! JSONEncoderService.data(any: json) // fatalError
        
        do {
            let json2: [String: Any?] = try JSONDecoderService.json(data: jsonData)
            
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
        let jsonArrayData = try! JSONEncoderService.data(any: jsonArray) // fatalError
        
        do {
            let jsonArray2: [[String: Any?]] = try JSONDecoderService.jsonArray(data: jsonArrayData)
            XCTAssertEqual(
                jsonArray2[0]["key"]?.toString,
                jsonArray[0]["key"]?.toString
            )
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testDataToDecodable() {
        let decodable: SomeObject = .init(key: "value")
        let decodableData: Data = try! JSONEncoderService.data(encodable: decodable) // fatalError
        
        do {
            let decodable2: SomeObject = try JSONDecoderService.decodable(data: decodableData)
            XCTAssertEqual(decodable2.key, decodable.key)
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testJSONToDecodable() {
        let decodable: SomeObject = .init(key: "value")
        let decodableJSON: [String: Any?] = try! JSONEncoderService.json(encodable: decodable) // fatalError
        
        do {
            let decodable2: SomeObject = try JSONDecoderService.decodable(json: decodableJSON)
            XCTAssertEqual(decodable2.key, decodable.key)
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testJSONArrayToDecodable() {
        let decodables: [SomeObject] = [.init(key: "value1"), .init(key: "value2")]
        let decodableJSONArray: [[String: Any?]] = try! JSONEncoderService.jsonArray(encodable: decodables) // fatalError
        
        do {
            let decodables2: [SomeObject] = try JSONDecoderService.decodable(jsonArray: decodableJSONArray)
            for i in decodables.indices {
                XCTAssertEqual(decodables2[i].key, decodables[i].key)
            }
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
