//
//  KeychainServiceError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 23.07.22.
//

import Foundation

// MARK: - Keychain Service Error
/// An error that occurs during encoding and decoding in `KeychainService`.
public struct KeychainServiceError: VCoreError, Equatable {
    // MARK: Properties
    private let errorCode: ErrorCode
    
    // MARK: VCore Error
    public var code: Int { errorCode.rawValue }
    public var description: String { VCoreLocalizationService.shared.localizationProvider.keychainServiceErrorDescription(errorCode) }
    
    // MARK: Initializers
    init(_ errorCode: ErrorCode) {
        self.errorCode = errorCode
    }
    
    /// Indicates that get operation has failed.
    public static var failedToGet: Self { .init(.failedToGet) }
    
    /// Indicates that set operation has failed.
    public static var failedToSet: Self { .init(.failedToSet) }
    
    /// Indicates that delete operation has failed.
    public static var failedToDelete: Self { .init(.failedToDelete) }
    
    // MARK: Error Code
    /// Error code.
    public enum ErrorCode: Int, Equatable {
        /// Indicates that get operation has failed.
        case failedToGet
        
        /// Indicates that set operation has failed.
        case failedToSet
        
        /// Indicates that delete operation has failed.
        case failedToDelete
        
        /// Indicates that type cannot be casted to another type.
        case failedToCast
    }
    
    // MARK: Equatable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.errorCode == rhs.errorCode
    }
}
