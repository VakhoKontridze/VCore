//
//  UILabelConfigurationTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit) && !os(watchOS)

import XCTest
@testable import VCore

// MARK: - Tests
final class UILabelConfigurationTests: XCTestCase {
    // MARK: Test Data
    private let alignment: NSTextAlignment = .natural
    private let lineBreakMode: NSLineBreakMode = .byTruncatingTail
    private let numberOfLines: Int = 3
    private let minimumScaleFactor: CGFloat = 0.5
    private let color: UIColor = .label
    private let font: UIFont = .systemFont(ofSize: 13)
    
    // MARK: Tests
    func testConfiguration() {
        let label: UILabel = .init()
        
        label.configure(
            alignment: alignment,
            lineBreakMode: lineBreakMode,
            numberOfLines: numberOfLines,
            minimumScaleFactor: minimumScaleFactor,
            color: color,
            font: font
        )
        
        XCTAssertEqual(label.textAlignment, alignment)
        XCTAssertEqual(label.lineBreakMode, lineBreakMode)
        XCTAssertEqual(label.numberOfLines, numberOfLines)
        XCTAssertEqual(label.minimumScaleFactor, minimumScaleFactor)
        XCTAssertEqual(label.textColor, color)
        XCTAssertEqual(label.font, font)
    }
    
    func testInit() {
        let label: UILabel = .init(
            alignment: alignment,
            lineBreakMode: lineBreakMode,
            numberOfLines: numberOfLines,
            minimumScaleFactor: minimumScaleFactor,
            color: color,
            font: font
        )
        
        XCTAssertEqual(label.textAlignment, alignment)
        XCTAssertEqual(label.lineBreakMode, lineBreakMode)
        XCTAssertEqual(label.numberOfLines, numberOfLines)
        XCTAssertEqual(label.minimumScaleFactor, minimumScaleFactor)
        XCTAssertEqual(label.textColor, color)
        XCTAssertEqual(label.font, font)
    }
}

#endif
