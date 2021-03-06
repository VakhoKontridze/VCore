//
//  NetworkClientDataTasksAsyncTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class NetworkClientDataTasksAsyncTests: XCTestCase {
    // MARK: Test Data
    private typealias Post = NetworkClientDataTasksCompletionTests.Post
    
    // MARK: Tests
    func testDataTaskNoDataAsync() async {
        guard NetworkReachabilityService.shared.isConnectedToNetwork else { return }
        
        do {
            var request: NetworkRequest = .init(url: "https://httpbin.org/post")
            request.method = .POST
            try request.addHeaders(encodable: JSONRequestHeaders())
            try request.addBody(json: ["key": "value"])
            
            try await NetworkClient.default.noData(from: request)
            
            XCTAssertTrue(true)
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testDataTaskDataAsync() async {
        guard NetworkReachabilityService.shared.isConnectedToNetwork else { return }
        
        do {
            var request: NetworkRequest = .init(url: "https://httpbin.org/post")
            request.method = .POST
            try request.addHeaders(encodable: JSONRequestHeaders())
            try request.addBody(json: ["key": "value"])
            
            let data: Data = try await NetworkClient.default.data(from: request)
            
            let json: [String: Any?] = try JSONDecoderService.json(data: data)
            XCTAssertEqual(json["json"]?.toUnwrappedJSON["key"]?.toString, "value")
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testDataTaskJSONAsync() async {
        guard NetworkReachabilityService.shared.isConnectedToNetwork else { return }
        
        do {
            var request: NetworkRequest = .init(url: "https://httpbin.org/post")
            request.method = .POST
            try request.addHeaders(encodable: JSONRequestHeaders())
            try request.addBody(json: ["key": "value"])
            
            let json: [String: Any?] = try await NetworkClient.default.json(from: request)
            
            XCTAssertEqual(json["json"]?.toUnwrappedJSON["key"]?.toString, "value")
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testDataTaskJSONArrayAsync() async {
        guard NetworkReachabilityService.shared.isConnectedToNetwork else { return }
        
        do {
            var request: NetworkRequest = .init(url: "https://jsonplaceholder.typicode.com/posts")
            request.method = .GET
            try request.addHeaders(encodable: JSONRequestHeaders())
            
            let jsonArray: [[String: Any?]] = try await NetworkClient.default.jsonArray(from: request)
            
            XCTAssertEqual(jsonArray.first?["id"]?.toInt, 1)
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testDataTaskDecodableAsync() async {
        guard NetworkReachabilityService.shared.isConnectedToNetwork else { return }
        
        do {
            var request: NetworkRequest = .init(url: "https://jsonplaceholder.typicode.com/posts")
            request.method = .GET
            try request.addHeaders(encodable: JSONRequestHeaders())
            
            let posts: [Post] = try await NetworkClient.default.decodable(from: request)
            
            XCTAssertEqual(posts.first?.id, 1)
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
