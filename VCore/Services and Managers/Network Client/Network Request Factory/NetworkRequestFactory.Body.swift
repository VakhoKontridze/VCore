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
            _ data: Data
        ) -> Data {
            data
        }
        
        static func build(
            _ json: [String: Any?]
        ) throws -> Data {
            do {
                return try JSONEncoderService.data(from: json)
            } catch {
                throw NetworkError.invalidBody
            }
        }
        
        static func build<EncodableBody: Encodable>(
            _ encodable: EncodableBody
        ) throws -> Data {
            do {
                return try JSONEncoderService.data(from: encodable)
            } catch {
                throw NetworkError.invalidBody
            }
        }
    }
}