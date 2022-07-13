//
//  UIViewControllerIsRootViewControllerTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 13.07.22.
//

#if canImport(UIKit)

import XCTest
@testable import VCore

// MARK: - Tests
final class UIViewControllerIsRootViewControllerTests: XCTestCase {
    func testIs() {
        let navigationController: UINavigationController = .init()
        let vc1: UIViewController = .init()
        let vc2: UIViewController = .init()
        
        XCTAssertNil(vc1.isRootViewController)
        XCTAssertNil(vc2.isRootViewController)
        
        navigationController.pushViewController(vc1, animated: false)
        XCTAssertEqual(vc1.isRootViewController, true)
        XCTAssertNil(vc2.isRootViewController)
        
        navigationController.pushViewController(vc2, animated: false)
        XCTAssertEqual(vc1.isRootViewController, true)
        XCTAssertEqual(vc2.isRootViewController, false)
    }
    
    func testIsNot() {
        let navigationController: UINavigationController = .init()
        let vc1: UIViewController = .init()
        let vc2: UIViewController = .init()
        
        XCTAssertNil(vc1.isNonRootViewController)
        XCTAssertNil(vc2.isNonRootViewController)
        
        navigationController.pushViewController(vc1, animated: false)
        XCTAssertEqual(vc1.isNonRootViewController, false)
        XCTAssertNil(vc2.isNonRootViewController)
        
        navigationController.pushViewController(vc2, animated: false)
        XCTAssertEqual(vc1.isNonRootViewController, false)
        XCTAssertEqual(vc2.isNonRootViewController, true)
    }
}

#endif
