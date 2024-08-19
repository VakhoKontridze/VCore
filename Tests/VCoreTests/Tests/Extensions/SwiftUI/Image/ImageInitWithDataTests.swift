//
//  ImageInitWithDataTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.03.23.
//

import SwiftUI
import OSLog
import XCTest
@testable import VCore

// MARK: - Tests
final class ImageInitWithDataTests: XCTestCase {
    func test() {
#if canImport(UIKit)
        guard
            let uiImage: UIImage = .init(
                size: CGSize(dimension: 100),
                color: {
#if !os(watchOS)
                UIColor.systemBlue
#else
                UIColor.blue
#endif
                }()
            ),
            let data: Data = uiImage.jpegData(compressionQuality: 1)
        else {
            Logger.imageInitWithDataTests.critical("Failed to generate test data")
            fatalError()
        }

        let _: Image = .init(data: data) // Check that no crashes occur
#elseif canImport(AppKit)
        guard
            let nsImage: NSImage = .init(
                size: CGSize(dimension: 100),
                color: NSColor.systemBlue
            ),
            let data: Data = nsImage.tiffRepresentation
        else {
            Logger.imageInitWithDataTests.critical("Failed to generate test data")
            fatalError()
        }

        let _: Image = .init(data: data) // Check that no crashes occur
#endif
    }
}
