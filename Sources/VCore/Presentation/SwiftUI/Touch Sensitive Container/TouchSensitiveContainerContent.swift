//
//  TouchSensitiveContainerContent.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 17.09.23.
//

import SwiftUI

@available(tvOS, unavailable)
enum TouchSensitiveContainerContent<Content> where Content: View {
    case content(builder: () -> Content)
    case contentWithState(builder: (TouchSensitiveContainerInternalState) -> Content)
}
