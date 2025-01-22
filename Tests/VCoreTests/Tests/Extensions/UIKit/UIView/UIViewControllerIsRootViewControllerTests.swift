//
//  UIViewControllerIsRootViewControllerTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit
import Testing
@testable import VCore

// MARK: - Tests
@MainActor
@Suite
struct UIViewControllerIsRootViewControllerTests {
    @Test
    func testIs() {
        let navigationController: UINavigationController = .init()
        let viewController1: UIViewController = .init()
        let viewController2: UIViewController = .init()
        
        #expect(viewController1.isRootViewController == nil)
        #expect(viewController2.isRootViewController == nil)
        
        navigationController.pushViewController(viewController1, animated: false)
        #expect(viewController1.isRootViewController == true)
        #expect(viewController2.isRootViewController == nil)
        
        navigationController.pushViewController(viewController2, animated: false)
        #expect(viewController1.isRootViewController == true)
        #expect(viewController2.isRootViewController == false)
    }
    
    @Test
    func testIsNot() {
        let navigationController: UINavigationController = .init()
        let viewController1: UIViewController = .init()
        let viewController2: UIViewController = .init()
        
        #expect(viewController1.isNonRootViewController == nil)
        #expect(viewController2.isNonRootViewController == nil)
        
        navigationController.pushViewController(viewController1, animated: false)
        #expect(viewController1.isNonRootViewController == false)
        #expect(viewController2.isNonRootViewController == nil)
        
        navigationController.pushViewController(viewController2, animated: false)
        #expect(viewController1.isNonRootViewController == false)
        #expect(viewController2.isNonRootViewController == true)
    }
}

#endif
