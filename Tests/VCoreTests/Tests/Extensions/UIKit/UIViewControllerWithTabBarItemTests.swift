//
//  UIViewControllerWithTabBarItemTests.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 10.05.22.
//

#if canImport(UIKit) && !os(watchOS)

import XCTest
@testable import VCore

// MARK: - Tests
final class UIViewControllerWithTabBarItemTests: XCTestCase {
    func test() {
        let tabBarItem: UITabBarItem = .init(
            title: "Lorem Ipsum",
            image: .init(size: CGSize(dimension: 24), color: .red),
            tag: 0
        )
        
        let viewController: UIViewController = .init().withTabBarItem(tabBarItem)
        
        XCTAssertEqual(viewController.tabBarItem, tabBarItem)
    }
}

#endif
