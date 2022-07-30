//
//  KeychainServiceError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 23.07.22.
//

import Foundation

// MARK: - Keychain Service Error
/// An error that occurs during encoding and decoding in `KeychainService`.
public enum KeychainServiceError: Int, VCoreError, CaseIterable {
    // MARK: Cases
    /// Indicates that get operation has failed.
    case failedToGet
    
    /// Indicates that set operation has failed.
    case failedToSet
    
    /// Indicates that delete operation has failed.
    case failedToDelete
    
    // MARK: VCore Error
    public static var errorDomain: String { "com.vcore.keychainservice" }
    public var code: Int { 1000 + rawValue }
    public var description: String { VCoreLocalizationService.shared.localizationProvider.keychainServiceErrorDescription(self) }
}
