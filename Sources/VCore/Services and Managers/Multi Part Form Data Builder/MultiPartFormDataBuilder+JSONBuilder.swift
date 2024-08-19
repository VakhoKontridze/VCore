//
//  MultipartFormDataBuilder+JSONBuilder.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/20/21.
//

import Foundation

// MARK: - Multipart Form Data Builder + JSON Builder
extension MultipartFormDataBuilder {
    struct JSONBuilder {
        // MARK: Properties
        private let boundary: String
        
        private var lineBreak: String { MultipartFormDataBuilder.lineBreak }
        
        // MARK: Initializers
        init(
            boundary: String
        ) {
            self.boundary = boundary
        }
        
        // MARK: Build
        func build(
            json: [String: Any?]
        ) throws -> Data {
            var data: Data = .init()
            
            for (key, value) in json {
                switch value {
                case let array as [Any?]:
                    try appendArray(key: key, array: array, to: &data)
                    
                case let json as [String: Any?]:
                    try appendJSON(key: key, json: json, to: &data)
                    
                default:
                    try appendElement(key: key, element: value, to: &data)
                }
            }
            
            return data
        }
        
        private func appendElement(
            key: String,
            element: Any?,
            to data: inout Data
        ) throws {
            guard let element else { return }

            let value: String = .init(describing: element)

            try data.appendString("--\(boundary)\(lineBreak)")
            try data.appendString("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak)\(lineBreak)")
            try data.appendString("\(value)\(lineBreak)")
        }
        
        private func appendJSON(
            key: String,
            json: [String: Any?],
            to data: inout Data
        ) throws {
            for element in json {
                let elementKey: String = "\(key)[\(element.key)]"
                
                switch element.value {
                case let array as [Any?]:
                    try appendArray(key: elementKey, array: array, to: &data)
                    
                case let json as [String: Any?]:
                    try appendJSON(key: elementKey, json: json, to: &data)
                    
                default:
                    try appendElement(key: elementKey, element: element.value, to: &data)
                }
            }
        }
        
        private func appendArray(
            key: String,
            array: [Any?],
            to data: inout Data
        ) throws {
            for (i, element) in array.enumerated() {
                let elementKey: String = "\(key)[\(i)]"
                
                switch element {
                case let array as [[String: Any?]]:
                    try appendArray(key: elementKey, array: array, to: &data)
                    
                case let json as [String: Any?]:
                    try appendJSON(key: elementKey, json: json, to: &data)
                    
                default:
                    try appendElement(key: elementKey, element: element, to: &data)
                }
            }
        }
    }
}
