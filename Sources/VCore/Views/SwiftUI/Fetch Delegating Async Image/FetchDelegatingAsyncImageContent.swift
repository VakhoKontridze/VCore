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
        content: (AsyncImagePhase) -> Content
    )
}
