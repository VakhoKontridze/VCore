//
//  TouchSensitiveContainerContent.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 17.09.23.
//

import SwiftUI

// MARK: - Touch Sensitive Container Content
@available(tvOS 16.0, *)@available(tvOS, unavailable)
enum TouchSensitiveContainerContent<Content> where Content: View {
    case content(() -> Content)
    case contentWithState((TouchSensitiveContainerInternalState) -> Content)
}
