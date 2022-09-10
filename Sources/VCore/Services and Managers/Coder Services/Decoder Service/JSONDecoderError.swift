//
//  JSONDecoderError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import Foundation

// MARK: - JSON Decoder Error
/// An error that occurs during the processes made by `JSONEncoderService`.
public struct JSONDecoderError: VCoreError, Equatable {
    // MARK: Properties
    private let errorCode: ErrorCode
    
    // MARK: VCore Error
    public var code: Int { errorCode.rawValue }
    public var description: String { VCoreLocalizationService.shared.localizationProvider.jsonDecoderErrorDescription(errorCode) }
    
    // MARK: Initializers
    init(_ errorCode: ErrorCode) {
        self.errorCode = errorCode
    }
    
    /// Indicates that JSON cannot be decoded.
    public static var failedToDecode: Self { .init(.failedToDecode) }
    
    /// Indicates that data cannot be encoded.
    public static var failedToEncode: Self { .init(.failedToEncode) }
    
    /// Indicates that type cannot be casted to another type.
    public static var failedToCast: Self { .init(.failedToCast) }
    
    // MARK: Error Code
    /// Error code.
    public enum ErrorCode: Int, Equatable {
        /// Indicates that JSON cannot be decoded.
        case failedToDecode
        
        /// Indicates that data cannot be encoded.
        case failedToEncode
        
        /// Indicates that type cannot be casted to another type.
        case failedToCast
    }
    
    // MARK: Equatable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.errorCode == rhs.errorCode
    }
}
