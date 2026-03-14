//
//  URLInitWithPathAndQueryParametersTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 03.09.23.
//

import Foundation
import Testing
@testable import VCore

@Suite
nonisolated struct URLInitWithPathAndQueryParametersTests {
    @Test
    func testFullDeclaration() throws {
        let string: String = "https://website.com"
        let pathParameters: [String] = ["path", "to", "resource"]
        let queryParameters: [(key: String, value: String)] = [
            ("key1", "value1"),
            ("key2", "value2")
        ]

        let url: URL = try #require(
            URL(
                string: string,
                pathParameters: pathParameters,
                queryParameters: queryParameters
            )
        )

        #expect(
            [
                "https://website.com/path/to/resource?key2=value2&key1=value1",
                "https://website.com/path/to/resource?key1=value1&key2=value2"
            ]
                .contains(url.absoluteString)
        )
        
        #expect(url.scheme == "https")
        
        #expect(url.host == "website.com")
        
        #expect(url.path == "/path/to/resource")
        
        #expect(
            [
                "key1=value1&key2=value2",
                "key2=value2&key1=value1"
            ]
                .contains(url.query)
        )
    }

    @Test
    func testEmptyString() {
        let string: String = ""
        let pathParameters: [String] = ["path", "to", "resource"]
        let queryParameters: [(key: String, value: String)] = [
            ("key1", "value1"),
            ("key2", "value2")
        ]

        let url: URL? = .init(
            string: string,
            pathParameters: pathParameters,
            queryParameters: queryParameters
        )

        #expect(url == nil)
    }

    @Test
    func testEmptyPathParameters() throws {
        let string: String = "https://website.com"
        let pathParameters: [String] = []
        let queryParameters: [(key: String, value: String)] = [("key", "value")]

        let url: URL = try #require(
            URL(
                string: string,
                pathParameters: pathParameters,
                queryParameters: queryParameters
            )
        )
        
        #expect(url.absoluteString == "https://website.com?key=value")
        #expect(url.path == "")
    }

    @Test
    func testEmptyQueryParameters() throws {
        let string: String = "https://website.com"
        let pathParameters: [String] = ["path", "to", "resource"]
        let queryParameters: [(key: String, value: String)] = []

        let url: URL = try #require(
            URL(
                string: string,
                pathParameters: pathParameters,
                queryParameters: queryParameters
            )
        )
        
        #expect(url.absoluteString == "https://website.com/path/to/resource")
        #expect(url.query == nil)
    }
}
