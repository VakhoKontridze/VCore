//
//  MultiPartFormDataFile.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/20/21.
//

import UIKit

// MARK: - Any Multi Part Form File
/// Type that can be passed to `MultiPartFormDataBuilder`.
///
/// While not a non-nomilal type, `AnyMultiPartFormFile` mimics `Any`.
///
/// `MultiPartFormDataFile`, `Dictionary` with a value of `AnyMultiPartFormFile`, and array of `AnyMultiPartFormFile` all conform to this protocol.
/// This allows `MultiPartFormDataBuilder` to effectively send a single item, dictionary, array, combination, or a nested structue of each other.
///
/// Files passed to `MultiParFormDataBuilder` via dicrioanry will have joined names,
/// while those passed via array will be enumerated using indexes.
///
///     let files: [String: AnyMultiPartFormFile?] = [
///         "main_image": MultiPartFormDataFile(mimeType: "image/jpeg", data: .init()), // "main_image"
///
///         "gallery": [
///             "thumbnail": MultiPartFormDataFile(mimeType: "image/jpeg", data: thumbnailData), // "gallery[thumbnail]"
///
///             "images": [
///                 MultiPartFormDataFile(mimeType: "image/jpeg", data: image1Data), // "gallery[images][0]"
///                 MultiPartFormDataFile(mimeType: "image/jpeg", data: image2Data), // "gallery[images][1]"
///                 MultiPartFormDataFile(mimeType: "image/jpeg", data: image3Data)  // "gallery[images][2]"
///             ]
///         ]
///     ]
///
/// For additional information, refer to `MultiPartFormDataBuilder`.
public protocol AnyMultiPartFormFile {}

extension MultiPartFormDataFile: AnyMultiPartFormFile {}

extension Dictionary: AnyMultiPartFormFile where Key == String, Value == Optional<AnyMultiPartFormFile> {}

extension Array: AnyMultiPartFormFile where Element == Optional<AnyMultiPartFormFile> {}

extension Optional: AnyMultiPartFormFile where Wrapped == AnyMultiPartFormFile {}
 
// MARK: - Mutli Part Form Data File
/// Building block of objects conforming to `AnyMultiPartFormFile`.
///
/// Can be placed in `Dictionary` or `Array`.
public struct MultiPartFormDataFile {
    // MARK: Properties
    /// File mime type.
    public let mimeType: String
    
    /// Data associated with the file.
    public let data: Data?
    
    // MARK: Initializers
    /// Initailizes `MultiPartFormDataFile`.
    public init(
        mimeType: String,
        data: Data?
    ) {
        self.mimeType = mimeType
        self.data = data
    }
}

// MARK: - _ Mutli Part Form Data File
struct _MultiPartFormDataFile {
    // MARK: Properties
    let name: String
    let filename: String
    let mimeType: String
    let data: Data?
    
    // MARK: Initializers
    init(
        name: String,
        file: MultiPartFormDataFile
    ) {
        self.name = name
        self.filename = {
            if let fileExtension: String = file.mimeType.components(separatedBy: "/").last {
                return "\(name).\(fileExtension)"
            } else {
                return name
            }
        }()
        self.mimeType = file.mimeType
        self.data = file.data
    }
}
