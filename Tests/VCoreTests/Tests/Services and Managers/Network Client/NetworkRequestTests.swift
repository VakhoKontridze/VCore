//
//  NetworkRequestTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class NetworkRequestTests: XCTestCase {
    // MARK: Test Data
    private let url: String = "https://www.apple.com"
    
    private struct QueryParameters: Codable {
        let key: String?
    }
    
    private typealias Headers = QueryParameters
    
    private typealias Body = QueryParameters
    
    // MARK: Initializers
    func testInitString() {
        let request: NetworkRequest = .init(url: url)
        
        XCTAssertEqual(request.url, url)
    }
    
    func testInitURL() {
        let request: NetworkRequest = .init(url: URL(string: url)!)
        
        XCTAssertEqual(request.url, url)
    }
    
    // MARK: Path Parameters
    func testPathParametersStacking() {
        var request: NetworkRequest = .init(url: url)
        request.addPathParameters(string: "a")
        request.addPathParameters(stringArray: ["b", "c"])
        
        XCTAssertEqual(request.pathParameters, ["a", "b", "c"])
    }
    
    func testPathParametersString() {
        var request: NetworkRequest = .init(url: url)
        request.addPathParameters(string: "a")
        
        XCTAssertEqual(request.pathParameters, ["a"])
    }
    
    func testPathParametersStringArray() {
        var request: NetworkRequest = .init(url: url)
        request.addPathParameters(stringArray: ["a"])
        
        XCTAssertEqual(request.pathParameters, ["a"])
    }
    
    // MARK: Query Parameters
    func testQueryParametersStacing() {
        do {
            var request: NetworkRequest = .init(url: url)
            try request.addQueryParameters(json: ["key1": "value1"])
            try request.addQueryParameters(json: ["key2": "value2"])
            
            XCTAssertEqual(request.queryParameters["key1"], "value1")
            XCTAssertEqual(request.queryParameters["key2"], "value2")
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testQueryParametersJSON() {
        do {
            var request: NetworkRequest = .init(url: url)
            try request.addQueryParameters(json: ["key": "value"])
            
            XCTAssertEqual(request.queryParameters["key"], "value")
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testQueryParametersEncodable() {
        do {
            var request: NetworkRequest = .init(url: url)
            try request.addQueryParameters(encodable: QueryParameters(key: "value"))
            
            XCTAssertEqual(request.queryParameters["key"], "value")
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // MARK: Headers
    func testHeadersStacking() {
        var request: NetworkRequest = .init(url: url)
        request.addHeaders(json: ["key1": "value1"])
        request.addHeaders(json: ["key2": "value2"])
        
        XCTAssertEqual(request.headers["key1"], "value1")
        XCTAssertEqual(request.headers["key2"], "value2")
    }
    
    func testHeadersJSON() {
        var request: NetworkRequest = .init(url: url)
        request.addHeaders(json: ["key": "value"])
        
        XCTAssertEqual(request.headers["key"], "value")
    }
    
    func testHeadersEncodable() {
        do {
            var request: NetworkRequest = .init(url: url)
            try request.addHeaders(encodable: Headers(key: "value"))
            
            XCTAssertEqual(request.headers["key"], "value")
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // MARK: Body
    func testBodyStacking() {
        do {
            var request: NetworkRequest = .init(url: url)
            request.addBody(data: "[\"".data(using: .utf8)!)
            try request.addBody(json: ["key1": "value1"])
            request.addBody(data: ",".data(using: .utf8)!)
            try request.addBody(json: ["key2": "value2"])
            request.addBody(data: "\"]".data(using: .utf8)!)

            XCTAssertEqual(
                .init(data: request.body, encoding: .utf8)!,
                """
                ["{"key1":"value1"},{"key2":"value2"}"]
                """
            )
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testBodyData() {
        let data: Data = UIImage(size: .init(dimension: 100), color: .red)!.pngData()!
        
        var request: NetworkRequest = .init(url: url)
        request.addBody(data: data)
        
        XCTAssertEqual(request.body, data)
    }
    
    func testBodyJSON() {
        do {
            var request: NetworkRequest = .init(url: url)
            try request.addBody(json: ["key": "value"])
            
            XCTAssertEqual(
                try JSONDecoderService.json(from: request.body)["key"]?.toString,
                "value"
            )
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func testBodyEncodable() {
        do {
            var request: NetworkRequest = .init(url: url)
            try request.addBody(encodable: Body(key: "value"))
            
            let body: Body = try JSONDecoderService.decodable(from: request.body)
            XCTAssertEqual(
                body.key,
                "value"
            )
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
