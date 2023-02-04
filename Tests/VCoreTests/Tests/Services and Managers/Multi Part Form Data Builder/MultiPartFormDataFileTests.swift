//
//  MultipartFormDataFileTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 15.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class MultipartFormDataFileTests: XCTestCase {
    func testInit() {
        let file1: _MultipartFormDataFile = .init(
            name: "file",
            file: .init(
                filename: nil,
                mimeType: "image/jpeg",
                data: .init()
            )
        )
        XCTAssertEqual(file1.filename, "file.jpeg")
        
        let file2: _MultipartFormDataFile = .init(
            name: "file",
            file: .init(
                filename: "small-image.jpg",
                mimeType: "image/jpeg",
                data: .init()
            )
        )
        XCTAssertEqual(file2.filename, "small-image.jpg")
            
        let file3: _MultipartFormDataFile = .init(
            name: "file",
            file: .init(
                filename: nil,
                mimeType: "",
                data: .init()
            )
        )
        XCTAssertEqual(file3.filename, "file")
        
        let file4: _MultipartFormDataFile = .init(
            name: "file",
            file:  .init(
                filename: "small-image.jpg",
                mimeType: "image/jpeg",
                data: .init()
            )
        )
        XCTAssertEqual(file4.filename, "small-image.jpg")
    }
}
