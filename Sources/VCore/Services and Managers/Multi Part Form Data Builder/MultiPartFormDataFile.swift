//
//  MultipartFormDataFile.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/20/21.
//

import Foundation

// MARK: - Any Multipart Form Data File
/// Type that can be passed to `MultipartFormDataBuilder`.
///
/// While not a non-nominal type, `AnyMultipartFormDataFile` mimics `Any`.
///
/// `MultipartFormDataFile`, `Dictionary` with a value of `AnyMultipartFormDataFile`, and array of `AnyMultipartFormDataFile` all conform to this `protocol`.
/// This allows `MultipartFormDataBuilder` to effectively send a single item, dictionary, array, combination, or a nested structure of each other.
///
/// Files passed to `MultiParFormDataBuilder` via dictionary will have joined names,
/// while those passed via array will be enumerated using indexes.
///
///     let files: [String: (some AnyMultipartFormDataFile)?] = [
///         "main_image": MultipartFormDataFile(mimeType: "image/jpeg", data: mainImageData),
///
///         "gallery": [
///             "thumbnail": MultipartFormDataFile(mimeType: "image/jpeg", data: thumbnailData),
///
///             "small_images": [
///                 MultipartFormDataFile(mimeType: "image/jpeg", data: smallImage1Data),
///                 MultipartFormDataFile(mimeType: "image/jpeg", data: smallImage2Data),
///             ],
///
///             "large_images": [
///                 MultipartFormDataFile(filename: "large-image-1.jpg", mimeType: "image/jpeg", data: largeImage1Data),
///                 MultipartFormDataFile(filename: "large-image-2.jpg", mimeType: "image/jpeg", data: largeImage2Data),
///             ]
///         ]
///     ]
///
/// Name and filenames generated once `MultipartFormDataBuilder` executes `build` method are:
///
///     ... name=\"main_image\"; filename=\"main_image.jpeg\" ...
///     ... name=\"gallery[thumbnail]\"; filename=\"gallery[thumbnail].jpeg\" ...
///     ... name=\"gallery[small_images][0]\"; filename=\"gallery[small_images][0].jpeg\" ...
///     ... name=\"gallery[small_images][1]\"; filename=\"gallery[small_images][1].jpeg\" ...
///     ... name=\"gallery[large_images][0]\"; filename=\"large-image-1.jpg\" ...
///     ... name=\"gallery[large_images][1]\"; filename=\"large-image-2.jpg\" ...
///
/// For additional info, refer to `MultipartFormDataBuilder`.
public protocol AnyMultipartFormDataFile {}

extension MultipartFormDataFile: AnyMultipartFormDataFile {}

extension Optional: AnyMultipartFormDataFile where Wrapped == AnyMultipartFormDataFile {}

extension Array: AnyMultipartFormDataFile where Element == Optional<AnyMultipartFormDataFile> {}

extension Dictionary: AnyMultipartFormDataFile where Key == String, Value == Optional<AnyMultipartFormDataFile> {}

// MARK: - Multipart Form Data File
/// Building block of objects conforming to `AnyMultipartFormDataFile`.
///
/// Can be placed in `Dictionary` or `Array`.
///
///     let files: [String: (some AnyMultipartFormDataFile)?] = [
///         "main_image": MultipartFormDataFile(mimeType: "image/jpeg", data: mainImageData),
///
///         "gallery": [
///             "thumbnail": MultipartFormDataFile(mimeType: "image/jpeg", data: thumbnailData),
///
///             "small_images": [
///                 MultipartFormDataFile(mimeType: "image/jpeg", data: smallImage1Data),
///                 MultipartFormDataFile(mimeType: "image/jpeg", data: smallImage2Data),
///             ],
///
///             "large_images": [
///                 MultipartFormDataFile(filename: "large-image-1.jpg", mimeType: "image/jpeg", data: largeImage1Data),
///                 MultipartFormDataFile(filename: "large-image-2.jpg", mimeType: "image/jpeg", data: largeImage2Data),
///             ]
///         ]
///     ]
///
public struct MultipartFormDataFile: Sendable {
    // MARK: Properties
    /// File name.
    ///
    /// If `nil`, `String` passed to `[String: (some AnyMultipartFormDataFile)?]` `Dictionary` will be used.
    /// With an explicit `filename`, a mime type is not automatically appended.
    public var filename: String?
    
    /// File mime type.
    public var mimeType: String
    
    /// Data associated with the file.
    public var data: Data?
    
    // MARK: Initializers
    /// Initializes `MultipartFormDataFile`.
    public init(
        filename: String? = nil,
        mimeType: String,
        data: Data?
    ) {
        self.filename = filename
        self.mimeType = mimeType
        self.data = data
    }

    // MARK: Helpers
    func generateFilename(key: String) -> String {
        if let filename {
            filename
        } else if let fileExtension: String = mimeType.components(separatedBy: "/").last?.nonEmpty {
            "\(key).\(fileExtension)"
        } else {
            key
        }
    }
}
