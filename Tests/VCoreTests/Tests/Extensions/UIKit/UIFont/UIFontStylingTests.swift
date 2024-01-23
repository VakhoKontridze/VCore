//
//  UIFontStylingTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit)

import XCTest
@testable import VCore

// MARK: - Tests
final class UIFontStylingTests: XCTestCase {
    func testBold() throws {
        let font: UIFont = .systemFont(ofSize: 17)

        let boldFont: UIFont = try XCTUnwrap(
            font.withBoldStyling
        )

        XCTAssertTrue(boldFont.fontDescriptor.symbolicTraits.contains(.traitBold))
    }

    func testItalic() throws {
        let font: UIFont = .systemFont(ofSize: 17)

        let italicFont: UIFont = try XCTUnwrap(
            font.withItalicStyling
        )

        XCTAssertTrue(italicFont.fontDescriptor.symbolicTraits.contains(.traitItalic))
    }
}

#endif
