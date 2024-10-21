//
//  TouchSensitiveContainer.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 17.09.23.
//

import SwiftUI

// MARK: - Touch Sensitive Container
/// `View` that detects and reacts to touch down and touch up interactions.
///
///     var body: some View {
///         TouchSensitiveContainer(content: {
///             Text("Lorem ipsum")
///                 .padding()
///         })
///     }
///
/// To resolve conflicts with external gestures, use `simultaneousGesture(_:)`.
///
///     var body: some View {
///         TouchSensitiveContainer(content: {
///             Text("Lorem ipsum")
///                 .padding()
///         })
///         .onSimultaneousTapGesture(perform: ...)
///     }
///
/// `TouchSensitiveContainer` optionally takes `action` parameters.
///
///     var body: some View {
///         TouchSensitiveContainer(
///             action: { ... },
///             content: {
///                 Text("Lorem ipsum")
///                     .padding()
///             }
///         )
///     }
///
@available(tvOS, unavailable) // Doesn't follow HIG
public struct TouchSensitiveContainer<Content>: View, Sendable where Content: View {
    // MARK: Properties - UI Model
    private let uiModel: TouchSensitiveContainerUIModel

    // MARK: Properties - State
    @Environment(\.isEnabled) private var isEnabled: Bool
    @State private var isPressed: Bool = false
    private var internalState: TouchSensitiveContainerInternalState {
        .init(
            isEnabled: isEnabled,
            isPressed: isPressed
        )
    }

    // MARK: Properties - Action
    private let action: (() -> Void)?

    // MARK: Properties - Content
    private let content: TouchSensitiveContainerContent<Content>

    // MARK: Initializers
    /// Initializes `TouchSensitiveContainer` with content.
    public init(
        uiModel: TouchSensitiveContainerUIModel = .init(),
        action: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.uiModel = uiModel
        self.action = action
        self.content = .content(content)
    }

    /// Initializes `TouchSensitiveContainer` with content.
    public init(
        uiModel: TouchSensitiveContainerUIModel = .init(),
        action: (() -> Void)? = nil,
        @ViewBuilder content: @escaping (TouchSensitiveContainerInternalState) -> Content
    ) {
        self.uiModel = uiModel
        self.action = action
        self.content = .contentWithState(content)
    }

    // MARK: Body
    public var body: some View {
        contentView
            .background(content: { backgroundView })
    }

    @ViewBuilder 
    private var contentView: some View {
        switch content {
        case .content(let content):
            content()
                .opacity(uiModel.contentOpacities.value(for: internalState))

        case .contentWithState(let content):
            content(internalState)
        }
    }

    private var backgroundView: some View {
        uiModel.backgroundColors.value(for: internalState)
            .contentShape(.rect)
            .onTapGesture(count: uiModel.tapCount, perform: didPerformInteraction)
    }

    // MARK: Actions
    private func didPerformInteraction() {
        isPressed = true

        executeWithDelay(
            uiModel.animationDelay,
            block: { withAnimation(uiModel.animation, { isPressed = false }) }
        )

        action?()
    }

    private func executeWithDelay(
        _ delay: TimeInterval,
        block: @escaping () -> Void
    ) {
        if let delay = delay.nonZero {
            Task(operation: { @MainActor in
                try? await Task.sleep(seconds: delay)
                block()
            })
        } else {
            block()
        }
    }
}

// MARK: - Preview
#if DEBUG

#if !os(tvOS)

#Preview(body: {
    TouchSensitiveContainer(content: {
        Text("Lorem ipsum")
            .allowsHitTesting(false)
            .padding()
    })
})

#endif

#endif
