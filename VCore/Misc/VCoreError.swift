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
    /// Error info.
    var info: VCoreErrorInfo? { get }
    
    /// Error domain.
    var domain: String? { get }
    
    /// Error code.
    var code: Int? { get }
    
    /// Error description.
    var description: String? { get }
}

extension VCoreError {
    public var domain: String? { info?.domain }
    public var code: Int? { info?.code }
    public var description: String? { info?.description }
    
    public var errorDescription: String? { description }
    public var failureReason: String? { description }
    public var recoverySuggestion: String? { nil }
    public var helpAnchor: String? { nil }
    public var localizedDescription: String { description ?? "Error Occured" }
    
    public static var errorDomain: String { "com.vcore" }
    public var errorCode: Int { code ?? -1 }
}

// MARK: - V Core Error Info
/// Object containing info about errors occured in `VCore`
public struct VCoreErrorInfo {
    // MARK: Properties
    /// Error domain.
    public var domain: String?
    
    /// Error code.
    public var code: Int?
    
    /// Error description.
    public var description: String?
    
    // MARK: Initializers
    init() {
        self.domain = nil
        self.code = nil
        self.description = nil
    }
    
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
    
    /// Initializes object.
    public init(
        nsError: NSError
    ) {
        self.domain = nsError.domain
        self.code = nsError.code
        self.description = nsError.description
    }
    
    init(
        jsonEncoderError: JSONEncoderError?
    ) {
        self.domain = jsonEncoderError?.domain
        self.code = jsonEncoderError?.code
        self.description = jsonEncoderError?.description
    }
    
    init(
        jsonDecoderError: JSONDecoderError?
    ) {
        self.domain = jsonDecoderError?.domain
        self.code = jsonDecoderError?.code
        self.description = jsonDecoderError?.description
    }
}
