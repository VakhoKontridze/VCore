//
//  KeyboardObserver.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.07.24.
//

#if canImport(UIKit) && !os(watchOS)

import SwiftUI
import Combine

// MARK: - Keyboard Observer
/// Object that observes changes in keyboard frame.
@available(tvOS, unavailable)
public final class KeyboardObserver: ObservableObject { // TODO: iOS 17.0 - Change to Observable
    // MARK: Properties - UI Model
    private let uiModel: KeyboardObserverUIModel

    // MARK: Properties - Offset
    /// Offset.
    @Published private(set) public var offset: CGFloat = 0

    // MARK: Properties - Cancellables
    private var debounceTimer: Timer?

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
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .sink(receiveValue: { [weak self] notification in
                guard let self else { return }

                debounceTimer?.invalidate()
                debounceTimer = Timer.scheduledTimer(
                    withTimeInterval: uiModel.appearAnimationDebounceDelay,
                    repeats: false,
                    block: { [weak self] _ in
                        guard let self else { return }

                        keyboardWillShow(notification: notification)
                    }
                )
            })
            .store(in: &subscriptions)

        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .sink(receiveValue: { [weak self] notification in
                guard let self else { return }

                debounceTimer?.invalidate()
                debounceTimer = Timer.scheduledTimer(
                    withTimeInterval: uiModel.disappearAnimationDebounceDelay,
                    repeats: false,
                    block: { [weak self] _ in
                        guard let self else { return }

                        keyboardWillHide(notification: notification)
                    }
                )
            })
            .store(in: &subscriptions)
    }

    // MARK: Keyboard Management
    private func keyboardWillShow(notification: Notification) {
        let systemKeyboardInfo: SystemKeyboardInfo = .init(notification: notification)
        
        let offset: CGFloat? = {
            switch uiModel.keyboardResponsivenessStrategy.storage {
            case .none:
                return nil

            case .offset(let offset):
                return offset

            case .offsetByKeyboardHeight(let additionalOffset):
                guard let systemKeyboardHeight: CGFloat = systemKeyboardInfo.frame?.size.height else { return nil } // Will never fail

                return systemKeyboardHeight + additionalOffset

            case .offsetByObscuredSubviewHeight(let additionalOffset):
                guard let screen: UIScreen = notification.object as? UIScreen else { return nil } // Will never fail

                guard let window: UIWindow = screen.window else { return nil } // Will never fail
                let windowHeight: CGFloat = window.frame.size.height

                guard let firstResponderView: UIView = window.childFirstResponderView else { return nil } // Will never fail
                let viewGlobalBoundsMaxY: CGFloat = firstResponderView.convert(firstResponderView.bounds, to: firstResponderView.window).maxY

                let currentOffset: CGFloat = self.offset

                guard let systemKeyboardHeight: CGFloat = systemKeyboardInfo.frame?.size.height else { return nil } // Will never fail

                let viewDistanceToBottom: CGFloat = windowHeight - viewGlobalBoundsMaxY - currentOffset
                
                let obscuredHeight: CGFloat = max(0, systemKeyboardHeight + additionalOffset - viewDistanceToBottom)

                return obscuredHeight
            }
        }()

        if let offset {
            Task(operation: { @MainActor in
                withAnimation(
                    systemKeyboardInfo.toSwiftUIAnimation,
                    { self.offset = offset }
                )
            })
        }
    }

    private func keyboardWillHide(notification: Notification) {
        let systemKeyboardInfo: SystemKeyboardInfo = .init(notification: notification)

        let offset: CGFloat? = {
            switch uiModel.keyboardResponsivenessStrategy.storage {
            case .none:
                return nil

            case .offset:
                return 0

            case .offsetByKeyboardHeight:
                return 0

            case .offsetByObscuredSubviewHeight:
                return 0
            }
        }()

        if let offset {
            Task(operation: { @MainActor in
                withAnimation(
                    systemKeyboardInfo.toSwiftUIAnimation,
                    { self.offset = offset }
                )
            })
        }
    }
}

// MARK: - Helpers
extension UIScreen {
    fileprivate var window: UIWindow? {
        UIApplication.shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.screen == self }
    }
}

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
