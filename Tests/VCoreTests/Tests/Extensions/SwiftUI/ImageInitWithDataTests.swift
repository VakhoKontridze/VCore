//
//  ImageInitWithDataTests.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.03.23.
//

import XCTest
@testable import VCore
import SwiftUI

// MARK: - Tests
final class ImageInitWithDataTests: XCTestCase {
    func test() {
#if canImport(UIKit) && !os(watchOS)
        let uiImage: UIImage = .init(
            size: CGSize(dimension: 100),
            color: .systemBlue
        )! // Force-unwrap
        
        let data: Data = uiImage.jpegData(compressionQuality: 1)! // Force-unwrap
        
        let _: Image = .init(data: data)
#endif
    }
}
