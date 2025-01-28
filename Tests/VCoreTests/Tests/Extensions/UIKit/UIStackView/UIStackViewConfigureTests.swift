//
//  UIStackViewConfigureTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit
import Testing
@testable import VCore

// MARK: - Tests
@MainActor
@Suite
struct UIStackViewConfigureTests {
    @Test
    func testConfigure() {
        let stackView: UIStackView = .init()
        
        stackView.configure(
            axis: .vertical,
            distribution: .equalSpacing,
            alignment: .leading,
            spacing: 10
        )
        
        #expect(stackView.axis == .vertical)
        #expect(stackView.distribution == .equalSpacing)
        #expect(stackView.alignment == .leading)
        #expect(stackView.spacing == 10)
    }
    
    @Test
    func testInit() {
        let stackView: UIStackView = .init(
            axis: .vertical,
            distribution: .equalSpacing,
            alignment: .leading,
            spacing: 10
        )
        
        #expect(stackView.axis == .vertical)
        #expect(stackView.distribution == .equalSpacing)
        #expect(stackView.alignment == .leading)
        #expect(stackView.spacing == 10)
    }
}

#endif
