//
//  NetworkRequestMethodTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class NetworkRequestMethodTests: XCTestCase {
    func testGET() async {
        #if !os(watchOS)
        guard NetworkReachabilityService.isConnectedToNetwork else { return }
        #endif
        
        do {
            var request: NetworkRequest = .init(url: "https://jsonplaceholder.typicode.com/posts/1")
            request.method = .GET
            try request.addHeaders(encodable: JSONRequestHeaders())
            
            let json: [String: Any?] = try await NetworkClient.default.json(from: request)
            
            XCTAssertEqual(json["id"]?.toInt, 1)
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testPOST() async {
        #if !os(watchOS)
        guard NetworkReachabilityService.isConnectedToNetwork else { return }
        #endif
        
        do {
            var request: NetworkRequest = .init(url: "https://httpbin.org/post")
            request.method = .POST
            try request.addHeaders(encodable: JSONRequestHeaders())
            try request.addBody(json: ["key": "value"])
            
            let json: [String: Any?] = try await NetworkClient.default.json(from: request)
            
            XCTAssertEqual(json["json"]?.toWrappedJSON["key"]?.toString, "value")
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testPUT() async {
        #if !os(watchOS)
        guard NetworkReachabilityService.isConnectedToNetwork else { return }
        #endif
        
        do {
            var request: NetworkRequest = .init(url: "https://httpbin.org/put")
            request.method = .PUT
            try request.addHeaders(encodable: JSONRequestHeaders())
            try request.addBody(json: ["key": "value"])
            
            let json: [String: Any?] = try await NetworkClient.default.json(from: request)
            
            XCTAssertEqual(json["json"]?.toWrappedJSON["key"]?.toString, "value")
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testPATCH() async {
        #if !os(watchOS)
        guard NetworkReachabilityService.isConnectedToNetwork else { return }
        #endif
        
        do {
            var request: NetworkRequest = .init(url: "https://httpbin.org/patch")
            request.method = .PATCH
            try request.addHeaders(encodable: JSONRequestHeaders())
            try request.addBody(json: ["key": "value"])
            
            let json: [String: Any?] = try await NetworkClient.default.json(from: request)
            
            XCTAssertEqual(json["json"]?.toWrappedJSON["key"]?.toString, "value")
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testDELETE() async {
        #if !os(watchOS)
        guard NetworkReachabilityService.isConnectedToNetwork else { return }
        #endif
        
        do {
            var request: NetworkRequest = .init(url: "https://httpbin.org/delete")
            request.method = .DELETE
            try request.addHeaders(encodable: JSONRequestHeaders())
            try request.addBody(json: ["key": "value"])
            
            let json: [String: Any?] = try await NetworkClient.default.json(from: request)
            
            XCTAssertEqual(json["json"]?.toWrappedJSON["key"]?.toString, "value")
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    //func testHEAD() async {}
    
    //func testCONNECT() async {}
    
    //func testOPTIONS() async {}
    
    //func testTRACE() async {}
}
