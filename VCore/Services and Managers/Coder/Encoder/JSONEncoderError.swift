//
//  JSONEncoderError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import Foundation

// MARK: - JSON Encoder Error
/// An error that occurs during the processes made by `JSONEncoderService`.
public enum JSONEncoderError: VCoreError {
    // MARK: Cases
    /// An indication that data cannot be encoded.
    ///
    /// Associated value contains info of `VCoreErrorInfo` type.
    case failedToEncode(_ info: VCoreErrorInfo)
    
    // MARK: Properties
    /// Error info.
    public var info: VCoreErrorInfo? {
        switch self {
        case .failedToEncode(let info): return info
        }
    }
    
    // Overriden
    /// Primary error description.
    public var localizedDescription: String? {
        switch self {
        case .failedToEncode: return "Cannot encode data"
        }
    }
}
