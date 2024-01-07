//
//  URLResponseIsSuccessHTTPStatusCodeTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class URLResponseIsSuccessHTTPStatusCodeTests: XCTestCase {
    func testSuccess() {
        let urlResponse: HTTPURLResponse = .init(
            url: #URL("https://www.apple.com"),
            statusCode: (200...299).randomElement()!, // Force-unwrap
            httpVersion: nil,
            headerFields: nil
        )!
        
        let result: Bool = urlResponse.isSuccessHTTPStatusCode
        
        XCTAssertTrue(result)
    }
    
    func testFailure() {
        let urlResponse: HTTPURLResponse = .init(
            url: #URL("https://www.apple.com"),
            statusCode: 404,
            httpVersion: nil,
            headerFields: nil
        )!
        
        let result: Bool = urlResponse.isSuccessHTTPStatusCode
        
        XCTAssertFalse(result)
    }
}
