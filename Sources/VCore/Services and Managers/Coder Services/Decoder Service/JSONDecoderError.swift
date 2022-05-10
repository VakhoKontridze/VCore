//
//  JSONDecoderError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import Foundation

// MARK: - JSON Decoder Error
/// An error that occurs during the processes made by `JSONEncoderService`.
public enum JSONDecoderError: Int, VCoreError, CaseIterable {
    // MARK: Cases
    /// Indicates that json cannot be decoded.
    case failedToDecode

    // MARK: Properties
    // Overriden
    public static var errorDomain: String { "com.vcore.jsondecoderservice" }
    
    // MARK: VCore Error
    public var domain: String { Self.errorDomain }
    
    public var code: Int { 1000 + (rawValue+1) }
    
    public var description: String {
        switch self {
        case .failedToDecode: return "Data cannot be decoded or is incomplete"
        }
    }
}
