//
//  UIViewRoundCornersTests.swift
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
struct UIViewRoundCornersTests {
    @Test
    func test() {
        let view: UIView = .init()
        
        view.roundCorners(
            .layerAllCorners,
            by: 10,
            curve: .circular
        )
        
        #expect(view.layer.maskedCorners == .layerAllCorners)
        #expect(view.layer.cornerRadius == 10)
        #expect(view.layer.cornerCurve == .circular)
    }
}

#endif
