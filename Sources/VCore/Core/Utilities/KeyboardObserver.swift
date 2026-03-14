//
//  KeyboardObserver.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.07.24.
//

import SwiftUI
import Combine
import OSLog

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
///                 .offset(y: -keyboardObserver.offset)
///         }
///         .frame(maxHeight: .infinity, alignment: .bottom)
///
///         // Must be written last
///         .animation(keyboardObserver.animation, value: keyboardObserver.offset)
///         .ignoresSafeArea(.keyboard)
///     }
///
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
@Observable
public final class KeyboardObserver {
    // MARK: Properties
    /// Keyboard responsiveness strategy.
    public var keyboardResponsivenessStrategy: KeyboardResponsivenessStrategy
    
    /// Offset.
    public private(set) var offset: CGFloat = 0

    // `UIResponder.keyboardWillShowNotification` is usually called twice, as input accessory view is attached later.
    // During animations, `offset` is modified. But if event fires immediately second time, calculation will be invalid.
    // To combat this, a debouncing, delayed timer can be used to animate offset using `withAnimation(_:_:)`. But, it's not ideal UX-wise.
    // Additionally, `withAnimation(_:_:)` doesn't work properly with `offset(x:y:)` modifier, which is needed for keyboard avoidance.
    // Both of this problems can be fixed by using a cached, stable offset, and animation view using `animation(_:value:)` modifier.
    @ObservationIgnored private var offsetStable: CGFloat = 0

    /// Animation.
    public private(set) var animation: Animation? = {
#if canImport(UIKit) && !os(watchOS)
        SystemKeyboardInfo().toSwiftUIAnimation
#else
        fatalError()
#endif
    }()

    // MARK: Properties - Subscriptions
    private var keyboardShowTask: Task<Void, Never>?
    private var keyboardHideTask: Task<Void, Never>?
    
    @ObservationIgnored private var cancellables: Set<AnyCancellable> = []

    // MARK: Initializers
    public init(
        keyboardResponsivenessStrategy: KeyboardResponsivenessStrategy = .default
    ) {
        self.keyboardResponsivenessStrategy = keyboardResponsivenessStrategy
        
        addSubscriptions()
    }

    // MARK: Subscriptions
    private func addSubscriptions() {
#if canImport(UIKit) && !os(watchOS)
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .sink { [weak self] in self?.keyboardWillShow(notification: $0) }
            .store(in: &cancellables)

        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { [weak self] in self?.keyboardWillHide(notification: $0) }
            .store(in: &cancellables)
#endif
    }

    // MARK: Keyboard Management
#if canImport(UIKit) && !os(watchOS)
    
    private func keyboardWillShow(notification: Notification) {
        let systemKeyboardInfo: SystemKeyboardInfo = .init(notification: notification)
        
        let offset: CGFloat? = {
            switch keyboardResponsivenessStrategy {
            case .none:
                return nil

            case .offset(let offset):
                return offset

            case .offsetByKeyboardHeight(let additionalOffset):
                guard let systemKeyboardHeight: CGFloat = systemKeyboardInfo.frame?.size.height else {
                    Logger.keyboardObserver.error("Failed to retrieve system keyboard height from 'Notification': \(notification)")
                    return nil
                }

                return systemKeyboardHeight + additionalOffset

            case .offsetByObscuredViewHeight(let additionalOffset):
                guard let window: UIWindow = keyWindow(from: notification) else {
                    Logger.keyboardObserver.error("Failed to retrieve 'UIScreen' from 'Notification': \(notification)")
                    return nil
                }
                
                let windowHeight: CGFloat = window.frame.size.height

                guard let firstResponderView: UIView = window.childFirstResponderView else {
                    Logger.keyboardObserver.error("Failed to retrieve child first responder 'UIView' from 'UIWindow': \(window)")
                    return nil
                }
                
                guard let firstResponderViewSuperView: UIView = firstResponderView.superview else {
                    Logger.keyboardObserver.error("Failed to retrieve superview from 'UIView': \(firstResponderView)")
                    return nil
                }
                
                let viewGlobalFrameMaxY: CGFloat = firstResponderViewSuperView.convert(firstResponderView.frame, to: nil).maxY

                let currentOffset: CGFloat = self.offsetStable

                guard let systemKeyboardHeight: CGFloat = systemKeyboardInfo.frame?.size.height else {
                    Logger.keyboardObserver.error("Failed to retrieve system keyboard height from 'Notification': \(notification)")
                    return nil
                }

                let viewDistanceToBottom: CGFloat = windowHeight - viewGlobalFrameMaxY - currentOffset
                
                let obscuredHeight: CGFloat = max(0, systemKeyboardHeight + additionalOffset - viewDistanceToBottom)

                return obscuredHeight
            }
        }()

        if
            let offset,
            offset != self.offset
        {
            keyboardShowTask?.cancel()
            keyboardHideTask?.cancel()
            
            keyboardShowTask = Task {
                defer { keyboardShowTask = nil }

                self.offset = offset
                self.animation = systemKeyboardInfo.toSwiftUIAnimation
                
                try? await Task.sleep(for: .seconds(systemKeyboardInfo.nonZeroAnimationDuration))
                guard !Task.isCancelled else { return }
                
                self.offsetStable = offset
            }
        }
    }

    private func keyboardWillHide(notification: Notification) {
        let systemKeyboardInfo: SystemKeyboardInfo = .init(notification: notification)

        let offset: CGFloat? = {
            switch keyboardResponsivenessStrategy {
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

        if
            let offset,
            offset != self.offset
        {
            keyboardShowTask?.cancel()
            keyboardHideTask?.cancel()
            
            keyboardHideTask = Task {
                defer { keyboardHideTask = nil }
                
                self.offset = offset
                self.animation = systemKeyboardInfo.toSwiftUIAnimation
                
                try? await Task.sleep(for: .seconds(systemKeyboardInfo.nonZeroAnimationDuration))
                guard !Task.isCancelled else { return }
                
                self.offsetStable = offset
            }
        }
    }
    
#endif
    
    // MARK: Helpers
    
#if canImport(UIKit) && !os(watchOS)
    
    private func keyWindow(
        from notification: Notification
    ) -> UIWindow? {
        guard
            let screen: UIScreen = notification.object as? UIScreen
        else {
            return nil
        }
        
        return UIApplication.shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first {
                $0.isKeyWindow &&
                $0.screen == screen
            }
    }

#endif
    
    // MARK: Types
    /// Keyboard responsiveness strategy.
    nonisolated public enum KeyboardResponsivenessStrategy: Equatable, Sendable {
        // MARK: Cases
        /// None.
        case `none`

        /// Offsets container by the specified value.
        case offset(offset: CGFloat)

        /// Offsets container by the keyboard height, plus the specified value.
        ///
        /// Using a positive value (`keyboard height + value > keyboard height`)
        /// may cause visuals gaps between bottom of the modal and the keyboard.
        case offsetByKeyboardHeight(additionalOffset: CGFloat)

        /// Offsets container to un-obscure first responder view, if needed.
        case offsetByObscuredViewHeight(additionalOffset: CGFloat)

        // MARK: Initializers
        /// Default instance.
        public static var `default`: Self { .offsetByObscuredViewHeight(additionalOffset: 20) }
    }
}

#if canImport(UIKit) && !os(watchOS)

@available(tvOS, unavailable)
nonisolated extension SystemKeyboardInfo {
    fileprivate init() {
        self.init(
            frame: nil,
            animationDuration: Self.defaultAnimationDuration,
            animationOptions: Self.defaultAnimationOptions
        )
    }
    
    fileprivate var toSwiftUIAnimation: Animation {
        Animation.timingCurve(
            0.25, 0.10, // p1
            0.25, 1.00, // p2
            duration: nonZeroAnimationDuration
        )
    }
}

#endif
