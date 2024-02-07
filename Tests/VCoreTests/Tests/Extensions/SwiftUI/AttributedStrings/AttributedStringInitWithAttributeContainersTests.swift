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
        let string: String = "Lorem <b>ipsum</b> dolor"

        let components = try string.components(separatedByTagNames: ["b"])

        XCTAssertEqual(
            testable(components),
            testable([(nil, "Lorem "), ("b", "ipsum"), (nil, " dolor")])
        )
    }

    func testMultipleTags() throws {
        let string: String = "Lorem <b>ipsum dolor</b> sit amet, <c>consectetur adipiscing</c> elit"

        let components = try string.components(separatedByTagNames: ["b", "c"])

        XCTAssertEqual(
            testable(components),
            testable([(nil, "Lorem "), ("b", "ipsum dolor"), (nil, " sit amet, "), ("c", "consectetur adipiscing"), (nil, " elit")])
        )
    }

    func testStartingTag() throws {
        let string: String = "<b>Lorem</b> ipsum dolor"

        let components = try string.components(separatedByTagNames: ["b"])

        XCTAssertEqual(
            testable(components),
            testable([("b", "Lorem"), (nil, " ipsum dolor")])
        )
    }

    func testEndingTag() throws {
        let string: String = "Lorem ipsum <b>dolor</b>"

        let components = try string.components(separatedByTagNames: ["b"])

        XCTAssertEqual(
            testable(components),
            testable([(nil, "Lorem ipsum "), ("b", "dolor")])
        )
    }

    func testNestedTagsNotSupported() {
        let string: String = "Lorem <b>ipsum <c>dolor</c> sit</b> amet"

        XCTAssertThrowsError(
            try string.components(separatedByTagNames: ["b", "c"]),
            error: StringComponentsSeparatedByTagsError(.nestedTagsNotSupported)
        )
    }

    func testInvalidOpeningTag() {
        do {
            let string: String = "Lorem <b"

            XCTAssertThrowsError(
                try string.components(separatedByTagNames: ["b"]),
                error: StringComponentsSeparatedByTagsError(.invalidOpeningTag)
            )
        }

        do {
            let string: String = "Lorem <b ipsum</b> dolor"

            XCTAssertThrowsError(
                try string.components(separatedByTagNames: ["b"]),
                error: StringComponentsSeparatedByTagsError(.invalidOpeningTag)
            )
        }
    }

    func testSlashFoundInOpeningTag() {
        let string: String = "Lorem </b> ipsum</b> dolor"

        XCTAssertThrowsError(
            try string.components(separatedByTagNames: ["b"]),
            error: StringComponentsSeparatedByTagsError(.slashFoundInOpeningTag)
        )
    }

    func testOpeningTagNameNotFound() {
        let string: String = "Lorem <> ipsum</b> dolor"

        XCTAssertThrowsError(
            try string.components(separatedByTagNames: ["b"]),
            error: StringComponentsSeparatedByTagsError(.openingTagNameNotFound)
        )
    }

    func testInvalidClosingTag() {
        do {
            let string: String = "Lorem <b>ipsum</b"

            XCTAssertThrowsError(
                try string.components(separatedByTagNames: ["b"]),
                error: StringComponentsSeparatedByTagsError(.invalidClosingTag)
            )
        }

        do {
            let string: String = "Lorem <b>ipsum</b dolor"

            XCTAssertThrowsError(
                try string.components(separatedByTagNames: ["b"]),
                error: StringComponentsSeparatedByTagsError(.invalidClosingTag)
            )
        }

        do {
            let string: String = "> Lorem <b>ipsum</b> dolor"

            XCTAssertThrowsError(
                try string.components(separatedByTagNames: ["b"]),
                error: StringComponentsSeparatedByTagsError(.invalidClosingTag)
            )
        }
    }

    func testClosingTagSlashNotFound() {
        let string: String = "Lorem <b> ipsum<b> dolor"

        XCTAssertThrowsError(
            try string.components(separatedByTagNames: ["b"]),
            error: StringComponentsSeparatedByTagsError(.closingTagSlashNotFound)
        )
    }

    func testClosingTagNameNotFound() {
        let string: String = "Lorem <b> ipsum</> dolor"

        XCTAssertThrowsError(
            try string.components(separatedByTagNames: ["b"]),
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
