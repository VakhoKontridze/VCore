//
//  KeyboardObserver.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.07.24.
//

import SwiftUI
import Combine
import OSLog

// MARK: - Keyboard Observer
/// Object that observes changes in keyboard frame.
///
///     @State private var keyboardObserver: KeyboardObserver = .init()
///     @State private var text: String = ""
///
///     var body: some View {
///         ZStack {
///             TextField("", text: $text)
///                 .textFieldStyle(.roundedBorder)
///                 .padding()
///         }
///         .frame(maxHeight: .infinity, alignment: .bottom)
///
///         // Must be written last
///         .offset(y: -keyboardObserver.offset)
///         .animation(keyboardObserver.animation, value: keyboardObserver.offset)
///         .ignoresSafeArea(.keyboard)
///     }
///
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
@Observable
@MainActor
public final class KeyboardObserver: Sendable {
    // MARK: Properties - UI Model
    @ObservationIgnored private let uiModel: KeyboardObserverUIModel

    // MARK: Properties - Offset
    /// Offset.
    private(set) public var offset: CGFloat = 0

    // `UIResponder.keyboardWillShowNotification` is usually called twice, as input accessory view is attached later.
    // During animations, `offset` is modified. But if event fires immediately second time, calculation will be invalid.
    // To combat this, a debouncing, delayed timer can be used to animate offset using `withAnimation(_:_:)`. But, it's not ideal UX-wise.
    // Additionally, `withAnimation(_:_:)` doesn't work properly with `offset(x:y:)` modifier, which is needed for keyboard avoidance.
    // Both of this problems can be fixed by using a cached, stable offset, and animation view using `animation(_:value:)` modifier.
    @ObservationIgnored private var offsetStable: CGFloat = 0

    // MARK: Properties - Animation
    /// Animation.
    private(set) public var animation: Animation? = {
#if canImport(UIKit) && !os(watchOS)
        SystemKeyboardInfo().toSwiftUIAnimation
#else
        fatalError() // Not supported
#endif
    }()

    // MARK: Properties - Cancellables
    @ObservationIgnored private var subscriptions: Set<AnyCancellable> = []

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
            .sink { [weak self] in self?.keyboardWillShow(notification: $0) }
            .store(in: &subscriptions)

        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { [weak self] in self?.keyboardWillHide(notification: $0) }
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
                guard let systemKeyboardHeight: CGFloat = systemKeyboardInfo.frame?.size.height else {
                    Logger.keyboardObserver.warning("Failed to retrieve system keyboard height from 'Notification': \(notification)")
                    return nil
                }

                return systemKeyboardHeight + additionalOffset

            case .offsetByObscuredViewHeight(let additionalOffset):
                guard let screen: UIScreen = notification.object as? UIScreen else {
                    Logger.keyboardObserver.warning("Failed to retrieve 'UIScreen' from 'Notification': \(notification)")
                    return nil
                }

                guard let window: UIWindow = screen.windows.first(where: { $0.isKeyWindow }) else {
                    Logger.keyboardObserver.warning("Failed to retrieve key 'UIWindow' from 'UIScreen': \(screen)")
                    return nil
                }
                
                let windowHeight: CGFloat = window.frame.size.height

                guard let firstResponderView: UIView = window.childFirstResponderView else {
                    Logger.keyboardObserver.warning("Failed to retrieve child first responder 'UIView' from 'UIWindow': \(window)")
                    return nil
                }
                
                guard let firstResponderViewSuperView: UIView = firstResponderView.superview else {
                    Logger.keyboardObserver.warning("Failed to retrieve superview from 'UIView': \(firstResponderView)")
                    return nil
                }
                
                let viewGlobalFrameMaxY: CGFloat = firstResponderViewSuperView.convert(firstResponderView.frame, to: nil).maxY

                let currentOffset: CGFloat = self.offsetStable

                guard let systemKeyboardHeight: CGFloat = systemKeyboardInfo.frame?.size.height else {
                    Logger.keyboardObserver.warning("Failed to retrieve system keyboard height from 'Notification': \(notification)")
                    return nil
                }

                let viewDistanceToBottom: CGFloat = windowHeight - viewGlobalFrameMaxY - currentOffset
                
                let obscuredHeight: CGFloat = max(0, systemKeyboardHeight + additionalOffset - viewDistanceToBottom)

                return obscuredHeight
            }
        }()

        if let offset {
            // No need to handle reentrancy and cancellation
            Task { @MainActor in
                self.offset = offset
                self.animation = systemKeyboardInfo.toSwiftUIAnimation
                
                try? await Task.sleep(for: .seconds(systemKeyboardInfo.nonZeroAnimationDuration))
                
                self.offsetStable = offset
            }
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
            // No need to handle reentrancy and cancellation
            Task { @MainActor in
                self.offset = offset
                self.animation = systemKeyboardInfo.toSwiftUIAnimation
                
                try? await Task.sleep(for: .seconds(systemKeyboardInfo.nonZeroAnimationDuration))
                
                self.offsetStable = offset
            }
        }
    }
    
#endif
}

// MARK: - Helpers
#if canImport(UIKit) && !os(watchOS)

@available(visionOS, unavailable)
extension UIScreen {
    fileprivate var windows: [UIWindow] {
        UIApplication.shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
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
