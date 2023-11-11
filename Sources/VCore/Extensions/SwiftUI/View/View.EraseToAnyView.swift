//
//  View.EraseToAnyView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11.11.23.
//

import SwiftUI

// MARK: - View Erase to Any View
extension View {
    /// Wraps `View` with a type eraser.
    ///
    ///     Color.accentColor.eraseToAnyView()
    ///
    func eraseToAnyView() -> AnyView {
        .init(self)
    }

    /// Wraps `View` with a type eraser.
    ///
    ///     Color.accentColor.eraseToAnyView()
    ///
    func eraseToAnyViewErasing() -> AnyView {
        .init(erasing: self)
    }
}
