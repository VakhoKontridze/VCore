//
//  JSONEncoderServiceTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 15.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class JSONEncoderServiceTests: XCTestCase {
    // MARK: Test Data
    private struct SomeObject: Codable {
        let key: String?
    }
    
    // MARK: Tests
    func testAnyToData() {
        let json: [String: Any?] = ["key": "value"]
        
        do {
            let data: Data = try JSONEncoderService().data(any: json)
            
            let json2: [String: Any?] = try! JSONDecoderService().json(data: data) // Force-unwrap
            XCTAssertEqual(json2["key"]?.toString, "value")
        
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testEncodableToData() {
        let encodable: SomeObject = .init(key: "value")
        
        do {
            let data: Data = try JSONEncoderService().data(encodable: encodable)
            
            let encodable2: SomeObject = try! JSONDecoderService().decodable(data: data) // Force-unwrap
            XCTAssertEqual(encodable2.key, encodable.key)
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testEncodableToJSON() {
        let encodable: SomeObject = .init(key: "value")
        
        do {
            let json: [String: Any?] = try JSONEncoderService().json(encodable: encodable)
            
            let encodable2: SomeObject = try! JSONDecoderService().decodable(json: json) // Force-unwrap
            XCTAssertEqual(encodable2.key, encodable.key)
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testEncodableToJSONArray() {
        let encodables: [SomeObject] = [.init(key: "value1"), .init(key: "value2")]
        
        do {
            let jsonArray: [[String: Any?]] = try JSONEncoderService().jsonArray(encodable: encodables)
            
            let encodables2: [SomeObject] = try! JSONDecoderService().decodable(jsonArray: jsonArray) // Force-unwrap
            for i in encodables.indices {
                XCTAssertEqual(encodables2[i].key, encodables[i].key)
            }
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
