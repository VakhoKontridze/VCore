//
//  ImageInitWithDataTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.03.23.
//

import SwiftUI
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct ImageInitWithDataTests {
    @Test
    func test() throws {
#if canImport(UIKit)
        
        let uiImage: UIImage = try #require(
            UIImage(
                size: CGSize(dimension: 100),
                color: {
#if os(watchOS)
                    UIColor.blue
#else
                    UIColor.systemBlue
#endif
                }()
            )
        )
        
        let data: Data = try #require(
            uiImage.jpegData(compressionQuality: 1)
        )

        let _: Image = .init(data: data) // Checks that no crashes occur

#elseif canImport(AppKit)
        
        let nsImage: NSImage = try #require(
            NSImage(
                size: CGSize(dimension: 100),
                color: NSColor.systemBlue
            )
        )

        let data: Data = try #require(
            nsImage.tiffRepresentation
        )

        let _: Image = .init(data: data) // Checks that no crashes occur

#endif
    }
}
