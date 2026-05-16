//
//  ImageRepositoryError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

import Foundation

/// Error that occurs during the operations in `ImageRepository`.
@MemberwiseInitializable(accessLevelModifier: .private)
nonisolated public struct ImageRepositoryError: BaseErrorProtocol, Equatable {
    // MARK: Properties
    public static let domain: String = "com.vakhtang-kontridze.vcore.image-repository"
    public let code: Int
    public let description: String
    
    // MARK: Initializers
    /// Indicates that image was expected to be found in cache, but wasn't.
    public static var imageNotInCache: Self {
        .init(
            code: 1,
            description: "Image not found in cache"
        )
    }
    
    /// Indicates that operation failed to create an image.
    public static var failedToCreateImage: Self {
        .init(
            code: 2,
            description: "Failed to create image"
        )
    }
    
    /// Indicates that operation failed to resize an image.
    public static var failedToResizeImage: Self {
        .init(
            code: 3,
            description: "Failed to resize image"
        )
    }
    
    // MARK: Equatable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.code == rhs.code
    }
}
