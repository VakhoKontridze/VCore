//
//  FetchDelegatingAsyncImageContent.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.03.23.
//

import SwiftUI

// MARK: - Fetch Delegating Async Image Content
enum FetchDelegatingAsyncImageContent<Content, PlaceholderContent>
    where
        Content: View,
        PlaceholderContent: View
{
    case empty
    
    case content(
        content: (Image) -> Content
    )
    
    case contentPlaceholder(
        content: (Image) -> Content,
        placeholder: () -> PlaceholderContent
    )
    
    case contentWithPhase(
        content: (AsyncImagePhaseBackwardsCompatible) -> Content
    )
}

// MARK: - Async Image Phase Backwards-Compatible
enum AsyncImagePhaseBackwardsCompatible { // Needed, because enum cannot have associated value that has availability check
    // MARK: Cases
    case empty
    case success(Image)
    case failure(Error)
    
    // MARK: Properties
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
    var toAsyncImagePhase: AsyncImagePhase {
        switch self {
        case .empty: return .empty
        case .success(let image): return .success(image)
        case .failure(let error): return .failure(error)
        }
    }
}
