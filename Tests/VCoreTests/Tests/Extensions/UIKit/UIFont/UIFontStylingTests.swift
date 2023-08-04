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
    func testBold() {
        let font: UIFont = .systemFont(ofSize: 13)
        let boldFont: UIFont = font.withBoldStyling!
        
        XCTAssertTrue(boldFont.fontDescriptor.symbolicTraits.contains(.traitBold))
    }
    
    func testItalic() {
        let font: UIFont = .systemFont(ofSize: 13)
        let italicFont: UIFont = font.withItalicStyling!
        
        XCTAssertTrue(italicFont.fontDescriptor.symbolicTraits.contains(.traitItalic))
    }
}

#endif
