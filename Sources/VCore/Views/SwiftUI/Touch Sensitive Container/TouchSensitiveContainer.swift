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
///         .onSimultaneousTapGesture(perform: { ... })
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
@available(tvOS 16.0, *)
public struct TouchSensitiveContainer<Content>: View where Content: View {
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

    @ViewBuilder private var contentView: some View {
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
            .contentShape(Rectangle())
            .onTapGesture(perform: didPerformInteraction)
    }

    // MARK: Actions
    // Despite the fact that `isPressed` is immediately set to `false`, it will still work properly.
    // Internal state-handling will function as expected.
    // Likewise, callback with `init` with `content` that passes `TouchSensitiveContainerInternalState` will also function as expected.
    private func didPerformInteraction() {
        isPressed = true
        withAnimation(uiModel.animation, { isPressed = false })

        action?()
    }
}

// MARK: - Preview
@available(tvOS 16.0, *)
struct TouchSensitiveContainer_Preview: PreviewProvider {
    static var previews: some View {
        TouchSensitiveContainer(content: {
            Text("Lorem ipsum")
                .padding()
        })
        .previewLayout(.sizeThatFits)
    }
}
