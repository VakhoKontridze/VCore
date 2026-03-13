//
//  BaseErrorProtocol.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import Foundation

/// Base error protocol.
///
///     @MemberwiseInitializable(accessLevelModifier: .private)
///     struct ServiceError: BaseErrorProtocol, Equatable {
///         static let domain: String = "com.app.service-error"
///         let code: Int
///         let description: String
///
///         static let failedToGet: Self = .init(
///             code: 1,
///             description: "Data cannot be retrieved"
///         )
///
///         static func failedToSet(_ reason: String) -> Self {
///             .init(
///                 code: 2,
///                 description: "Data cannot be set, because '\(reason)'"
///             )
///         }
///
///         static func == (lhs: Self, rhs: Self) -> Bool {
///             lhs.code == rhs.code
///         }
///     }
///
public protocol BaseErrorProtocol: Error, LocalizedError, CustomNSError, Equatable {
    /// Error domain.
    static var domain: String { get }
    
    /// Error code.
    var code: Int { get }
    
    /// Error description.
    var description: String { get }
}

extension BaseErrorProtocol {
    // LocalizedError
    public var errorDescription: String? { description }
    public var failureReason: String? { nil }
    public var recoverySuggestion: String? { nil }
    public var helpAnchor: String? { nil }
    public var localizedDescription: String { description }
    
    // NSError & CustomNSError
    public static var errorDomain: String { domain }
    public var errorCode: Int { code }
    
    // Equatable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.code == rhs.code
    }
}
