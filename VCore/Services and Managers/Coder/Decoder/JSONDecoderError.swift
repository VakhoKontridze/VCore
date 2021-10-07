//
//  JSONDecoderError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import Foundation

// MARK: - JSON Decoder Error
/// An error that occurs during the processes made by `JSONEncoderService`.
public enum JSONDecoderError: VCoreError {
    // MARK: Cases
    /// An indication that data cannot be decoded.
    ///
    /// Associated value contains info of `VCoreErrorInfo` type.
    case failedToDecode(_ info: VCoreErrorInfo)
    
    // MARK: Properties
    /// Error info.
    public var info: VCoreErrorInfo? {
        switch self {
        case .failedToDecode(let info): return info
        }
    }

    // Overriden
    /// Primary error description.
    public var localizedDescription: String? {
        switch self {
        case .failedToDecode: return "Cannot decode data"
        }
    }
}
