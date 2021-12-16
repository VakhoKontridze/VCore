//
//  NetworkRequestFactory.QueryParameters.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/19/21.
//

import Foundation

// MARK: - Query Parameters Factory
extension NetworkRequestFactory {
    struct QueryParameters {
        // MARK: Initializers
        private init() {}
        
        // MARK: Building
        static func build(
            _ json: [String: Any?]
        ) throws -> [String: String] {
            var result: [String: String] = [:]
            
            for (key, value) in json {
                switch value {
                case nil: continue
                case let value as String: result.updateValue(value, forKey: key)
                default: throw NetworkError.invalidQueryparameters
                }
            }
            
            return result
        }
        
        static func build<EncodableQueryParameters: Encodable>(
            _ encodable: EncodableQueryParameters
        ) throws -> [String: String] {
            let json: [String: Any?] = try JSONEncoderService.json(from: encodable)
            
            var result: [String: String] = [:]
            
            for (key, value) in json {
                switch value {
                case nil: continue
                case let value as String: result.updateValue(value, forKey: key)
                default: throw NetworkError.invalidQueryparameters
                }
            }
            
            return result
        }
    }
}
