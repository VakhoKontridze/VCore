//
//  MultiPartFormDataError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/20/21.
//

import Foundation

// MARK: - Multi Part Form Data Error
/// An error that occurs during the processes made by `JSONEncoderService`.
public enum MultiPartFormDataError: Int, VCoreError, CaseIterable {
    // MARK: Cases
    /// Indicates that json is invalid.
    case invalidJSON
    
    /// Indicates that files are invalid.
    case invalidFiles
    
    // MARK: Properties
    // Overriden
    public static var errorDomain: String { "com.vcore.multipartformdatabuilder" }
    
    // MARK: VCore Error
    public var domain: String { Self.errorDomain }
    
    public var code: Int {
        switch self {
        case .invalidJSON: return 1001
        case .invalidFiles: return 1001
        }
    }
    
    public var description: String {
        switch self {
        case .invalidJSON: return "Data cannot be encoded or is incomplete"
        case .invalidFiles: return "Data cannot be encoded or is incomplete"
        }
    }
}
