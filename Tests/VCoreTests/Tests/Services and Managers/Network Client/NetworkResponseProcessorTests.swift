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
    private let networkClient: NetworkClient = .init(responseProcessor: HTTPBinNetworkReponseProcessor())

    func testData() async {
        guard NetworkReachabilityService.isConnectedToNetwork else { return }
        
        do {
            var request: NetworkRequest = .init(url: "https://httpbin.org/post")
            request.method = .POST
            try request.addHeaders(encodable: JSONRequestHeaders())
            try request.addBody(json: ["key": "value"])
            
            let json: [String: Any?] = try await networkClient.json(from: request)
            
            XCTAssertEqual(json["key"]?.toString, "value")
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

private struct HTTPBinNetworkReponseProcessor: NetworkResponseProcessor {
    func error(_ error: Error) throws {}

    func response(_ data: Data, _ response: URLResponse) throws -> URLResponse { response }

    func data(_ data: Data, _ response: URLResponse) throws -> Data {
        guard
            let json: [String: Any?] = try? JSONDecoderService.json(from: data),
            let dataJSON: [String: Any?] = json["json"]?.toJSON,
            let dataData: Data = try? JSONEncoderService.data(from: dataJSON)
        else {
            throw HTTPBinNetworkError(code: 1, description: "Incomplete Data")
        }

        return dataData
    }
}

private struct HTTPBinNetworkError: Error, LocalizedError {
    let code: Int
    let description: String
    
    var errorDescription: String? { description }
}
