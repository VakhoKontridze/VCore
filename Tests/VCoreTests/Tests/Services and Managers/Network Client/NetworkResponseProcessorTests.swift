//
//  NetworkResponseProcessorTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class NetworkResponseProcessorTests: XCTestCase {
    // MARK: Test Data
    private let networkClient: NetworkClient = .init(responseProcessor: TestNetworkResponseProcessor())
    
    // MARK: Tests
    func testResponse() {
        let code: Int = 404
        let message: String = "Something has gone wrong"
        
        let urlResponse: HTTPURLResponse = .init(
            url: URL(string: "https://www.apple.com")!, // Force-unwrap
            statusCode: code,
            httpVersion: nil,
            headerFields: nil
        )!
        
        let data: Data = try! JSONEncoder().encodeAnyToData([ // Force-unwrap
            "success": false,
            "code": code,
            "message": message
        ] as [String: Any])
        
        XCTAssertThrowsError(
            try TestNetworkResponseProcessor().response(data, urlResponse),
            "",
            { error in
                guard let error = error as? TestNetworkError else { fatalError() }
                
                XCTAssertEqual(error.code, code)
                XCTAssertEqual(error.description, message)
            }
        )
    }
    
    func testData() async {
        guard NetworkReachabilityService.shared.isConnectedToNetwork != false else {
            print("Not connected to network. Skipping \(String(describing: Self.self)).\(#function).")
            return
        }
        
        do {
            var request: NetworkRequest = .init(url: "https://httpbin.org/post")
            request.method = .POST
            try request.addHeaders(object: JSONRequestHeaders())
            try request.addBody(json: ["key": "value"])
            
            let json: [String: Any?] = try await networkClient.json(from: request)
            
            XCTAssertEqual(json["key"]?.toString, "value")
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

private struct TestNetworkResponseProcessor: NetworkResponseProcessor {
    func response(_ data: Data, _ response: URLResponse) throws -> URLResponse {
        if response.isSuccessHTTPStatusCode { return response }
        
        guard let json: [String: Any?] = try? JSONDecoder().decodeJSONFromData(data) else { return response }
        if json["success"]?.toBool == true { return response }
        
        guard
            let code: Int = json["code"]?.toInt,
            let description: String = json["message"]?.toString
        else {
            throw TestNetworkError(code: 99, description: "Unknown Error")
        }
        
        throw TestNetworkError(code: code, description: description)
    }
    
    func data(_ data: Data, _ response: URLResponse) throws -> Data {
        guard
            let json: [String: Any?] = try? JSONDecoder().decodeJSONFromData(data),
            let dataJSON: [String: Any?] = json["json"]?.toJSON,
            let dataData: Data = try? JSONEncoder().encodeAnyToData(dataJSON)
        else {
            throw TestNetworkError(code: 1, description: "Incomplete Data")
        }
        
        return dataData
    }
}

private struct TestNetworkError: Error, LocalizedError {
    let code: Int
    let description: String
    
    var errorDescription: String? { description }
}
