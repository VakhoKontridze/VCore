//
//  JSONDecodingError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import Foundation

// MARK: - JSON Decoding Error
/// An error that occurs during the processes made by `JSONEncoderService`
public enum JSONDecodingError: VCoreError {
    // MARK: Cases
    /// An indication that data cannot be decoded
    ///
    /// Associated value contains info of `VCoreErrorInfo` type
    case failedToDecode(_ info: VCoreErrorInfo)
    
    // MARK: Properties
    /// Error info
    public var info: VCoreErrorInfo? {
        switch self {
        case .failedToDecode(let info): return info
        }
    }
    
    /// Error domain
    public var domain: String? {
        info?.domain
    }
    
    public var code: Int? {
        info?.code
    }
    
    /// Full error description
    public var fullDescription: String? {
        switch (primaryDescription, secondaryDescription) {
        case (nil, _):
            return nil
            
        case (let primaryDescription?, nil):
            return primaryDescription
            
        case (var primaryDescription?, let secondaryDescription?):
            if primaryDescription.last == "." { _ = primaryDescription.removeLast() }
            return "\(primaryDescription). \(secondaryDescription)."
        }
    }
    
    /// Primary error description
    public var primaryDescription: String? {
        switch self {
        case .failedToDecode: return "Cannot decode data"
        }
    }
    
    /// Secondary error description
    ///
    /// Composed from associated error description
    public var secondaryDescription: String? {
        switch self {
        case .failedToDecode(let info): return info.description
        }
    }
}
