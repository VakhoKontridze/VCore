//
//  UIViewRoundCornersTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit) && !os(watchOS)

import XCTest
@testable import VCore

// MARK: - Tests
final class UIViewRoundCornersTests: XCTestCase {
    func tests() {
        let corners: CACornerMask = .layerAllCorners
        let cornerRadius: CGFloat = 10
        let curve: CALayerCornerCurve = .circular
        
        let view: UIView = .init()
        
        view.roundCorners(
            corners,
            by: cornerRadius,
            curve: curve
        )
        
        XCTAssertEqual(view.layer.maskedCorners, corners)
        XCTAssertEqual(view.layer.cornerRadius, cornerRadius)
        XCTAssertEqual(view.layer.cornerCurve, curve)
    }
}

#endif
