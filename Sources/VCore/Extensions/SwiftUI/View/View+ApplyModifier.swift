//
//  View+ApplyModifier.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 23.03.23.
//

import SwiftUI

// MARK: - View + Apply Modifier
extension View {
    /// Applies a block modifier to a `View` and returns a new `View`.
    ///
    /// This method should be used with caution, since any changes to the condition will cause view state to be reset.
    ///
    ///     var body: some View {
    ///         SomeView()
    ///             .applyModifier {
    ///                 if #available(iOS 99.0, *) {
    ///                     $0.someModifier()
    ///                 } else {
    ///                     $0
    ///                 }
    ///             }
    ///     }
    ///
    public func applyModifier<Content>(
        @ViewBuilder _ block: (Self) -> Content
    ) -> some View
        where Content: View
    {
        block(self)
    }
}
