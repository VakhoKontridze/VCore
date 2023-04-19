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
///     do {
///         let json: [String: Any?] = [
///             "key": "value"
///         ]
///
///         let files: [String: (some AnyMultipartFormDataFile)?] = [
///             "profile": MultipartFormDataFile(
///                 mimeType: "image/jpeg",
///                 data: profileImage?.jpegData(compressionQuality: 0.25)
///             ),
///
///             "gallery": galleryImages?.enumerated().compactMap { (index, image) in
///                 MultipartFormDataFile(
///                     filename: "IMG_\(index).jpg",
///                     mimeType: "image/jpeg",
///                     data: image?.jpegData(compressionQuality: 0.25)
///                 )
///             }
///         ]
///
///         let (boundary, data): (String, Data) = try MultipartFormDataBuilder().build(
///             json: json,
///             files: files
///         )
///
///         var request: NetworkRequest = .init(url: "https://somewebsite.com/api/some_endpoint")
///         request.method = .POST
///         try request.addHeaders(encodable: MultipartFormDataAuthorizedRequestHeaders(
///             boundary: boundary,
///             token: "token"
///         ))
///         request.addBody(data: data)
///
///         let result: [String: Any?] = try await NetworkClient.default.json(from: request)
///
///         print(result)
///
///     } catch {
///         print(error.localizedDescription)
///     }
///
public struct MultipartFormDataBuilder {
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
        data.append(try JSONBuilder(boundary: boundary).build(json: json)) // Logged internally
        data.append(try FileBuilder(boundary: boundary).build(files: files)) // Logged internally
        try data.appendString("--\(boundary)--\(Self.lineBreak)") // Logged internally
        
        return (boundary, data)
    }
    
    /// Builds and returns boundary `String` and `Data` that can be sent over network.
    public func build(
        data: Data,
        files: [String: (some AnyMultipartFormDataFile)?],
        optionsDataToJSON: JSONSerialization.ReadingOptions = []
    ) throws -> (boundary: String, data: Data) {
        let json: [String: Any?] = try JSONDecoderService().json( // Logged internally
            data: data,
            options: optionsDataToJSON
        )
        
        return try build(json: json, files: files)
    }
    
    /// Builds and returns boundary `String` and `Data` that can be sent over network.
    public func build(
        encodable: some Encodable,
        files: [String: (some AnyMultipartFormDataFile)?],
        optionsDataToJSON: JSONSerialization.ReadingOptions = []
    ) throws -> (boundary: String, data: Data) {
        let json: [String: Any?] = try JSONEncoderService().json( // Logged internally
            encodable: encodable,
            optionsDataToJSON: optionsDataToJSON
        )
        
        return try build(json: json, files: files)
    }
}

// MARK: - Helpers
extension Data {
    mutating func appendString(_ string: String) throws {
        guard let data: Data = string.data(using: .utf8) else {
            let error: JSONEncoderError = .init(.failedToEncode)
            VCoreLogError(error, "Failed to encode `String` \"\(string)\" as `Data`")
            throw error
        }
        
        append(data)
    }
}
