//
//  VCoreError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import Foundation

// MARK: - V Core Error
/// An error that occurs in `VCore`.
///
/// Dynamic member `domain` is linked with static member `errorDomain`.
/// Override `errorDomain` to change both.
public protocol VCoreError: LocalizedError, CustomNSError {
    /// Error domain.
    var domain: String { get }
    
    /// Error code.
    var code: Int { get }
    
    /// Error description.
    var description: String { get }
}

extension VCoreError {
    // VCore Error
    public var domain: String { Self.errorDomain }
    
    // Error (Localized)
    public var errorDescription: String? { description }
    public var failureReason: String? { description }
    public var recoverySuggestion: String? { nil }
    public var helpAnchor: String? { nil }
    public var localizedDescription: String { description }
    
    // NS Error
    public static var errorDomain: String { "com.vcore" }
    public var errorCode: Int { code }
}
