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
            json: [String: Any?]
        ) throws -> [String: String] {
            var result: [String: String] = [:]
            
            for (key, value) in json {
                guard let value = value else { continue }
                
                guard let description: String = .init(unwrappedDescribing: value) else { throw NetworkError.invalidQueryParameters }
                result.updateValue(description, forKey: key)
            }
            
            return result
        }
        
        static func build<T>(
            encodable: T
        ) throws -> [String: String]
            where T: Encodable
        {
            let json: [String: Any?] = try JSONEncoderService.json(encodable: encodable)
            
            var result: [String: String] = [:]
            
            for (key, value) in json {
                guard let value = value else { continue }
                
                guard let description: String = .init(unwrappedDescribing: value) else { throw NetworkError.invalidQueryParameters }
                result.updateValue(description, forKey: key)
            }
            
            return result
        }
    }
}
