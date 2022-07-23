//
//  KeychainServiceError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 23.07.22.
//

import Foundation

// MARK: - Keychain Service Error
/// Error thrown by `KeychainService`.
///
/// A simple container of `OSStatus`.
public struct KeychainServiceError: VCoreError {
    // MARK: Properties
    public static var errorDomain: String { "com.vcore.keychainservice" }
    public var code: Int
    public var description: String
    
    // MARK: Initializers
    /// Initializers `KeychainService` with code.
    public init(code: Int, description: String = "") {
        self.code = code
        self.description = description
    }
    
    /// Initializers `KeychainService` with code.
    public init(code: Int32, description: String = "") {
        self.code = .init(code)
        self.description = description
    }
}
