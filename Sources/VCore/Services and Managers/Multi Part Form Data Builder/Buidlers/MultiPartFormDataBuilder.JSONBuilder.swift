//
//  MultiPartFormDataBuilder.JSONBuilder.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/20/21.
//

import Foundation

// MARK: - JSON Builder
extension MultiPartFormDataBuilder {
    struct JSONBuilder {
        // MARK: Properties
        private let boundary: String
        private let json: [String: Any?]
        
        private var lineBreak: String { MultiPartFormDataBuilder.lineBreak }
        
        // MARK: Initializers
        init(
            boundary: String,
            json: [String: Any?]
        ) {
            self.boundary = boundary
            self.json = json
        }
        
        // MARK: Build
        func build() -> Data {
            var data: Data = .init()
            
            for (key, value) in json {
                switch value {
                case let array as [Any?]: appendArray(key: key, array: array, to: &data)
                case let json as [String: Any?]: appendJSON(key: key, json: json, to: &data)
                default: appendElement(key: key, element: value, to: &data)
                }
            }
            
            return data
        }
        
        private func appendElement(
            key: String,
            element: Any?,
            to data: inout Data
        ) {
            guard let value: String = .init(unwrappedDescribing: element) else { return }
            
            data.append("--\(boundary)\(lineBreak)")
            data.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak)\(lineBreak)")
            data.append("\(value)\(lineBreak)")
        }
        
        private func appendJSON(
            key: String,
            json: [String: Any?],
            to data: inout Data
        ) {
            for element in json {
                let elementKey: String = "\(key)[\(element.key)]"
                
                switch element.value {
                case let array as [Any?]: appendArray(key: elementKey, array: array, to: &data)
                case let json as [String: Any?]: appendJSON(key: elementKey, json: json, to: &data)
                default: appendElement(key: elementKey, element: element.value, to: &data)
                }
            }
        }
        
        private func appendArray(
            key: String,
            array: [Any?],
            to data: inout Data
        ) {
            for (i, element) in array.enumerated() {
                let elementKey: String = "\(key)[\(i)]"
                
                switch element {
                case let array as [[String: Any?]]: appendArray(key: elementKey, array: array, to: &data)
                case let json as [String: Any?]: appendJSON(key: elementKey, json: json, to: &data)
                default: appendElement(key: elementKey, element: element, to: &data)
                }
            }
        }
    }
}
