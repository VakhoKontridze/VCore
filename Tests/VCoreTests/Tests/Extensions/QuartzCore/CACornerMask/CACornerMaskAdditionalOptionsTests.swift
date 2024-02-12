//
//  CACornerMaskAdditionalOptionsTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 13.06.22.
//

#if canImport(QuartzCore)

import QuartzCore
import XCTest
@testable import VCore

// MARK: - Tests
final class CACornerMaskAdditionalOptionsTests: XCTestCase {
    func test() {
        XCTAssertEqual(CACornerMask.layerMinXCorners.union(.layerMaxXCorners), .layerAllCorners)
        XCTAssertEqual(CACornerMask.layerMinYCorners.union(.layerMaxYCorners), .layerAllCorners)
    }
}

#endif
