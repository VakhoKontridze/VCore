//
//  UIViewWithTranslatesAutoresizingMaskIntoConstraintsTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.06.22.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
final class UIViewWithTranslatesAutoresizingMaskIntoConstraintsTests: XCTestCase {
    func test() {
        let view1: UILabel = .init().withTranslatesAutoresizingMaskIntoConstraints(false)
        XCTAssertEqual(view1.translatesAutoresizingMaskIntoConstraints, false)
        
        let view2: UILabel = .init().withTranslatesAutoresizingMaskIntoConstraints(true)
        XCTAssertEqual(view2.translatesAutoresizingMaskIntoConstraints, true)
    }
}

#endif
