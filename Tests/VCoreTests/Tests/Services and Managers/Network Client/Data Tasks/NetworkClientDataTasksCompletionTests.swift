//
//  NetworkClientDataTasksCompletionTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 15.06.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class NetworkClientDataTasksCompletionTests: XCTestCase {
    // MARK: Test Data
    /*private*/ struct Post: Decodable {
        let id: Int?
        let userID: Int?
        let title: String?
        let body: String?
        
        private enum CodingKeys: String, CodingKey {
            case id = "id"
            case userID = "userId"
            case title = "title"
            case body = "body"
        }
    }
    
    // MARK: Tests
    func testDataTaskNoDataCompletion() {
        guard NetworkReachabilityService.shared.isConnectedToNetwork else { return }
        
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
        guard NetworkReachabilityService.shared.isConnectedToNetwork else { return }
        
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
                    XCTAssertEqual(json["json"]?.toUnwrappedJSON["key"]?.toString, "value")
                    
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
        guard NetworkReachabilityService.shared.isConnectedToNetwork else { return }
        
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
                    XCTAssertEqual(json["json"]?.toUnwrappedJSON["key"]?.toString, "value")
                    
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
        guard NetworkReachabilityService.shared.isConnectedToNetwork else { return }
        
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
        guard NetworkReachabilityService.shared.isConnectedToNetwork else { return }
        
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
