//
//  NSFontStylingTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 04.07.22.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import AppKit
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct NSFontStylingTests {
    @Test
    func testItalic() throws {
        let font: NSFont = .systemFont(ofSize: 13)
        
        let italicFont: NSFont = try #require(
            font.withItalicStyling()
        )

        #expect(italicFont.fontDescriptor.symbolicTraits.contains(.italic))
    }
    
    @Test
    func testBold() throws {
        let font: NSFont = .systemFont(ofSize: 13)
        
        let boldFont: NSFont = try #require(
            font.withBoldStyling()
        )

        #expect(boldFont.fontDescriptor.symbolicTraits.contains(.bold))
    }
}

#endif
