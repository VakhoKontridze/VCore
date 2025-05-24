//
//  UIViewApplyShadowTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit
import Testing
@testable import VCore

// MARK: - Tests
@Suite
@MainActor
struct UIViewApplyShadowTests {
    @Test
    func testShadow() {
        let view: UIView = .init()
        
        view.applyShadow(
            color: UIColor.black,
            radius: 5,
            offset: CGSize(width: 0, height: 5)
        )
        
        #expect(view.layer.shadowColor == UIColor.black.cgColor)
        #expect(view.layer.shadowOpacity == 1)
        #expect(view.layer.shadowRadius == 5)
        #expect(view.layer.shadowOffset == CGSize(width: 0, height: 5))
    }
    
    @Test
    func testRoundCornersAndApplyShadow() {
        let view: UIView = .init()
        
        view.roundCornersAndApplyShadow(
            cornerRadius: 10,
            color: UIColor.black,
            radius: 5,
            offset: CGSize(width: 0, height: 5)
        )
        
        #expect(view.layer.cornerRadius == 10)
        #expect(view.layer.shadowColor == UIColor.black.cgColor)
        #expect(view.layer.shadowOpacity == 1)
        #expect(view.layer.shadowRadius == 5)
        #expect(view.layer.shadowOffset == CGSize(width: 0, height: 5))
    }
}

#endif
