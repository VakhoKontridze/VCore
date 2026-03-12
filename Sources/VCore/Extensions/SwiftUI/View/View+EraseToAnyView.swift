//
//  View+EraseToAnyView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11.11.23.
//

import SwiftUI

extension View {
    /// Wraps `View` with a type eraser.
    ///
    ///     Color.accentColor.eraseToAnyView()
    ///
    public func eraseToAnyView() -> AnyView {
        .init(self)
    }

    /// Wraps `View` with a type eraser.
    ///
    ///     Color.accentColor.eraseToAnyViewErasing()
    ///
    public func eraseToAnyViewErasing() -> AnyView {
        .init(erasing: self)
    }
}
