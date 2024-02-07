//
//  VCoreError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import Foundation

// MARK: - V Core Error
/// An error that occurs in `VCore`.
public protocol VCoreError: LocalizedError, CustomNSError {
    /// Error domain.
    static var vCoreErrorDomain: String { get }
    
    /// Error code.
    var vCoreErrorCode: Int { get }
    
    /// Error description.
    var vCoreErrorDescription: String { get }
}

extension VCoreError {
    // VCoreError
    public static var vCoreErrorDomain: String { "com.vcore.\(String(describing: Self.self).lowercased())" }

    // LocalizedError
    public var errorDescription: String? { vCoreErrorDescription }
    public var failureReason: String? { nil }
    public var recoverySuggestion: String? { nil }
    public var helpAnchor: String? { nil }
    public var localizedDescription: String { vCoreErrorDescription }
    
    // NSError
    public static var errorDomain: String { vCoreErrorDomain }
    public var errorCode: Int { vCoreErrorCode }
}
