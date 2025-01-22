//
//  CACornerMaskAdditionalOptionsTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 13.06.22.
//

#if canImport(QuartzCore)

import QuartzCore
import Testing
@testable import VCore

// MARK: - Tests
@Suite
struct CACornerMaskAdditionalOptionsTests {
    @Test
    func test() {
        #expect(CACornerMask.layerMinXCorners.union(.layerMaxXCorners) == .layerAllCorners)
        #expect(CACornerMask.layerMinYCorners.union(.layerMaxYCorners) == .layerAllCorners)
    }
}

#endif
