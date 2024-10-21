//
//  MultipartFormDataBuilder.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/20/21.
//

import Foundation

// MARK: - Multipart Form Data Builder
/// Builder that generates boundary `String` and generated `Data` for network requests.
///
///     let json: [String: Any?] = [
///         "key": "value"
///     ]
///
///     let files: [String: (some AnyMultipartFormDataFile)?] = [
///         "profile": MultipartFormDataFile(
///             mimeType: "image/jpeg",
///             data: profileImage?.jpegData(compressionQuality: 0.25)
///         ),
///
///         "gallery": galleryImages?.enumerated().compactMap { (index, image) in
///             MultipartFormDataFile(
///                 filename: "IMG_\(index).jpg",
///                 mimeType: "image/jpeg",
///                 data: image?.jpegData(compressionQuality: 0.25)
///             )
///         }
///     ]
///
///     let (boundary, httpData): (String, Data) = try MultipartFormDataBuilder().build(
///         json: json,
///         files: files
///     )
///
///     let url: URL = #url("https://somewebsite.com/api/some_endpoint")
///
///     var request: URLRequest = .init(url: url)
///     request.httpMethod = "POST"
///     try request.addHTTPHeaderFields(
///         object: MultipartFormDataAuthorizedRequestHeaderFields(
///             boundary: boundary,
///             token: "token"
///         )
///     )
///     request.httpBody = httpData.nonEmpty
///
///     let (data, response): (Data, URLResponse) = try await URLSession.shared.data(for: request)
///
///     ...
///
public struct MultipartFormDataBuilder: Sendable {
    // MARK: Properties
    /// Boundary.
    ///
    /// By default, an `UUID` will be used.
    public var boundary: String
    
    static var lineBreak: String { "\r\n" }
    
    // MARK: Initializers
    /// Initializes `MultipartFormDataBuilder` with boundary.
    ///
    /// By default, an `UUID` will be used as a boundary.
    public init(
        boundary: String = UUID().uuidString
    ) {
        self.boundary = boundary
    }
    
    // MARK: Building
    /// Builds and returns boundary `String` and `Data` that can be sent over network.
    public func build(
        json: [String: Any?],
        files: [String: (some AnyMultipartFormDataFile)?]
    ) throws -> (boundary: String, data: Data) {
        var data: Data = .init()
        data.append(try JSONBuilder(boundary: boundary).build(json: json))
        data.append(try FileBuilder(boundary: boundary).build(files: files))
        try data.appendString("--\(boundary)--\(Self.lineBreak)")
        
        return (boundary, data)
    }
    
    /// Builds and returns boundary `String` and `Data` that can be sent over network.
    public func build(
        data: Data,
        files: [String: (some AnyMultipartFormDataFile)?],
        optionsDataToJSONObject: JSONSerialization.ReadingOptions = []
    ) throws -> (boundary: String, data: Data) {
        let json: [String: Any?] = try JSONDecoder.decodeJSONFromData(
            data,
            optionsDataToJSONObject: optionsDataToJSONObject
        )
        
        return try build(json: json, files: files)
    }
    
    /// Builds and returns boundary `String` and `Data` that can be sent over network.
    public func build(
        object: some Encodable,
        files: [String: (some AnyMultipartFormDataFile)?],
        optionsDataToJSONObject: JSONSerialization.ReadingOptions = []
    ) throws -> (boundary: String, data: Data) {
        let json: [String: Any?] = try JSONEncoder().encodeObjectToJSON(
            object,
            optionsDataToJSONObject: optionsDataToJSONObject
        )
        
        return try build(json: json, files: files)
    }
}

// MARK: - Helpers
extension Data {
    mutating func appendString(_ string: String) throws {
        guard let data: Data = string.data(using: .utf8) else {
            throw CastingError(from: "String", to: "Data")
        }
        
        append(data)
    }
}
