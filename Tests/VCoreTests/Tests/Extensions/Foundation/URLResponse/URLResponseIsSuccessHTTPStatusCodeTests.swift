//
//  URLResponseIsSuccessHTTPStatusCodeTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct URLResponseIsSuccessHTTPStatusCodeTests {
    @Test
    func testSuccess() throws {
        let urlResponse: HTTPURLResponse = try #require(
            HTTPURLResponse(
                url: #url("https://www.apple.com"),
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )
        )
        
        #expect(urlResponse.isSuccessHTTPStatusCode)
    }

    @Test
    func testFailure() throws {
        let urlResponse: HTTPURLResponse = try #require(
            HTTPURLResponse(
                url: #url("https://www.apple.com"),
                statusCode: 404,
                httpVersion: nil,
                headerFields: nil
            )
        )

        #expect(!urlResponse.isSuccessHTTPStatusCode)
    }
}
