//
//  NetworkRequestFactory.Headers.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/19/21.
//

import Foundation

// MARK: - Headers Factory
extension NetworkRequestFactory {
    struct Headers {
        // MARK: Initializers
        private init() {}
        
        // MARK: Building
        static func build(
            _ json: [String: String?]
        ) -> [String: String] {
            var result: [String: String] = [:]
            
            for (key, value) in json {
                guard let value = value else { continue }
                
                result.updateValue(value, forKey: key)
            }
            
            return result
        }
        
        static func build<EncodableHeader: Encodable>(
            _ encodable: EncodableHeader
        ) throws -> [String: String] {
            let json: [String: Any?] = try JSONEncoderService.json(from: encodable)
            
            var result: [String: String] = [:]
            
            for (key, value) in json {
                guard let value = value else { continue }
                
                guard let description: String = .init(safelyDescribing: value) else { throw NetworkError.invalidHeaders }
                result.updateValue(description, forKey: key)
            }
            
            return result
        }
    }
}
