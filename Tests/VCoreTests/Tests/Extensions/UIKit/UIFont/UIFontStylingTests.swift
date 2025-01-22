//
//  UIFontStylingTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit)

import UIKit
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct NSFontStylingTests {
    @Test
    func testItalic() throws {
        let font: UIFont = .systemFont(ofSize: 17)
        
        let italicFont: UIFont = try #require(
            font.withItalicStyling()
        )

        #expect(italicFont.fontDescriptor.symbolicTraits.contains(.traitItalic))
    }
    
    @Test
    func testBold() throws {
        let font: UIFont = .systemFont(ofSize: 17)
        
        let boldFont: UIFont = try #require(
            font.withBoldStyling()
        )

        #expect(boldFont.fontDescriptor.symbolicTraits.contains(.traitBold))
    }
}

#endif
