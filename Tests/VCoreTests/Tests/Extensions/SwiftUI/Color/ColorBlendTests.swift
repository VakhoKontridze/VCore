//
//  ColorBlendTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

import SwiftUI
import XCTest
@testable import VCore

// MARK: - Tests
final class ColorBlendTests: XCTestCase {
    func test() {
        let color1: Color = .init(red: 1/3, green: 1/3, blue: 1/3, opacity: 1)
        let color2: Color = .init(red: 2/3, green: 2/3, blue: 2/3, opacity: 1)

        let values = Color.blend(color1, with: color2).rgbaValues

        XCTAssertEqual(values.red, 0.5)
        XCTAssertEqual(values.green, 0.5)
        XCTAssertEqual(values.blue, 0.5)
        XCTAssertEqual(values.alpha, 1)
    }
}
