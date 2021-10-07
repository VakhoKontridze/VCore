//
//  VCoreError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import Foundation

// MARK: - V Core Error
/// An error that occurs in `VCore`.
public protocol VCoreError: LocalizedError {
    /// Error info.
    var info: VCoreErrorInfo? { get }
    
    /// Error domain.
    var domain: String? { get }
    
    /// Error code.
    var code: Int? { get }
    
    /// Error description.
    var description: String? { get }
    
    /// Localized description of error.
    var localizedDescription: String { get }
    
    /// Localized message describing what error occurred.
    var errorDescription: String? { get }

    /// Localized message describing the reason for the failure.
    var failureReason: String? { get }

    /// Localized message describing how one might recover from the failure.
    var recoverySuggestion: String? { get }

    /// Localized message providing "help" text if the user requests help.
    var helpAnchor: String? { get }
}

extension VCoreError {
    public var domain: String? { info?.domain }
    
    public var code: Int? { info?.code }
    
    public var description: String? { info?.description }
    
    public var localizedDescription: String? { description }
    
    public var errorDescription: String? { description }

    public var failureReason: String? { description }
    
    public var recoverySuggestion: String? { nil }
    
    public var helpAnchor: String? { nil }
}

// MARK: - V Core Error Info
/// Object containing info about errors occured in `VCore`
public struct VCoreErrorInfo {
    /// Error domain.
    public var domain: String?
    
    /// Error code.
    public var code: Int?
    
    /// Error description.
    public var description: String?
    
    /// Initializes object.
    public init(
        domain: String? = nil,
        code: Int? = nil,
        description: String? = nil
    ) {
        self.domain = domain
        self.code = code
        self.description = description
    }
}
