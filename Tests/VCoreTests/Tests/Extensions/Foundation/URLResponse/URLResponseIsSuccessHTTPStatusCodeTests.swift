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
        guard
            let urlResponse: HTTPURLResponse = .init(
                url: #url("https://www.apple.com"),
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )
        else {
            VCoreLogError("Failed to generate test data")
            fatalError()
        }

        let isSuccess: Bool = urlResponse.isSuccessHTTPStatusCode

        XCTAssertTrue(isSuccess)
    }
    
    func testFailure() {
        guard
            let urlResponse: HTTPURLResponse = .init(
                url: #url("https://www.apple.com"),
                statusCode: 404,
                httpVersion: nil,
                headerFields: nil
            )
        else {
            VCoreLogError("Failed to generate test data")
            fatalError()
        }

        let isSuccess: Bool = urlResponse.isSuccessHTTPStatusCode

        XCTAssertFalse(isSuccess)
    }
}
