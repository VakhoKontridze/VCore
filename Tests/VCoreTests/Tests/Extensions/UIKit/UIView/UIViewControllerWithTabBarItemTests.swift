//
//  UIViewControllerWithTabBarItemTests.swift
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
struct UIViewControllerWithTabBarItemTests {
    @Test
    func test() {
        let tabBarItem: UITabBarItem = .init(
            title: "Lorem Ipsum",
            image: UIImage(
                size: CGSize(dimension: 24),
                color: UIColor.systemBlue
            ),
            tag: 0
        )
        
        let viewController: UIViewController = .init().withTabBarItem(tabBarItem)
        
        #expect(viewController.tabBarItem == tabBarItem)
    }
}

#endif
