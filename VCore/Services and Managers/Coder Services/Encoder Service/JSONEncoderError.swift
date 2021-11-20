//
//  JSONEncoderError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import Foundation

// MARK: - JSON Encoder Error
/// An error that occurs during the processes made by `JSONEncoderService`.
public enum JSONEncoderError: VCoreError {
    // MARK: Cases
    /// Indicates that data cannot be encoded.
    case failedToEncode
    
    // MARK: Properties
    // Overriden
    public static var errorDomain: String { "com.vcore.jsonencoderservice" }
    
    // MARK: VCore Error
    public var domain: String { Self.errorDomain }
    
    public var code: Int {
        switch self {
        case .failedToEncode: return 1001
        }
    }
    
    public var description: String {
        switch self {
        case .failedToEncode: return "Data cannot be encoded or is incomplete"
        }
    }
}
