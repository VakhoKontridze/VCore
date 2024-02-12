//
//  NSFontStylingTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.07.22.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import AppKit
import XCTest
@testable import VCore

// MARK: - Tests
final class NSFontStylingTests: XCTestCase {
    func testItalic() throws {
        let font: NSFont = .systemFont(ofSize: 13)

        let italicFont: NSFont = try XCTUnwrap(
            font.withItalicStyling()
        )

        XCTAssertTrue(italicFont.fontDescriptor.symbolicTraits.contains(.italic))
    }
    
    func testBold() throws {
        let font: NSFont = .systemFont(ofSize: 13)

        let boldFont: NSFont = try XCTUnwrap(
            font.withBoldStyling()
        )

        XCTAssertTrue(boldFont.fontDescriptor.symbolicTraits.contains(.bold))
    }
}

#endif
