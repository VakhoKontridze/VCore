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
                guard let value else { continue }
                
                result.updateValue(value, forKey: key)
            }
            
            return result
        }
        
        static func build(
            encodable: some Encodable
        ) throws -> [String: String] {
            let json: [String: Any?]
            do {
                json = try JSONEncoderService().json(encodable: encodable)
                
            } catch /*let _error*/ { // Logged internally
                let error: NetworkClientError = .init(.invalidHeaders)
                VCoreLog(error)
                throw error
            }
            
            var result: [String: String] = [:]
            for (key, value) in json {
                guard let value else { continue }
                
                guard let description: String = .init(unwrappedDescribing: value) else {
                    let error: NetworkClientError = .init(.invalidHeaders)
                    VCoreLog(error, "\(value) cannot be encoded as a header parameter")
                    throw error
                }
                
                result.updateValue(description, forKey: key)
            }
            
            return result
        }
    }
}
