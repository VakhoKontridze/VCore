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
                guard let value else { continue }
                
                guard let description: String = .init(unwrappedDescribing: value) else {
                    let error: NetworkClientError = .init(.invalidQueryParameters)
                    VCoreLog(error, "\(value) cannot be encoded as a query parameter")
                    throw error
                }
                
                result.updateValue(description, forKey: key)
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
                let error: NetworkClientError = .init(.invalidQueryParameters)
                VCoreLog(error)
                throw error
            }
            
            var result: [String: String] = [:]
            for (key, value) in json {
                guard let value else { continue }
                
                guard let description: String = .init(unwrappedDescribing: value) else {
                    let error: NetworkClientError = .init(.invalidQueryParameters)
                    VCoreLog(error, "\(value) cannot be encoded as a query parameter")
                    throw error
                }
                
                result.updateValue(description, forKey: key)
            }
            
            return result
        }
    }
}
