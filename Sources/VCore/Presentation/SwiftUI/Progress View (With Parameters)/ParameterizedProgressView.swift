//
//  ParameterizedProgressView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 20.10.26.
//

public import SwiftUI

/// Circular `ProgressView` that is configured with `ProgressViewParameters`.
///
///     var body: some View {
///         ParameterizedProgressView(
///             parameters: ProgressViewParameters(
///                 appearanceDelay: .milliseconds(500)
///             )
///         )
///     }
///
/// While `appearanceDelay` elapses, view is transparent but occupies its space, so layout doesn't change once it appears.
///
/// `isInteractionEnabled` has no effect, as view doesn't overlay any content.
/// To block interaction with content, use `progressView(parameters:)` modifier.
public struct ParameterizedProgressView: View {
    // MARK: Properties
    private let parameters: ProgressViewParameters

    @State private var isVisible: Bool

    // MARK: Initializers
    /// Initializes `ParameterizedProgressView` with parameters.
    public init(
        parameters: ProgressViewParameters = .init()
    ) {
        self.parameters = parameters
        
        self._isVisible = State(wrappedValue: parameters.appearanceDelay == nil) // Avoids a transparent first frame when there's no delay
    }

    // MARK: Body
    public var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .scaleEffect(parameters.scalingFactor ?? 1)
            .tint(parameters.color)
            .opacity(isVisible ? 1 : 0)
            .accessibilityHidden(!isVisible)

            .task(id: parameters.appearanceDelay) {
                if let delay: Duration = parameters.appearanceDelay {
                    do {
                        try await Task.sleep(for: delay)
                    } catch {
                        return
                    }
                }

                isVisible = true
            }
    }
}

#if DEBUG

#Preview {
    VStack(spacing: 20) {
        ParameterizedProgressView()

        ParameterizedProgressView(
            parameters: ProgressViewParameters(
                color: .red
            )
        )
        
        ParameterizedProgressView(
            parameters: ProgressViewParameters(
                scalingFactor: 2
            )
        )
        
        ParameterizedProgressView(
            parameters: ProgressViewParameters(
                appearanceDelay: .seconds(1)
            )
        )
    }
}

#endif
