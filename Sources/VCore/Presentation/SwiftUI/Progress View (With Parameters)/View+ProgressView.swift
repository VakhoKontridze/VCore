//
//  View+ProgressView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 02.10.22.
//

public import SwiftUI

extension View {
    /// Presents `ProgressView` when `parameters` is non-`nil`.
    ///
    ///     @State private var parameters: ProgressViewParameters = .init()
    ///
    ///     var body: some View {
    ///         content
    ///             .progressView(parameters: parameters)
    ///     }
    ///
    public func progressView(
        parameters: ProgressViewParameters?
    ) -> some View {
        self
            .blocksHitTesting(parameters?.isInteractionEnabled == false)
            .overlay {
                if let parameters {
                    ParameterizedProgressView(parameters: parameters)
                }
            }
    }
}

#if DEBUG

#Preview {
    let parameters: ProgressViewParameters = .init()

    Color.clear
        .progressView(parameters: parameters)
}

#endif
