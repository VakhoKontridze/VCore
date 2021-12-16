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
                switch value {
                case nil: continue
                case let value?: result.updateValue(value, forKey: key)
                }
            }
            
            return result
        }
        
        static func build<EncodableHeader: Encodable>(
            _ encodable: EncodableHeader
        ) throws -> [String: String] {
            let json: [String: Any?] = try JSONEncoderService.json(from: encodable)
            
            var result: [String: String] = [:]
            
            for (key, value) in json {
                switch value {
                case nil: continue
                case let value as String: result.updateValue(value, forKey: key)
                default: throw NetworkError.invalidHeaders
                }
            }
            
            return result
        }
    }
}
