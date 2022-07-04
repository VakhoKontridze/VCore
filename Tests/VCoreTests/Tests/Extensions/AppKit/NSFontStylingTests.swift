//
//  NSFontStylingTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 04.07.22.
//

#if canImport(AppKit)

import XCTest
import AppKit
@testable import VCore

// MARK: - Tests
final class NSFontStylingTests: XCTestCase {
    func testBold() {
        let font: NSFont = .systemFont(ofSize: 13)
        let boldFont: NSFont = font.withBoldStyling!
        
        XCTAssertTrue(boldFont.fontDescriptor.symbolicTraits.contains(.bold))
    }
    
    func testItalic() {
        let font: NSFont = .systemFont(ofSize: 13)
        let italicFont: NSFont = font.withItalicStyling!
        
        XCTAssertTrue(italicFont.fontDescriptor.symbolicTraits.contains(.italic))
    }
}

#endif

