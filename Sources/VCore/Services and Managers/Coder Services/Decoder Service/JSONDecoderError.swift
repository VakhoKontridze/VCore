//
//  JSONDecoderError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import Foundation

// MARK: - JSON Decoder Error
/// An error that occurs during the processes made by `JSONEncoderService`.
public enum JSONDecoderError: Int, VCoreError, CaseIterable {
    // MARK: Cases
    /// Indicates that json cannot be decoded.
    case failedToDecode

    // MARK: VCore Error
    public static var errorDomain: String { "com.vcore.jsondecoderservice" }
    public var code: Int { 1000 + rawValue }
    public var description: String { VCoreLocalizationService.shared.localizationProvider.jsonDecoderErrorDescription(self) }
}
