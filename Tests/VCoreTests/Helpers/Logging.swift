//
//  Logging.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 12.02.24.
//

import Foundation
import OSLog

// MARK: - Loggers
extension Logger {
    static let imageInitWithDataTests: Self = .init(subsystem: "VCoreTests", category: "ImageInitWithDataTests")
    static let jsonDecoderMethodTests: Self = .init(subsystem: "VCoreTests", category: "JSONDecoderMethodTests")
    static let jsonEncoderMethodTests: Self = .init(subsystem: "VCoreTests", category: "JSONEncoderMethodTests")
    static let uiImageCompressedTests: Self = .init(subsystem: "VCoreTests", category: "UIImageCompressedTests")
    static let uiImageCroppedTests: Self = .init(subsystem: "VCoreTests", category: "UIImageCroppedTests")
    static let uiImageRotatedTests: Self = .init(subsystem: "VCoreTests", category: "UIImageRotatedTests")
    static let uiImageScaledTests: Self = .init(subsystem: "VCoreTests", category: "UIImageScaledTests")
    static let urlResponseIsSuccessHTTPStatusCodeTests: Self = .init(subsystem: "VCoreTests", category: "URLResponseIsSuccessHTTPStatusCodeTests")
}
