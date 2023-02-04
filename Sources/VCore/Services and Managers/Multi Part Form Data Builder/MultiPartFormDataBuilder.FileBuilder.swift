//
//  MultipartFormDataBuilder.FileBuilder.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/20/21.
//

import Foundation

// MARK: - File Builder
extension MultipartFormDataBuilder {
    struct FileBuilder {
        // MARK: Properties
        private let boundary: String
        
        private var lineBreak: String { MultipartFormDataBuilder.lineBreak }
        
        // MARK: Initializers
        init(
            boundary: String
        ) {
            self.boundary = boundary
        }
        
        // MARK: Building
        func build(
            files: [String: (some AnyMultipartFormDataFile)?]
        ) throws -> Data {
            var data: Data = .init()
            
            for (key, value) in files {
                switch value {
                case let array as [(any AnyMultipartFormDataFile)?]:
                    try appendArray(key: key, array: array, to: &data)
                
                case let json as [String: (any AnyMultipartFormDataFile)?]:
                    try appendJSON(key: key, json: json, to: &data)
                
                default:
                    try appendElement(key: key, element: value, to: &data)
                }
            }
            
            return data
        }
        
        private func appendElement(
            key: String,
            element: (some AnyMultipartFormDataFile)?,
            to data: inout Data
        ) throws {
            guard
                let element,
                let file: MultipartFormDataFile = element as? MultipartFormDataFile
            else {
                return
            }
            
            let _file: _MultipartFormDataFile = .init(name: key, file: file)
            guard let _fileData: Data = _file.data else { return }
            
            try data.appendString("--\(boundary)\(lineBreak)")

            try data.appendString("Content-Disposition: form-data; name=\"\(_file.name)\"; filename=\"\(_file.filename)\"\(lineBreak)")
            try data.appendString("Content-Type: \(_file.mimeType)\(lineBreak)\(lineBreak)")
            data.append(_fileData)

            try data.appendString(lineBreak)
        }
        
        private func appendJSON(
            key: String,
            json: [String: (some AnyMultipartFormDataFile)?],
            to data: inout Data
        ) throws {
            for element in json {
                let elementKey: String = "\(key)[\(element.key)]"
                
                switch element.value {
                case let array as [(any AnyMultipartFormDataFile)?]:
                    try appendArray(key: elementKey, array: array, to: &data)
                
                case let json as [String: (any AnyMultipartFormDataFile)?]:
                    try appendJSON(key: elementKey, json: json, to: &data)
                
                default:
                    try appendElement(key: elementKey, element: element.value, to: &data)
                }
            }
        }
        
        private func appendArray(
            key: String,
            array: [(some AnyMultipartFormDataFile)?],
            to data: inout Data
        ) throws {
            for (i, element) in array.enumerated() {
                let elementKey: String = "\(key)[\(i)]"
                
                switch element {
                case let array as [(any AnyMultipartFormDataFile)?]:
                    try appendArray(key: elementKey, array: array, to: &data)
                
                case let json as [String: (any AnyMultipartFormDataFile)?]:
                    try appendJSON(key: elementKey, json: json, to: &data)
                
                default:
                    try appendElement(key: elementKey, element: element, to: &data)
                }
            }
        }
    }
}
