//
//  JSONEncoderError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import Foundation

// MARK: - JSON Encoder Error
/// An error that occurs during the processes made by `JSONEncoderService`.
public struct JSONEncoderError: VCoreError, Equatable {
    // MARK: Properties
    private let _code: Code
    
    // MARK: VCore Error
    public var code: Int { _code.rawValue }
    public var description: String { VCoreLocalizationService.shared.localizationProvider.jsonEncoderErrorDescription(_code) }
    
    // MARK: Initializers
    init(_ code: Code) {
        self._code = code
    }
    
    /// Indicates that data cannot be encoded.
    public static var failedToEncode: Self { .init(.failedToEncode) }
    
    /// Indicates that JSON cannot be decoded.
    public static var failedToDecode: Self { .init(.failedToDecode) }
    
    /// Indicates that type cannot be casted to another type.
    public static var failedToCast: Self { .init(.failedToCast) }
    
    // MARK: Code
    /// Error code.
    public enum Code: Int, Equatable {
        /// Indicates that data cannot be encoded.
        case failedToEncode
        
        /// Indicates that JSON cannot be decoded.
        case failedToDecode
        
        /// Indicates that type cannot be casted to another type.
        case failedToCast
    }
    
    // MARK: Equatable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.code == rhs.code
    }
}
