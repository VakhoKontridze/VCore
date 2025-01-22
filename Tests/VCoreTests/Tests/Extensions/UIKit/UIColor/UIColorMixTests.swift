//
//  UIColorBlendTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 09.05.22.
//

#if canImport(UIKit)

import UIKit
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct UIColorMixTests {
    @Test
    func test() {
        let color1: UIColor = .init(red: 1/3, green: 1/3, blue: 1/3, alpha: 1)
        let color2: UIColor = .init(red: 2/3, green: 2/3, blue: 2/3, alpha: 1)
        
        #expect(
            color1.mix(with: color2, by: 0.2) ==
            UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        )
    }
}

#endif
