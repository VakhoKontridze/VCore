//
//  UIViewWithTranslatesAutoresizingMaskIntoConstraintsTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.06.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit
import Testing
@testable import VCore

// MARK: - Tests
@Suite
@MainActor
struct UIViewWithTranslatesAutoresizingMaskIntoConstraintsTests {
    @Test
    func test() {
        do {
            let view: UILabel = .init().withTranslatesAutoresizingMaskIntoConstraints(false)
            #expect(!view.translatesAutoresizingMaskIntoConstraints)
        }
        
        do {
            let view: UILabel = .init().withTranslatesAutoresizingMaskIntoConstraints(true)
            #expect(view.translatesAutoresizingMaskIntoConstraints)
        }
    }
}

#endif
