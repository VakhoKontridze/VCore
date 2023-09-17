//
//  TouchSensitiveContainerContent.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 17.09.23.
//

import SwiftUI

// MARK: - Touch Sensitive Container Content
enum TouchSensitiveContainerContent<Content> where Content: View {
    case content(() -> Content)
    case contentWithState((TouchSensitiveContainerInternalState) -> Content)
}
