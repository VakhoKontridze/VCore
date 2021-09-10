//
//  JSONDecodingError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import Foundation

// MARK:- JSON Decoding Error
/// An error that occurs during the processes made by `JSONEncoderService`
public enum JSONDecodingError: Error, LocalizedError {
    // MARK: Cases
    /// An indication that data cannot be decoded
    ///
    /// Associated values contain code and description of error
    case failedToDecode(code: Int?, description: String?)
    
    // MARK: Code
    public var code: Int? {
        switch self {
        case .failedToDecode(let code, _): return code
        }
    }
    
    // MARK: Description
    /// Error description
    public var errorDescription: String? {
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
    /// Returned from associated error description
    public var secondaryDescription: String? {
        switch self {
        case .failedToDecode(_, let description): return description
        }
    }
    
    // MARK: Initializers
    static func failedToDecode(from error: Error) -> Self {
        .failedToDecode(
            code: (error as NSError).code,
            description: error.localizedDescription
        )
    }
}
