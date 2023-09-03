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
        guard NetworkReachabilityService.shared.isConnectedToNetwork != false else {
            print("Not connected to network. Skipping \(String(describing: Self.self)).\(#function).")
            return
        }
        
        do {
            var request: NetworkRequest = .init(url: "https://jsonplaceholder.typicode.com/posts/1")
            request.method = .GET
            try request.addHeaders(object: JSONRequestHeaders())
            
            let json: [String: Any?] = try await NetworkClient.default.json(from: request)
            
            XCTAssertEqual(json["id"]?.toInt, 1)
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testPOST() async {
        guard NetworkReachabilityService.shared.isConnectedToNetwork != false else {
            print("Not connected to network. Skipping \(String(describing: Self.self)).\(#function).")
            return
        }
        
        do {
            var request: NetworkRequest = .init(url: "https://httpbin.org/post")
            request.method = .POST
            try request.addHeaders(object: JSONRequestHeaders())
            try request.addBody(json: ["key": "value"])
            
            let json: [String: Any?] = try await NetworkClient.default.json(from: request)
            
            XCTAssertEqual(json["json"]?.toUnwrappedJSON["key"]?.toString, "value")
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testPUT() async {
        guard NetworkReachabilityService.shared.isConnectedToNetwork != false else {
            print("Not connected to network. Skipping \(String(describing: Self.self)).\(#function).")
            return
        }
        
        do {
            var request: NetworkRequest = .init(url: "https://httpbin.org/put")
            request.method = .PUT
            try request.addHeaders(object: JSONRequestHeaders())
            try request.addBody(json: ["key": "value"])
            
            let json: [String: Any?] = try await NetworkClient.default.json(from: request)
            
            XCTAssertEqual(json["json"]?.toUnwrappedJSON["key"]?.toString, "value")
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testPATCH() async {
        guard NetworkReachabilityService.shared.isConnectedToNetwork != false else {
            print("Not connected to network. Skipping \(String(describing: Self.self)).\(#function).")
            return
        }
        
        do {
            var request: NetworkRequest = .init(url: "https://httpbin.org/patch")
            request.method = .PATCH
            try request.addHeaders(object: JSONRequestHeaders())
            try request.addBody(json: ["key": "value"])
            
            let json: [String: Any?] = try await NetworkClient.default.json(from: request)
            
            XCTAssertEqual(json["json"]?.toUnwrappedJSON["key"]?.toString, "value")
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testDELETE() async {
        guard NetworkReachabilityService.shared.isConnectedToNetwork != false else {
            print("Not connected to network. Skipping \(String(describing: Self.self)).\(#function).")
            return
        }
        
        do {
            var request: NetworkRequest = .init(url: "https://httpbin.org/delete")
            request.method = .DELETE
            try request.addHeaders(object: JSONRequestHeaders())
            try request.addBody(json: ["key": "value"])
            
            let json: [String: Any?] = try await NetworkClient.default.json(from: request)
            
            XCTAssertEqual(json["json"]?.toUnwrappedJSON["key"]?.toString, "value")
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    //func testHEAD() async {}
    
    //func testCONNECT() async {}
    
    //func testOPTIONS() async {}
    
    //func testTRACE() async {}
}
