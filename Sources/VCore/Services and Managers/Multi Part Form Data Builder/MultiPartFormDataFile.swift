//
//  MultipartFormDataFile.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/20/21.
//

import Foundation

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
