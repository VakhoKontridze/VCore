//
//  NetworkClientTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class NetworkClientTests: XCTestCase {
    // MARK: Test Data
    private struct Post: Decodable {
        let id: Int?
        let userID: Int?
        let title: String?
        let body: String?
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case userID = "userId"
            case title = "title"
            case body = "body"
        }
    }
    
    // MARK: Data Tasks (Async)
    func testDataTaskNoDataAsync() async {
        guard NetworkReachabilityService.isConnectedToNetwork else { return }
        
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
        guard NetworkReachabilityService.isConnectedToNetwork else { return }
        
        do {
            var request: NetworkRequest = .init(url: "https://httpbin.org/post")
            request.method = .POST
            try request.addHeaders(encodable: JSONRequestHeaders())
            try request.addBody(json: ["key": "value"])
            
            let data: Data = try await NetworkClient.default.data(from: request)
            
            let json: [String: Any?] = try JSONDecoderService.json(data: data)
            XCTAssertEqual(json["json"]?.toWrappedJSON["key"]?.toString, "value")
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testDataTaskJSONAsync() async {
        guard NetworkReachabilityService.isConnectedToNetwork else { return }
        
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
    
    func testDataTaskJSONArrayAsync() async {
        guard NetworkReachabilityService.isConnectedToNetwork else { return }
        
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
        guard NetworkReachabilityService.isConnectedToNetwork else { return }
        
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
    
    // MARK: Data Tasks (Completion)
    func testDataTaskNoDataCompletion() {
        guard NetworkReachabilityService.isConnectedToNetwork else { return }
        
        let expectation: XCTestExpectation = expectation(description: "NetworkClientCompletion")
        defer { waitForExpectations(timeout: 10) }
        
        do {
            var request: NetworkRequest = .init(url: "https://httpbin.org/post")
            request.method = .POST
            try request.addHeaders(encodable: JSONRequestHeaders())
            try request.addBody(json: ["key": "value"])
            
            NetworkClient.default.noData(from: request, completion: { result in
                switch result {
                case .success:
                    XCTAssertTrue(true)
                    
                    expectation.fulfill()
                
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            })
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testDataTaskDataCompletion() {
        guard NetworkReachabilityService.isConnectedToNetwork else { return }
        
        let expectation: XCTestExpectation = expectation(description: "NetworkClientCompletion")
        defer { waitForExpectations(timeout: 10) }
        
        do {
            var request: NetworkRequest = .init(url: "https://httpbin.org/post")
            request.method = .POST
            try request.addHeaders(encodable: JSONRequestHeaders())
            try request.addBody(json: ["key": "value"])
            
            NetworkClient.default.data(from: request, completion: { result in
                switch result {
                case .success(let data):
                    let json: [String: Any?] = try! JSONDecoderService.json(data: data) // fatalError
                    XCTAssertEqual(json["json"]?.toWrappedJSON["key"]?.toString, "value")
                    
                    expectation.fulfill()
                
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            })
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testDataTaskJSONCompletion() {
        guard NetworkReachabilityService.isConnectedToNetwork else { return }
        
        let expectation: XCTestExpectation = expectation(description: "NetworkClientCompletion")
        defer { waitForExpectations(timeout: 10) }
        
        do {
            var request: NetworkRequest = .init(url: "https://httpbin.org/post")
            request.method = .POST
            try request.addHeaders(encodable: JSONRequestHeaders())
            try request.addBody(json: ["key": "value"])

            NetworkClient.default.json(from: request, completion: { result in
                switch result {
                case .success(let json):
                    XCTAssertEqual(json["json"]?.toWrappedJSON["key"]?.toString, "value")
                    
                    expectation.fulfill()
                
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            })

        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func testDataTaskJSONArrayCompletion() {
        guard NetworkReachabilityService.isConnectedToNetwork else { return }
        
        let expectation: XCTestExpectation = expectation(description: "NetworkClientCompletion")
        defer { waitForExpectations(timeout: 10) }
        
        do {
            var request: NetworkRequest = .init(url: "https://jsonplaceholder.typicode.com/posts")
            request.method = .GET
            try request.addHeaders(encodable: JSONRequestHeaders())

            NetworkClient.default.jsonArray(from: request, completion: { result in
                switch result {
                case .success(let jsonArray):
                    XCTAssertEqual(jsonArray.first?["id"]?.toInt, 1)
                    
                    expectation.fulfill()
                
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            })

        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func testDataTaskDecodableCompletion() {
        guard NetworkReachabilityService.isConnectedToNetwork else { return }
        
        let expectation: XCTestExpectation = expectation(description: "NetworkClientCompletion")
        defer { waitForExpectations(timeout: 10) }
        
        do {
            var request: NetworkRequest = .init(url: "https://jsonplaceholder.typicode.com/posts")
            request.method = .GET
            try request.addHeaders(encodable: JSONRequestHeaders())

            NetworkClient.default.decodable([Post].self, from: request, completion: { result in
                switch result {
                case .success(let posts):
                    XCTAssertEqual(posts.first?.id, 1)
                    
                    expectation.fulfill()
                
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            })

        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
