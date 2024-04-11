//
//  AttributedStringInitWithAttributeContainersTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 07.02.24.
//

import SwiftUI
import XCTest
@testable import VCore

// MARK: - Tests
final class AttributedStringInitWithAttributeContainersTests: XCTestCase {
    // MARK: Tests
    func testPlainString() throws {
        let string: String = "Lorem ipsum"

        let components = try string.components(separatedByTagNames: [])

        XCTAssertEqual(
            testable(components),
            testable([(nil, "Lorem ipsum")])
        )
    }

    func testSingleTag() throws {
        let string: String = "Lorem <a>ipsum</a> dolor"

        let components = try string.components(separatedByTagNames: ["a"])

        XCTAssertEqual(
            testable(components),
            testable([(nil, "Lorem "), ("a", "ipsum"), (nil, " dolor")])
        )
    }

    func testMultipleTags() throws {
        let string: String = "Lorem <a>ipsum dolor</a> sit amet, <b>consectetur adipiscing</b> elit"

        let components = try string.components(separatedByTagNames: ["a", "b"])

        XCTAssertEqual(
            testable(components),
            testable([(nil, "Lorem "), ("a", "ipsum dolor"), (nil, " sit amet, "), ("b", "consectetur adipiscing"), (nil, " elit")])
        )
    }

    func testStartingTag() throws {
        let string: String = "<a>Lorem</a> ipsum dolor"

        let components = try string.components(separatedByTagNames: ["a"])

        XCTAssertEqual(
            testable(components),
            testable([("a", "Lorem"), (nil, " ipsum dolor")])
        )
    }

    func testEndingTag() throws {
        let string: String = "Lorem ipsum <a>dolor</a>"

        let components = try string.components(separatedByTagNames: ["a"])

        XCTAssertEqual(
            testable(components),
            testable([(nil, "Lorem ipsum "), ("a", "dolor")])
        )
    }

    func testNestedTagsNotSupported() {
        let string: String = "Lorem <a>ipsum <b>dolor</b> sit</a> amet"

        XCTAssertThrowsError(
            try string.components(separatedByTagNames: ["a", "b"]),
            error: StringComponentsSeparatedByTagsError(.nestedTagsNotSupported)
        )
    }

    func testInvalidOpeningTag() {
        do {
            let string: String = "Lorem <a"

            XCTAssertThrowsError(
                try string.components(separatedByTagNames: ["a"]),
                error: StringComponentsSeparatedByTagsError(.invalidOpeningTag)
            )
        }

        do {
            let string: String = "Lorem <a ipsum</a> dolor"

            XCTAssertThrowsError(
                try string.components(separatedByTagNames: ["a"]),
                error: StringComponentsSeparatedByTagsError(.invalidOpeningTag)
            )
        }
    }

    func testSlashFoundInOpeningTag() {
        let string: String = "Lorem </a>ipsum</a> dolor"

        XCTAssertThrowsError(
            try string.components(separatedByTagNames: ["a"]),
            error: StringComponentsSeparatedByTagsError(.slashFoundInOpeningTag)
        )
    }

    func testOpeningTagNameNotFound() {
        let string: String = "Lorem <> ipsum</a> dolor"

        XCTAssertThrowsError(
            try string.components(separatedByTagNames: ["a"]),
            error: StringComponentsSeparatedByTagsError(.openingTagNameNotFound)
        )
    }

    func testInvalidClosingTag() {
        do {
            let string: String = "Lorem <a>ipsum</b"

            XCTAssertThrowsError(
                try string.components(separatedByTagNames: ["a"]),
                error: StringComponentsSeparatedByTagsError(.invalidClosingTag)
            )
        }

        do {
            let string: String = "Lorem <a>ipsum</a dolor"

            XCTAssertThrowsError(
                try string.components(separatedByTagNames: ["a"]),
                error: StringComponentsSeparatedByTagsError(.invalidClosingTag)
            )
        }

        do {
            let string: String = "> Lorem <a>ipsum</a> dolor"

            XCTAssertThrowsError(
                try string.components(separatedByTagNames: ["a"]),
                error: StringComponentsSeparatedByTagsError(.invalidClosingTag)
            )
        }
    }

    func testClosingTagSlashNotFound() {
        let string: String = "Lorem <a> ipsum<a> dolor"

        XCTAssertThrowsError(
            try string.components(separatedByTagNames: ["a"]),
            error: StringComponentsSeparatedByTagsError(.closingTagSlashNotFound)
        )
    }

    func testClosingTagNameNotFound() {
        let string: String = "Lorem <a> ipsum</> dolor"

        XCTAssertThrowsError(
            try string.components(separatedByTagNames: ["a"]),
            error: StringComponentsSeparatedByTagsError(.closingTagNameNotFound)
        )
    }

    // MARK: Helpers
    private func testable(
        _ values: [(Character?, String)]
    ) -> [Wrapper] {
        values.map { .init(tagName: $0, substring: $1) }
    }

    private struct Wrapper: Equatable {
        let tagName: Character?
        let substring: String
    }
}
