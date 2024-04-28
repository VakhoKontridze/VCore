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
    // MARK: Tests - Valid
    func testPlainString() {
        test(
            string: "Lorem ipsum",
            tagNames: [],
            result: [
                (nil, "Lorem ipsum")
            ]
        )
    }

    func testSingleTag() {
        test(
            string: "Lorem <a>ipsum</a> dolor",
            tagNames: ["a"],
            result: [
                (nil, "Lorem "),
                ("a", "ipsum"),
                (nil, " dolor")
            ]
        )
    }

    func testMultipleTags() {
        test(
            string: "Lorem <a>ipsum dolor</a> sit amet, <b>consectetur adipiscing</b> elit",
            tagNames: ["a", "b"],
            result: [
                (nil, "Lorem "),
                ("a", "ipsum dolor"),
                (nil, " sit amet, "),
                ("b", "consectetur adipiscing"),
                (nil, " elit")
            ]
        )
    }

    func testStartingTag() {
        test(
            string: "<a>Lorem</a> ipsum dolor",
            tagNames: ["a"],
            result: [
                ("a", "Lorem"),
                (nil, " ipsum dolor")
            ]
        )
    }

    func testEndingTag() {
        test(
            string: "Lorem <a>ipsum</a>",
            tagNames: ["a"],
            result: [
                (nil, "Lorem "),
                ("a", "ipsum")
            ]
        )
    }

    func testSpecialCharacters() {
        do {
            test(
                string: "Lorem <a><</a>",
                tagNames: ["a"],
                result: [
                    (nil, "Lorem "),
                    ("a", "<")
                ]
            )
        }

        do {
            test(
                string: "Lorem <a>></a>",
                tagNames: ["a"],
                result: [
                    (nil, "Lorem "),
                    ("a", ">")
                ]
            )
        }

        do {
            test(
                string: "Lorem <a>/</a>",
                tagNames: ["a"],
                result: [
                    (nil, "Lorem "),
                    ("a", "/")
                ]
            )
        }
    }

    // MARK: Tests - Invalid
    func testNestedTagsNotSupported() {
        test(
            string: "Lorem <a>ipsum <b>dolor</b> sit</a> amet",
            tagNames: ["a", "b"],
            result: [
                (nil, "Lorem "),
                ("a", "ipsum <b>dolor</b> sit"),
                (nil, " amet")
            ]
        )
    }

    func testInvalidOpeningTag() {
        do {
            test(
                string: "Lorem <a",
                tagNames: ["a"],
                result: [
                    (nil, "Lorem <a")
                ]
            )
        }

        do {
            test(
                string: "Lorem <a ipsum</a> dolor",
                tagNames: ["a"],
                result: [
                    (nil, "Lorem <a ipsum</a> dolor")
                ]
            )
        }
    }

    func testSlashFoundInOpeningTag() {
        test(
            string: "Lorem </a>ipsum</a> dolor",
            tagNames: ["a"],
            result: [
                (nil, "Lorem </a>ipsum</a> dolor")
            ]
        )
    }

    func testOpeningTagNameNotFound() {
        test(
            string: "Lorem <> ipsum</a> dolor",
            tagNames: ["a"],
            result: [
                (nil, "Lorem <> ipsum</a> dolor")
            ]
        )
    }

    func testInvalidClosingTag() {
        do {
            test(
                string: "Lorem <a>ipsum</a",
                tagNames: ["a"],
                result: [
                    (nil, "Lorem "),
                    (nil, "ipsum</a")
                ]
            )
        }

        do {
            test(
                string: "Lorem <a>ipsum</a dolor",
                tagNames: ["a"],
                result: [
                    (nil, "Lorem "),
                    (nil, "ipsum</a dolor")
                ]
            )
        }

        do {
            test(
                string: "> Lorem <a>ipsum</a> dolor",
                tagNames: ["a"],
                result: [
                    (nil, "> Lorem "),
                    ("a", "ipsum"),
                    (nil, " dolor")
                ]
            )
        }
    }

    func testClosingTagSlashNotFound() {
        test(
            string: "Lorem <a>ipsum<a> dolor",
            tagNames: ["a"],
            result: [
                (nil, "Lorem "),
                (nil, "ipsum<a> dolor"),
            ]
        )
    }

    func testClosingTagNameNotFound() {
        test(
            string: "Lorem <a>ipsum</> dolor",
            tagNames: ["a"],
            result: [
                (nil, "Lorem "),
                (nil, "ipsum</> dolor"),
            ]
        )
    }

    // MARK: Helpers
    private func test(
        string: String,
        tagNames: [Character],
        result: [(Character?, String)]
    ) {
        XCTAssertEqual(
            testable(string.components(separatedByTagNames: tagNames)),
            testable(result)
        )
    }

    private func testable(
        _ values: [(Character?, String)]
    ) -> [Wrapper] {
        values.map { Wrapper(tagName: $0, substring: $1) }
    }

    private struct Wrapper: Equatable {
        let tagName: Character?
        let substring: String
    }
}
