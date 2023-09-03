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
    private let _code: Code
    
    // MARK: VCore Error
    public var code: Int { _code.rawValue }
    public var description: String {
        switch _code {
        case .failedToGet: return "Data cannot be retrieved from Security framework"
        case .failedToSet: return "Data cannot be set from Security framework"
        case .failedToDelete: return "Data cannot be deleted from Security framework"
        }
    }
    
    // MARK: Initializers
    init(_ code: Code) {
        self._code = code
    }
    
    /// Indicates that get operation has failed.
    public static var failedToGet: Self { .init(.failedToGet) }
    
    /// Indicates that set operation has failed.
    public static var failedToSet: Self { .init(.failedToSet) }
    
    /// Indicates that delete operation has failed.
    public static var failedToDelete: Self { .init(.failedToDelete) }
    
    // MARK: Code
    /// Error code.
    public enum Code: Int, Equatable {
        /// Indicates that get operation has failed.
        case failedToGet
        
        /// Indicates that set operation has failed.
        case failedToSet
        
        /// Indicates that delete operation has failed.
        case failedToDelete
    }
    
    // MARK: Equatable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.code == rhs.code
    }
}
