//
//  MultiPartFormDataBuilder.FileBuilder.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/20/21.
//

import Foundation

// MARK: - Multi Part Form Data Builder File Builder
extension MultiPartFormDataBuilder {
    struct FileBuilder {
        // MARK: Properties
        private let boundary: String
        private let files: [String: AnyMultiPartFormFile?]
        
        private var lineBreak: String { MultiPartFormDataBuilder.lineBreak }
        
        // MARK: Initializers
        init(
            boundary: String,
            files: [String: AnyMultiPartFormFile?]
        ) {
            self.boundary = boundary
            self.files = files
        }
        
        // MARK: Building
        func build() -> Data {
            var data: Data = .init()
            
            for (key, value) in files {
                switch value {
                case let array as [AnyMultiPartFormFile?]: appendArray(key: key, array: array, to: &data)
                case let json as [String: AnyMultiPartFormFile?]: appendJSON(key: key, json: json, to: &data)
                default: appendElement(key: key, element: value, to: &data)
                }
            }
            
            return data
        }
        
        private func appendElement(
            key: String,
            element: AnyMultiPartFormFile?,
            to data: inout Data
        ) {
            guard let file: MultiPartFormDataFile = (element as? MultiPartFormDataFile) else { return }
            
            let _file: _MultiPartFormDataFile = .init(name: key, file: file)
            guard let _fileData: Data = _file.data else { return }
            
            data.append("--\(boundary)\(lineBreak)")

            data.append("Content-Disposition: form-data; name=\"\(_file.name)\"; filename=\"\(_file.filename)\"\(lineBreak)")
            data.append("Content-Type: \(_file.mimeType)\(lineBreak)\(lineBreak)")
            data.append(_fileData)

            data.append(lineBreak)
        }
        
        private func appendJSON(
            key: String,
            json: [String: AnyMultiPartFormFile?],
            to data: inout Data
        ) {
            for element in json {
                let elementConcatKey: String = "\(key)[\(element.key)]"
                
                switch element.value {
                case let array as [AnyMultiPartFormFile?]: appendArray(key: elementConcatKey, array: array, to: &data)
                case let json as [String: AnyMultiPartFormFile?]: appendJSON(key: elementConcatKey, json: json, to: &data)
                default: appendElement(key: elementConcatKey, element: element.value, to: &data)
                }
            }
        }
        
        private func appendArray(
            key: String,
            array: [AnyMultiPartFormFile?],
            to data: inout Data
        ) {
            for (i, element) in array.enumerated() {
                let elementConcatKey: String = "\(key)[\(i)]"
                
                switch element {
                case let array as [AnyMultiPartFormFile?]: appendArray(key: elementConcatKey, array: array, to: &data)
                case let json as [String: AnyMultiPartFormFile?]: appendJSON(key: elementConcatKey, json: json, to: &data)
                default: appendElement(key: elementConcatKey, element: element, to: &data)
                }
            }
        }
    }
}
