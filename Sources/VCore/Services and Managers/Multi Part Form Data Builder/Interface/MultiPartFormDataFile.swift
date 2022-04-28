//
//  MultiPartFormDataFile.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/20/21.
//

import Foundation

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
///         "main_image": MultiPartFormDataFile(mimeType: "image/jpeg", data: mainImageData),
///
///         "gallery": [
///             "thumbnail": MultiPartFormDataFile(mimeType: "image/jpeg", data: thumbnailData),
///
///             "small_images": [
///                 MultiPartFormDataFile(mimeType: "image/jpeg", data: smallImage1Data),
///                 MultiPartFormDataFile(mimeType: "image/jpeg", data: smallImage2Data),
///             ],
///
///             "large_images": [
///                 MultiPartFormDataFile(filename: "large-image-1.jpg", mimeType: "image/jpeg", data: largeImage1Data),
///                 MultiPartFormDataFile(filename: "large-image-2.jpg", mimeType: "image/jpeg", data: largeImage2Data),
///             ]
///         ]
///     ]
///
/// Name and filenames generated once `MultiPartFormDataBuilder` executes `build` method are:
///
///     ... name=\"main_image\"; filename=\"main_image.jpeg\" ...
///     ... name=\"gallery[thumbnail]\"; filename=\"gallery[thumbnail].jpeg\" ...
///     ... name=\"gallery[small_images][0]\"; filename=\"gallery[small_images][0].jpeg\" ...
///     ... name=\"gallery[small_images][1]\"; filename=\"gallery[small_images][1].jpeg\" ...
///     ... name=\"gallery[large_images][0]\"; filename=\"large-image-1.jpg\" ...
///     ... name=\"gallery[large_images][1]\"; filename=\"large-image-2.jpg\" ...
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
    /// File name.
    ///
    /// If `nil`, `String` passed to `[String: AnyMultiPartFormFile?]` `Dictionary` will be used.
    /// With an explicit `filename`, a mime type is not automatically appended.
    public let filename: String?
    
    /// File mime type.
    public let mimeType: String
    
    /// Data associated with the file.
    public let data: Data?
    
    // MARK: Initializers
    /// Initailizes `MultiPartFormDataFile`.
    public init(
        filename: String? = nil,
        mimeType: String,
        data: Data?
    ) {
        self.filename = filename
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
            if let fileName: String = file.filename {
                return fileName
            } else if let fileExtension: String = file.mimeType.components(separatedBy: "/").last {
                return "\(name).\(fileExtension)"
            } else {
                return name
            }
        }()
        self.mimeType = file.mimeType
        self.data = file.data
    }
}
