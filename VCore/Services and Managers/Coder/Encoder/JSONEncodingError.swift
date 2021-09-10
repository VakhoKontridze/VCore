//
//  JSONEncodingError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import Foundation

// MARK:- JSON Encoding Error
/// An error that occurs during the processes made by `JSONEncoderService`
public enum JSONEncodingError: VCoreError {
    // MARK: Cases
    /// An indication that data cannot be encoded
    ///
    /// Associated value contains info of `VCoreErrorInfo` type
    case failedToEncode(_ info: VCoreErrorInfo)
    
    // MARK: Properties
    /// Error info
    public var info: VCoreErrorInfo? {
        switch self {
        case .failedToEncode(let info): return info
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
        case .failedToEncode: return "Cannot encode data"
        }
    }
    
    /// Secondary error description
    ///
    /// Returned from associated error description
    public var secondaryDescription: String? {
        switch self {
        case .failedToEncode(let info): return info.description
        }
    }
}
