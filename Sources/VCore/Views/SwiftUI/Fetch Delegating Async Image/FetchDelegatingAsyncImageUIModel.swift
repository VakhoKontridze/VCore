//
//  FetchDelegatingAsyncImageUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.03.23.
//

import SwiftUI

// MARK: - Fetch Delegating Async Image UI Model
/// Model that describes UI.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct FetchDelegatingAsyncImageUIModel {
    // MARK: Properties
    /// Placeholder color.
    public var placeholderColor: Color = .gray.opacity(0.3)

    /// Indicates if image is removed when view disappears. Set to `false`.
    public var removesImageOnDisappear: Bool = false
    
    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}
}
