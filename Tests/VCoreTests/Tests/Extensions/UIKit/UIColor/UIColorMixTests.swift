//
//  UIColorBlendTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

#if canImport(UIKit)

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class UIColorMixTests: XCTestCase {
    func test() {
        let color1: UIColor = .init(red: 1/3, green: 1/3, blue: 1/3, alpha: 1)
        let color2: UIColor = .init(red: 2/3, green: 2/3, blue: 2/3, alpha: 1)

        let values = color1.mix(with: color2, by: 0.2).rgbaValues

        XCTAssertEqual(values.red, 0.6)
        XCTAssertEqual(values.green, 0.6)
        XCTAssertEqual(values.blue, 0.6)
        XCTAssertEqual(values.alpha, 1)
    }
}

#endif
