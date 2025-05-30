//
//  BaseErrorProtocol.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import Foundation

// MARK: - Base Error Protocol
/// Base error protocol.
///
///     @MemberwiseInitializable(accessLevelModifier: .private)
///     struct SomeError: BaseErrorProtocol, Equatable {
///         static let domain: String = "com.example-app.some-error"
///         let code: Int
///         let description: String
///
///         static let firstError: Self = .init(
///             code: 1,
///             description: "Lorem ipsum dolor sit amet"
///         )
///
///         static func secondError(_ info: String) -> Self {
///             .init(
///                 code: 2,
///                 description: "Lorem ipsum dolor sit amet '\(info)'"
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
