//
//  AttributedStringInitWithAttributeContainersTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 07.02.24.
//

import SwiftUI
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct AttributedStringInitWithAttributeContainersTests {
    // MARK: Tests - Valid
    @Test
    func testPlainString() {
        test(
            string: "Lorem ipsum",
            tagNames: [],
            result: [
                (nil, "Lorem ipsum")
            ]
        )
    }

    @Test
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

    @Test
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

    @Test
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

    @Test
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

    @Test
    func testSpecialCharacters() {
        test(
            string: "Lorem <a><</a>",
            tagNames: ["a"],
            result: [
                (nil, "Lorem "),
                ("a", "<")
            ]
        )

        test(
            string: "Lorem <a>></a>",
            tagNames: ["a"],
            result: [
                (nil, "Lorem "),
                ("a", ">")
            ]
        )

        test(
            string: "Lorem <a>/</a>",
            tagNames: ["a"],
            result: [
                (nil, "Lorem "),
                ("a", "/")
            ]
        )
    }

    // MARK: Tests - Invalid
    @Test
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

    @Test
    func testInvalidOpeningTag() {
        test(
            string: "Lorem <a",
            tagNames: ["a"],
            result: [
                (nil, "Lorem <a")
            ]
        )

        test(
            string: "Lorem <a ipsum</a> dolor",
            tagNames: ["a"],
            result: [
                (nil, "Lorem <a ipsum</a> dolor")
            ]
        )
    }

    @Test
    func testSlashFoundInOpeningTag() {
        test(
            string: "Lorem </a>ipsum</a> dolor",
            tagNames: ["a"],
            result: [
                (nil, "Lorem </a>ipsum</a> dolor")
            ]
        )
    }

    @Test
    func testOpeningTagNameNotFound() {
        test(
            string: "Lorem <> ipsum</a> dolor",
            tagNames: ["a"],
            result: [
                (nil, "Lorem <> ipsum</a> dolor")
            ]
        )
    }

    @Test
    func testInvalidClosingTag() {
        test(
            string: "Lorem <a>ipsum</a",
            tagNames: ["a"],
            result: [
                (nil, "Lorem "),
                (nil, "ipsum</a")
            ]
        )

        test(
            string: "Lorem <a>ipsum</a dolor",
            tagNames: ["a"],
            result: [
                (nil, "Lorem "),
                (nil, "ipsum</a dolor")
            ]
        )

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

    @Test
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

    @Test
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
        #expect(
            testable(string.components(separatedByTagNames: tagNames)) ==
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
