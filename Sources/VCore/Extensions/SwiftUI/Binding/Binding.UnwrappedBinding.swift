//
//  Binding.UnwrappedBinding.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.09.23.
//

import SwiftUI

// MARK: - Binding Unwrapped Binding
extension Binding {
    /// Returns `Binding` wrapper for an `Optional` `Binding` with a default value for getter.
    ///
    ///     @State private var text: String?
    ///
    ///     var body: some View{
    ///         TextField("", text: $text.unwrappedBinding(default: ""))
    ///             .textFieldStyle(.roundedBorder)
    ///     }
    ///
    public func unwrappedBinding<T>(
        default defaultValue: T
    ) -> Binding<T>
        where Value == Optional<T>
    {
        .init(
            get: { wrappedValue ?? defaultValue },
            set: { wrappedValue = $0 }
        )
    }
}
