//
//  AnyMultiPartFormDataFile.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 01.08.25.
//

import Foundation

/// Type that can be passed to `MultipartFormDataBuilder`.
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
nonisolated public protocol AnyMultipartFormDataFile {}

nonisolated extension MultipartFormDataFile: AnyMultipartFormDataFile {}

nonisolated extension Optional: AnyMultipartFormDataFile where Wrapped == AnyMultipartFormDataFile {}

nonisolated extension Array: AnyMultipartFormDataFile where Element == AnyMultipartFormDataFile? {}

nonisolated extension Dictionary: AnyMultipartFormDataFile where Key == String, Value == AnyMultipartFormDataFile? {}
