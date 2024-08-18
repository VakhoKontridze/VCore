//
//  KeyboardObserver.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.07.24.
//

import SwiftUI
import Combine

// MARK: - Keyboard Observer
/// Object that observes changes in keyboard frame.
///
///     @StateObject private var keyboardObserver: KeyboardObserver = .init()
///     @State private var text: String = ""
///
///     var body: some View {
///         ZStack(content: {
///             TextField("", text: $text)
///                 .textFieldStyle(.roundedBorder)
///                 .padding()
///         })
///         .frame(maxHeight: .infinity, alignment: .bottom)
///
///         // Must be written last
///         .offset(y: -keyboardObserver.offset)
///         .animation(keyboardObserver.animation, value: keyboardObserver.offset)
///         .withDisabledKeyboardResponsiveness(regions: .keyboard)
///     }
///
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
public final class KeyboardObserver: ObservableObject { // TODO: iOS 17.0 - Convert to `Observable`
    // MARK: Properties - UI Model
    private let uiModel: KeyboardObserverUIModel

    // MARK: Properties - Offset
    /// Offset.
    @Published private(set) public var offset: CGFloat = 0

    // `UIResponder.keyboardWillShowNotification` is usually called twice, as input accessory view is attached later.
    // During animations, `offset` is modified. But if event fires immediately second time, calculation will be invalid.
    // To combat this, a debouncing, delayed timer can be used to animate offset using `withAnimation(_:_:)`. But, it's not ideal UX-wise.
    // Additionally, `withAnimation(_:_:)` doesn't work properly with `offset(x:y:)` modifier, which is needed for keyboard avoidance.
    // Both of this problems can be fixed by using a cached, stable offset, and animation view using `animation(_:value:)` modifier.
    private var offsetStable: CGFloat = 0

    // MARK: Properties - Animation
    /// Animation.
    @Published private(set) public var animation: Animation? = {
#if canImport(UIKit) && !os(watchOS)
        SystemKeyboardInfo().toSwiftUIAnimation
#else
        fatalError() // Not supported
#endif
    }()

    // MARK: Properties - Cancellables
    private var subscriptions: Set<AnyCancellable> = []

    // MARK: Initializers
    public init(
        uiModel: KeyboardObserverUIModel = .init()
    ) {
        self.uiModel = uiModel

        addSubscriptions()
    }

    // MARK: Subscriptions
    private func addSubscriptions() {
#if canImport(UIKit) && !os(watchOS)
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .sink(receiveValue: { [weak self] in self?.keyboardWillShow(notification: $0) })
            .store(in: &subscriptions)

        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .sink(receiveValue: { [weak self] in self?.keyboardWillHide(notification: $0) })
            .store(in: &subscriptions)
#endif
    }

    // MARK: Keyboard Management
#if canImport(UIKit) && !os(watchOS)
    private func keyboardWillShow(notification: Notification) {
        let systemKeyboardInfo: SystemKeyboardInfo = .init(notification: notification)
        
        let offset: CGFloat? = {
            switch uiModel.keyboardResponsivenessStrategy {
            case .none:
                return nil

            case .offset(let offset):
                return offset

            case .offsetByKeyboardHeight(let additionalOffset):
                guard let systemKeyboardHeight: CGFloat = systemKeyboardInfo.frame?.size.height else { return nil } // Will never fail

                return systemKeyboardHeight + additionalOffset

            case .offsetByObscuredViewHeight(let additionalOffset):
                guard let screen: UIScreen = notification.object as? UIScreen else { return nil } // Will never fail

                guard let window: UIWindow = screen.window else { return nil } // Will never fail
                let windowHeight: CGFloat = window.frame.size.height

                guard let firstResponderView: UIView = window.childFirstResponderView else { return nil } // Will never fail
                let viewGlobalBoundsMaxY: CGFloat = firstResponderView.convert(firstResponderView.bounds, to: firstResponderView.window).maxY

                let currentOffset: CGFloat = self.offsetStable

                guard let systemKeyboardHeight: CGFloat = systemKeyboardInfo.frame?.size.height else { return nil } // Will never fail

                let viewDistanceToBottom: CGFloat = windowHeight - viewGlobalBoundsMaxY - currentOffset
                
                let obscuredHeight: CGFloat = max(0, systemKeyboardHeight + additionalOffset - viewDistanceToBottom)

                return obscuredHeight
            }
        }()

        if let offset {
            self.offset = offset
            self.animation = systemKeyboardInfo.toSwiftUIAnimation

            Task(operation: {
                try? await Task.sleep(seconds: systemKeyboardInfo.nonZeroAnimationDuration)
                self.offsetStable = offset
            })
        }
    }

    private func keyboardWillHide(notification: Notification) {
        let systemKeyboardInfo: SystemKeyboardInfo = .init(notification: notification)

        let offset: CGFloat? = {
            switch uiModel.keyboardResponsivenessStrategy {
            case .none:
                return nil

            case .offset:
                return 0

            case .offsetByKeyboardHeight:
                return 0

            case .offsetByObscuredViewHeight:
                return 0
            }
        }()

        if let offset {
            self.offset = offset
            self.animation = systemKeyboardInfo.toSwiftUIAnimation

            Task(operation: {
                try? await Task.sleep(seconds: systemKeyboardInfo.nonZeroAnimationDuration)
                self.offsetStable = offset
            })
        }
    }
#endif
}

// MARK: - Helpers
#if canImport(UIKit) && !os(watchOS)

@available(visionOS, unavailable)
extension UIScreen {
    fileprivate var window: UIWindow? {
        UIApplication.shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.screen == self }
    }
}

@available(tvOS, unavailable)
extension SystemKeyboardInfo {
    fileprivate var toSwiftUIAnimation: Animation {
        if animationOptions.contains(.curveLinear) {
            Animation.linear(duration: nonZeroAnimationDuration)
        } else if animationOptions.contains(.curveEaseIn) {
            Animation.easeIn(duration: nonZeroAnimationDuration)
        } else if animationOptions.contains(.curveEaseOut) {
            Animation.easeOut(duration: nonZeroAnimationDuration)
        } else if animationOptions.contains(.curveEaseInOut) {
            Animation.easeInOut(duration: nonZeroAnimationDuration)
        } else {
            Animation.linear(duration: nonZeroAnimationDuration)
        }
    }
}

#endif
