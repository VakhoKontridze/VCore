//
//  FetchDelegatingCompletionImageUIModel.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.07.23.
//

import SwiftUI

// MARK: - Fetch Delegating Completion Image UI Model
/// Model that describes UI.
public struct FetchDelegatingCompletionImageUIModel {
    // MARK: Properties
    /// Placeholder color.
    public var placeholderColor: Color = .gray.opacity(0.3)

    /// Indicates if `Image` is removed when parameter changes. Set to `true`.
    public var removesImageOnParameterChange: Bool = true

    /// Indicates if `Image` is removed when component disappears. Set to `false`.
    public var removesImageOnDisappear: Bool = false

    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}
}
