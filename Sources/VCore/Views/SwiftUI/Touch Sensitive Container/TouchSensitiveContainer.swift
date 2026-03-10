//
//  TouchSensitiveContainer.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 17.09.23.
//

import SwiftUI

/// `View` that detects and reacts to touch down and touch up interactions.
///
///     var body: some View {
///         TouchSensitiveContainer {
///             Text("Lorem ipsum")
///                 .padding()
///         }
///     }
///
/// To resolve conflicts with external gestures, use `simultaneousGesture(_:)`.
///
///     var body: some View {
///         TouchSensitiveContainer {
///             Text("Lorem ipsum")
///                 .padding()
///         }
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
public struct TouchSensitiveContainer<Content>: View where Content: View {
    // MARK: Properties - Appearance
    private let appearance: TouchSensitiveContainerAppearance

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
        appearance: TouchSensitiveContainerAppearance = .init(),
        action: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.appearance = appearance
        self.action = action
        self.content = .content(builder: content)
    }

    /// Initializes `TouchSensitiveContainer` with content.
    public init(
        appearance: TouchSensitiveContainerAppearance = .init(),
        action: (() -> Void)? = nil,
        @ViewBuilder content: @escaping (TouchSensitiveContainerInternalState) -> Content
    ) {
        self.appearance = appearance
        self.action = action
        self.content = .contentWithState(builder: content)
    }

    // MARK: Body
    public var body: some View {
        contentView
            .background(backgroundView)
    }

    @ViewBuilder 
    private var contentView: some View {
        switch content {
        case .content(let builder):
            builder()
                .opacity(appearance.contentOpacities.value(for: internalState))

        case .contentWithState(let builder):
            builder(internalState)
        }
    }

    private var backgroundView: some View {
        appearance.backgroundColors.value(for: internalState)
            .contentShape(.rect)
            .onTapGesture(count: appearance.tapCount, perform: didPerformInteraction)
    }

    // MARK: Actions
    private func didPerformInteraction() {
        guard appearance.isTapEnabled else { return }
        
        isPressed = true

        executeWithDelay(appearance.animationDelay) {
            withAnimation(appearance.animation) {
                isPressed = false
            }
        }

        action?()
    }

    private func executeWithDelay(
        _ delay: TimeInterval,
        block: @escaping () -> Void
    ) {
        if let delay = delay.nonZero {
            // No need to handle reentrancy and cancellation
            Task { @MainActor in
                try? await Task.sleep(for: .seconds(delay))
                block()
            }
        } else {
            block()
        }
    }
}

#if DEBUG

#if !os(tvOS) // Redundant

#Preview {
    TouchSensitiveContainer {
        Text("Lorem ipsum")
            .allowsHitTesting(false)
            .padding()
    }
}

#endif

#endif
