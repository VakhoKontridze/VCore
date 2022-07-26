//
//  NetworkRequestFactory.Body.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/19/21.
//

import Foundation

// MARK: - Body Factory
extension NetworkRequestFactory {
    struct Body {
        // MARK: Initializers
        private init() {}
        
        // MARK: Building
        static func build(
            data: Data
        ) -> Data {
            data
        }
        
        static func build(
            json: [String: Any?]
        ) throws -> Data {
            do {
                return try JSONEncoderService.data(any: json)
            } catch {
                throw NetworkClientError.invalidBody
            }
        }

        static func build(
            encodable: some Encodable
        ) throws -> Data {
            do {
                return try JSONEncoderService.data(encodable: encodable)
            } catch {
                throw NetworkClientError.invalidBody
            }
        }
    }
}
