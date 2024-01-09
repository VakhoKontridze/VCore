//
//  URLInitWithPathAndQueryParametersTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.09.23.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class URLInitWithPathAndQueryParametersTests: XCTestCase {
    func testFullDeclaration() {
        let string: String = "https://example.com"
        let pathParameters: [String] = ["path", "to", "resource"]
        let queryParameters: [String: String] = ["key1": "value1", "key2": "value2"]

        guard
            let url: URL = .init(
                string: string,
                pathParameters: pathParameters,
                queryParameters: queryParameters
            )
        else {
            XCTFail()
            return
        }

        XCTAssertEqual(
            url.absoluteString,
            oneOf: [
                "https://example.com/path/to/resource?key2=value2&key1=value1",
                "https://example.com/path/to/resource?key1=value1&key2=value2"
            ]
        )
        XCTAssertEqual(url.scheme, "https")
        XCTAssertEqual(url.host, "example.com")
        XCTAssertEqual(url.path, "/path/to/resource")
        XCTAssertEqual(url.query, oneOf: ["key1=value1&key2=value2", "key2=value2&key1=value1"])
    }

    func testEmptyString() {
        let string: String = ""
        let pathParameters: [String] = ["path", "to", "resource"]
        let queryParameters: [String: String] = ["key1": "value1", "key2": "value2"]

        let url: URL? = .init(
            string: string,
            pathParameters: pathParameters,
            queryParameters: queryParameters
        )

        XCTAssertNil(url)
    }

//    func testInvalidString() {
//        let string: String = "InvalidURL"
//        let pathParameters: [String] = ["path", "to", "resource"]
//        let queryParameters: [String: String] = ["key1": "value1", "key2": "value2"]
//
//        let url: URL? = .init(
//            string: string,
//            pathParameters: pathParameters,
//            queryParameters: queryParameters
//        )
//
//        XCTAssertNil(url)
//    }

    func testEmptyPathParameters() {
        let string: String = "https://example.com"
        let pathParameters: [String] = []
        let queryParameters: [String: String] = ["key": "value"]

        guard
            let url: URL = .init(
                string: string,
                pathParameters: pathParameters,
                queryParameters: queryParameters
            )
        else {
            XCTFail()
            return
        }

        XCTAssertEqual(url.absoluteString, "https://example.com?key=value")
        XCTAssertEqual(url.path, "")
    }

    func testEmptyQueryParameters() {
        let string: String = "https://example.com"
        let pathParameters: [String] = ["path", "to", "resource"]
        let queryParameters: [String: String] = [:]

        guard
            let url: URL = .init(
                string: string,
                pathParameters: pathParameters,
                queryParameters: queryParameters
            )
        else {
            XCTFail()
            return
        }

        XCTAssertEqual(url.absoluteString, "https://example.com/path/to/resource")
        XCTAssertEqual(url.query, nil)
    }
}
