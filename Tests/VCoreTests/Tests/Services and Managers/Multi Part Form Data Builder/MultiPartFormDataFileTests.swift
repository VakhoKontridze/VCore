//
//  MultipartFormDataFileTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 15.05.22.
//

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class MultipartFormDataFileTests: XCTestCase {
    func testInit() {
        let file1: MultipartFormDataFile = .init(
            filename: nil,
            mimeType: "image/jpeg",
            data: Data()
        )
        XCTAssertEqual(file1.generateFilename(key: "file"), "file.jpeg")

        let file2: MultipartFormDataFile = .init(
            filename: "small-image.jpg",
            mimeType: "image/jpeg",
            data: Data()
        )
        XCTAssertEqual(file2.generateFilename(key: "file"), "small-image.jpg")

        let file3: MultipartFormDataFile = .init(
            filename: nil,
            mimeType: "",
            data: Data()
        )
        XCTAssertEqual(file3.generateFilename(key: "file"), "file")

        let file4: MultipartFormDataFile = .init(
            filename: "small-image.jpg",
            mimeType: "image/jpeg",
            data: Data()
        )
        XCTAssertEqual(file4.generateFilename(key: "file"), "small-image.jpg")
    }
}
