//
//  ImageInitWithDataTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.03.23.
//

import SwiftUI
import XCTest
@testable import VCore

// MARK: - Tests
final class ImageInitWithDataTests: XCTestCase {
    func test() {
#if canImport(UIKit) && !os(watchOS)
        guard
            let uiImage: UIImage = .init(
                size: CGSize(dimension: 100),
                color: UIColor.systemBlue
            ),
            let data: Data = uiImage.jpegData(compressionQuality: 1)
        else {
            VCoreLogError("Failed to generate test data")
            fatalError()
        }
        
        let _: Image = .init(data: data) // Check that no crashes occur
#endif
    }
}
