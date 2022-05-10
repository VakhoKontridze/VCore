//
//  NetworkRequestFactory.PathParameters.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/19/21.
//

import Foundation

// MARK: - Path Parameters Factory
extension NetworkRequestFactory {
    struct PathParameters {
        // MARK: Initializers
        private init() {}
        
        // MARK: Building
        static func build(
            string: String
        ) -> [String] {
            [string]
        }
        
        static func build(
            stringArray: [String]
        ) -> [String] {
            stringArray
        }
    }
}
