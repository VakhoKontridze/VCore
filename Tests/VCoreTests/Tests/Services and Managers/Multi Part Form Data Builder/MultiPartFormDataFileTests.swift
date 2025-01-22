//
//  MultipartFormDataFileTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 15.05.22.
//

import Foundation
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct MultipartFormDataFileTests {
    @Test
    func testFilename() {
        do {
            let file: MultipartFormDataFile = .init(
                filename: nil,
                mimeType: "",
                data: Data()
            )
            
            #expect(file.generateFilename(key: "file") == "file")
        }
        
        do {
            let file: MultipartFormDataFile = .init(
                filename: nil,
                mimeType: "image/jpeg",
                data: Data()
            )
            
            #expect(file.generateFilename(key: "file") == "file.jpeg")
        }
        
        do {
            let file: MultipartFormDataFile = .init(
                filename: "small-image.jpg",
                mimeType: "",
                data: Data()
            )
            
            #expect(file.generateFilename(key: "file") == "small-image.jpg")
        }
        
        do {
            let file: MultipartFormDataFile = .init(
                filename: "small-image.jpg",
                mimeType: "image/jpeg",
                data: Data()
            )
            
            #expect(file.generateFilename(key: "file") == "small-image.jpg")
        }
    }
}
