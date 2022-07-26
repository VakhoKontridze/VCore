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
            json: [String: String?]
        ) -> [String: String] {
            var result: [String: String] = [:]
            
            for (key, value) in json {
                guard let value = value else { continue }
                
                result.updateValue(value, forKey: key)
            }
            
            return result
        }
        
        static func build(
            encodable: some Encodable
        ) throws -> [String: String] {
            let json: [String: Any?] = try JSONEncoderService.json(encodable: encodable)
            
            var result: [String: String] = [:]
            
            for (key, value) in json {
                guard let value = value else { continue }
                
                guard let description: String = .init(unwrappedDescribing: value) else { throw NetworkClientError.invalidHeaders }
                result.updateValue(description, forKey: key)
            }
            
            return result
        }
    }
}
