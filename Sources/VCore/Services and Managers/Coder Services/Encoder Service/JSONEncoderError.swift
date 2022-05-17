//
//  JSONEncoderError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import Foundation

// MARK: - JSON Encoder Error
/// An error that occurs during the processes made by `JSONEncoderService`.
public enum JSONEncoderError: Int, VCoreError, CaseIterable {
    // MARK: Cases
    /// Indicates that data cannot be encoded.
    case failedToEncode
    
    // MARK: Properties
    // Overriden
    public static var errorDomain: String { "com.vcore.jsonencoderservice" }
    
    // MARK: VCore Error
    public var domain: String { Self.errorDomain }
    
    public var code: Int { 1000 + (rawValue+1) }
    
    public var description: String {
        VCoreLocalizationService.shared.localizationProvider.value(jsonEncoderError: self)
    }
}
