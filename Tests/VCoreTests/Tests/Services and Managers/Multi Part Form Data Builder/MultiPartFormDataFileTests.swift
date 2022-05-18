//
//  MultiPartFormDataFileTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 15.05.22.
//

import XCTest
@testable import VCore

// MARK: - Tests
final class MultiPartFormDataFileTests: XCTestCase {
    // MARK: Test Data
    private struct SomeMultiPartFormDataFile: AnyMultiPartFormDataFile {}
    
    // MARK: Tests
    func testInit() {
        let file1: _MultiPartFormDataFile = .init(
            name: "file",
            file: .init(
                filename: nil,
                mimeType: "image/jpeg",
                data: .init()
            )
        )
        XCTAssertEqual(file1.filename, "file.jpeg")
        
        let file2: _MultiPartFormDataFile = .init(
            name: "file",
            file: .init(
                filename: "image-1.jpg",
                mimeType: "image/jpeg",
                data: .init()
            )
        )
        XCTAssertEqual(file2.filename, "image-1.jpg")
            
        let file3: _MultiPartFormDataFile = .init(
            name: "file",
            file: .init(
                filename: nil,
                mimeType: "",
                data: .init()
            )
        )
        XCTAssertEqual(file3.filename, "file")
        
        let file4: _MultiPartFormDataFile = .init(
            name: "file",
            file:  .init(
                filename: "image-1.jpg",
                mimeType: "image/jpeg",
                data: .init()
            )
        )
        XCTAssertEqual(file4.filename, "image-1.jpg")
    }
}
