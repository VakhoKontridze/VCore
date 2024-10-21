//
//  KeychainServiceError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 23.07.22.
//

import Foundation

// MARK: - Keychain Service Error
/// An error that occurs during the operations in `KeychainService`.
public struct KeychainServiceError: VCoreError, Equatable, Sendable {
    // MARK: Properties
    private let code: Code
    
    // MARK: Initializers
    /// Initializes `KeychainServiceError` with the given error code.
    public init(_ code: Code) {
        self.code = code
    }
    
    // MARK: Code
    /// Error code.
    public enum Code: Int, Equatable, Sendable {
        /// Indicates that get operation has failed.
        case failedToGet
        
        /// Indicates that set operation has failed.
        case failedToSet
        
        /// Indicates that delete operation has failed.
        case failedToDelete
    }

    // MARK: VCore Error
    public var vCoreErrorCode: Int { code.rawValue }

    public var vCoreErrorDescription: String {
        switch code {
        case .failedToGet: "Data cannot be retrieved from 'Security' framework"
        case .failedToSet: "Data cannot be set to 'Security' framework"
        case .failedToDelete: "Data cannot be deleted from 'Security' framework"
        }
    }

    // MARK: Equatable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.code == rhs.code
    }
}
