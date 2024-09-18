//
//  UIViewControllerIsRootViewControllerTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation
import XCTest
@testable import VCore

// MARK: - Tests
@MainActor
final class UIViewControllerIsRootViewControllerTests: XCTestCase {
    func testIs() {
        let navigationController: UINavigationController = .init()
        let viewController1: UIViewController = .init()
        let viewController2: UIViewController = .init()
        
        XCTAssertNil(viewController1.isRootViewController)
        XCTAssertNil(viewController2.isRootViewController)
        
        navigationController.pushViewController(viewController1, animated: false)
        XCTAssertEqual(viewController1.isRootViewController, true)
        XCTAssertNil(viewController2.isRootViewController)
        
        navigationController.pushViewController(viewController2, animated: false)
        XCTAssertEqual(viewController1.isRootViewController, true)
        XCTAssertEqual(viewController2.isRootViewController, false)
    }
    
    func testIsNot() {
        let navigationController: UINavigationController = .init()
        let viewController1: UIViewController = .init()
        let viewController2: UIViewController = .init()
        
        XCTAssertNil(viewController1.isNonRootViewController)
        XCTAssertNil(viewController2.isNonRootViewController)
        
        navigationController.pushViewController(viewController1, animated: false)
        XCTAssertEqual(viewController1.isNonRootViewController, false)
        XCTAssertNil(viewController2.isNonRootViewController)
        
        navigationController.pushViewController(viewController2, animated: false)
        XCTAssertEqual(viewController1.isNonRootViewController, false)
        XCTAssertEqual(viewController2.isNonRootViewController, true)
    }
}

#endif
