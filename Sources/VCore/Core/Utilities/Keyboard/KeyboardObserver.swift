//
//  KeyboardObserver.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 25.07.24.
//

import Combine
import OSLog
public import SwiftUI

/// Object that observes changes in keyboard frame.
///
///     @State private var keyboardObserver: KeyboardObserver = .init()
///
///     @State private var text: String = ""
///
///     var body: some View {
///         ZStack {
///             Color.white
///
///             VStack(spacing: 0) {
///                 Spacer()
///
///                 TextField("", text: $text)
///                     .textFieldStyle(.roundedBorder)
///                     .padding()
///             }
///             .offset(y: -keyboardObserver.offset)
///         }
///         .animation(keyboardObserver.animation, value: keyboardObserver.offset)
///         .ignoresSafeArea(.keyboard)
///     }
///
/// Complex example with multiple inputs. `GeometryReader` may be required sometimes to work around the quirks of `SwiftUI`.
///
///     @State private var keyboardObserver: KeyboardObserver = .init()
///
///     @State private var text: String = ""
///
///     var body: some View {
///         ZStack {
///             Color.white
///
///             GeometryReader { _ in
///                 VStack(spacing: 0) {
///                     ForEach(0..<10, id: \.self) { _ in
///                         TextField("", text: $text)
///                             .textFieldStyle(.roundedBorder)
///                             .padding()
///                     }
///
///                     Spacer()
///                 }
///             }
///             .offset(y: -keyboardObserver.offset)
///         }
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
    
    @ObservationIgnored private var notification: Notification?
    
    /// Indicates if keyboard is visible.
    public private(set) var isVisible: Bool = false
    
#if canImport(UIKit) && !os(watchOS)
    /// Keyboard info.
    public private(set) var systemKeyboardInfo: SystemKeyboardInfo?
#endif
    
    /// Offset.
    public private(set) var offset: CGFloat = 0

#if canImport(UIKit) && !os(watchOS)
    // The first responder and it's resting frame, captured once per focus.
    // `UIResponder.keyboardWillShowNotification` fires repeatedly while the container is mid-lift,
    // usually as input accessory view is attached later, and on `iOS 27` mid-animation,
    // So re-reading the live frame would feed the applied lift back into the calculation, oscillating the offset.
    @ObservationIgnored private weak var baselineFirstResponderView: UIView?
    @ObservationIgnored private var baselineViewGlobalFrameMaxY: CGFloat?
#endif

    /// Animation.
    public private(set) var animation: Animation? = {
#if canImport(UIKit) && !os(watchOS)
        SystemKeyboardInfo().toSwiftUIAnimation
#else
        fatalError()
#endif
    }()

    // MARK: Properties - Subscriptions
    @ObservationIgnored private var cancellables: Set<AnyCancellable> = []

    // MARK: Initializers
    public init(
        keyboardResponsivenessStrategy: KeyboardResponsivenessStrategy = .default
    ) {
        self.keyboardResponsivenessStrategy = keyboardResponsivenessStrategy
        
        addSubscriptions()
    }
    
    // MARK: API
    /// Recalculates offset.
    public func reposition(
        animated: Bool = true
    ) {
        guard let notification else { return }
        
        if isVisible {
            offsetVisibleKeyboard(
                notification: notification,
                animated: animated
            )
            
        } else {
            offsetHiddenKeyboard(
                notification: notification,
                animated: animated
            )
        }
    }
    
    // MARK: Offset
    private func offsetVisibleKeyboard(
        notification: Notification,
        animated: Bool = true
    ) {
#if canImport(UIKit) && !os(watchOS)
        
        let systemKeyboardInfo: SystemKeyboardInfo = .init(notification: notification)
        self.systemKeyboardInfo = systemKeyboardInfo
        
        let offset: CGFloat? = {
            switch keyboardResponsivenessStrategy {
            case .none:
                return nil

            case .offset(let offset):
                return offset

            case .offsetByKeyboardHeight(let additionalOffset):
                guard let systemKeyboardHeight: CGFloat = systemKeyboardInfo.frame?.size.height else {
                    Logger.default.error("Failed to retrieve system keyboard height from 'Notification' in 'KeyboardObserver': \(notification)")
                    return nil
                }

                return systemKeyboardHeight + additionalOffset

            case .offsetByObscuredViewHeight(let additionalOffset):
                guard let window: UIWindow = keyWindow(from: notification) else {
                    Logger.default.error("Failed to retrieve 'UIScreen' from 'Notification' in 'KeyboardObserver': \(notification)")
                    return nil
                }
                
                let windowHeight: CGFloat = window.frame.size.height

                guard let firstResponderView: UIView = window.childFirstResponderView else {
                    Logger.default.error("Failed to retrieve child first responder 'UIView' from 'UIWindow' in 'KeyboardObserver': \(window)")
                    return nil
                }
                
                guard let firstResponderViewSuperView: UIView = firstResponderView.superview else {
                    Logger.default.error("Failed to retrieve superview from 'UIView' in 'KeyboardObserver': \(firstResponderView)")
                    return nil
                }
                
                let baselineMaxY: CGFloat
                if
                    firstResponderView === baselineFirstResponderView,
                    let storedBaselineMaxY: CGFloat = baselineViewGlobalFrameMaxY
                {
                    baselineMaxY = storedBaselineMaxY

                } else {
                    let liveMaxY: CGFloat = firstResponderViewSuperView.convert(firstResponderView.frame, to: nil).maxY

                    // A responder that focuses while the container is already lifted reports a lifted frame,
                    // so the applied offset is added back to recover the resting position.
                    baselineMaxY = liveMaxY + self.offset

                    baselineFirstResponderView = firstResponderView
                    baselineViewGlobalFrameMaxY = baselineMaxY
                }

                guard let systemKeyboardHeight: CGFloat = systemKeyboardInfo.frame?.size.height else {
                    Logger.default.error("Failed to retrieve system keyboard height from 'Notification' in 'KeyboardObserver': \(notification)")
                    return nil
                }

                let viewDistanceToBottom: CGFloat = windowHeight - baselineMaxY
                
                let obscuredHeight: CGFloat = max(0, systemKeyboardHeight + additionalOffset - viewDistanceToBottom)

                return obscuredHeight
            }
        }()

        if
            let offset,
            offset != self.offset
        {
            self.offset = offset
            
            self.animation = {
                if animated {
                    systemKeyboardInfo.toSwiftUIAnimation
                } else {
                    nil
                }
            }()
        }
        
#endif
    }
    
    private func offsetHiddenKeyboard(
        notification: Notification,
        animated: Bool = true
    ) {
#if canImport(UIKit) && !os(watchOS)
        
        let systemKeyboardInfo: SystemKeyboardInfo = .init(notification: notification)
        self.systemKeyboardInfo = systemKeyboardInfo

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
            self.offset = offset
            
            self.animation = {
                if animated {
                    systemKeyboardInfo.toSwiftUIAnimation
                } else {
                    nil
                }
            }()
        }

#endif
    }

    // MARK: Keyboard
#if canImport(UIKit) && !os(watchOS)
    
    private func keyboardWillShow(
        notification: Notification
    ) {
        self.notification = notification
        
        isVisible = true
        
        offsetVisibleKeyboard(
            notification: notification
        )
    }

    private func keyboardWillHide(
        notification: Notification,
        animated: Bool = true
    ) {
        self.notification = notification
        
        isVisible = false
        
        baselineFirstResponderView = nil
        baselineViewGlobalFrameMaxY = nil
        
        offsetHiddenKeyboard(
            notification: notification
        )
    }
    
#endif
    
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
        /// Default value.
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
