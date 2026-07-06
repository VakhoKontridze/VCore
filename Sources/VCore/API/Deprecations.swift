//
//  Deprecations.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

public import SwiftUI

nonisolated extension DefaultKeychainService {
    @available(*, deprecated, renamed: "shared")
    public static var `default`: DefaultKeychainService {
        shared
    }
}

nonisolated extension DefaultUserDefaultsService {
    @available(*, deprecated, renamed: "shared")
    public static var `default`: DefaultUserDefaultsService {
        shared
    }
}

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

public import AppKit

nonisolated extension NSColor {
    @available(*, deprecated, renamed: "lightened")
    public func lighten(
        by fraction: CGFloat
    ) -> NSColor {
        lightened(by: fraction)
    }
    
    @available(*, deprecated, renamed: "darkened")
    public func darken(
        by fraction: CGFloat
    ) -> NSColor {
        darkened(by: fraction)
    }
}

#endif

nonisolated extension Color {
    @available(*, deprecated, renamed: "lightened")
    public func lighten(
        by fraction: CGFloat
    ) -> Color {
        lightened(by: fraction)
    }
    
    @available(*, deprecated, renamed: "darkened")
    public func darken(
        by fraction: CGFloat
    ) -> Color {
        darkened(by: fraction)
    }
}

#if canImport(UIKit)

public import UIKit

nonisolated extension UIColor {
    @available(*, deprecated, renamed: "lightened")
    public func lighten(
        by fraction: CGFloat
    ) -> UIColor {
        lightened(by: fraction)
    }
    
    @available(*, deprecated, renamed: "darkened")
    public func darken(
        by fraction: CGFloat
    ) -> UIColor {
        darkened(by: fraction)
    }
}

#endif

#if canImport(UIKit)

nonisolated extension UIImage {
    @available(*, deprecated, message: "Use method with 'toMinDimension' parameter")
    public func scaledDown(
        toDimension newDimension: CGFloat
    ) -> UIImage? {
        scaledDown(toMinDimension: newDimension)
    }
}

#endif

#if canImport(UIKit) && !os(watchOS)

public import UIKit

extension UILabel {
    @available(*, deprecated, message: "Will be removed in '9.0.0'")
    public var singleLineHeight: CGFloat {
        let label: UILabel = { // `preferredMaxLayoutWidth` is not set
            let label: UILabel = .init()
            
            label.text = text?.nonEmpty ?? "A"
            
            label.font = font
            label.textAlignment = textAlignment
            label.lineBreakMode = lineBreakMode
            
            label.numberOfLines = 1
            
            label.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
            label.baselineAdjustment = baselineAdjustment
            label.minimumScaleFactor = minimumScaleFactor
            
            label.allowsDefaultTighteningForTruncation = allowsDefaultTighteningForTruncation
            
            label.lineBreakStrategy = lineBreakStrategy

            label.adjustsFontForContentSizeCategory = adjustsFontForContentSizeCategory
            label.minimumContentSizeCategory = minimumContentSizeCategory
            label.maximumContentSizeCategory = maximumContentSizeCategory
            
            return label
        }()
        
        label.sizeToFit()
        return label.intrinsicContentSize.height
    }
    
    @available(*, deprecated, message: "Will be removed in '9.0.0'")
    public func multiLineHeight(width: CGFloat? = nil, text: String? = nil) -> CGFloat {
        let label: UILabel = {
            let label: UILabel = .init()
            
            label.text = text?.nonEmpty ?? self.text?.nonEmpty ?? "A"
            
            label.font = font
            label.textAlignment = textAlignment
            label.lineBreakMode = lineBreakMode
            
            label.numberOfLines = numberOfLines
            
            label.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
            label.baselineAdjustment = baselineAdjustment
            label.minimumScaleFactor = minimumScaleFactor
            
            label.allowsDefaultTighteningForTruncation = allowsDefaultTighteningForTruncation
            
            label.lineBreakStrategy = lineBreakStrategy

            label.adjustsFontForContentSizeCategory = adjustsFontForContentSizeCategory
            label.minimumContentSizeCategory = minimumContentSizeCategory
            label.maximumContentSizeCategory = maximumContentSizeCategory
            
            label.preferredMaxLayoutWidth = width ?? preferredMaxLayoutWidth
            
            return label
        }()
        
        label.sizeToFit()
        return label.intrinsicContentSize.height
    }
}

#endif

#if canImport(UIKit)
public import UIKit
#elseif canImport(AppKit)
public import AppKit
#endif
import OSLog

@available(*, deprecated, message: "Will be removed in '9.0.0'")
@available(tvOS, unavailable)
@available(watchOS, unavailable)
nonisolated public enum GestureBaseButtonGestureState: Int, Sendable, CaseIterable {
    case possible
    case began
    case ended
    case cancelled
    
    public var didRecognizePress: Bool {
        self == .began
    }

    public var didRecognizeClick: Bool {
        self == .ended
    }
    
#if canImport(UIKit) && !os(watchOS)

    init(state: UIGestureRecognizer.State) {
        self = {
            switch state {
            case .possible:
                return .possible
            
            case .began:
                return .began
            
            case .changed:
                //Logger.baseButtonGestureRecognizer.fault("'changed' 'UIGestureRecognizer.State should not occur in 'GestureBaseButtonGestureState.init(state:)'")
                return .possible
            
            case .ended:
                return .ended
            
            case .cancelled:
                return .cancelled
            
            case .failed:
                //Logger.baseButtonGestureRecognizer.fault("'failed' 'UIGestureRecognizer.State should not occur in 'GestureBaseButtonGestureState.init(state:)'")
                return .possible
            
            @unknown default:
                //Logger.baseButtonGestureRecognizer.fault("Unhandled 'UIGestureRecognizer.State' '\(String(describing: state))' in 'GestureBaseButtonGestureState.init(state:)'")
                return .possible
            }
        }()
    }

#elseif canImport(AppKit)

    init(state: NSGestureRecognizer.State) {
        self = {
            switch state {
            case .possible:
                return .possible
            
            case .began:
                return .began
            
            case .changed:
                //Logger.baseButtonGestureRecognizer.fault("'changed' 'UIGestureRecognizer.State should not occur in 'GestureBaseButtonGestureState.init(state:)'")
                return .possible
            
            case .ended:
                return .ended
            
            case .cancelled:
                return .cancelled
            
            case .failed:
                //Logger.baseButtonGestureRecognizer.fault("'failed' 'UIGestureRecognizer.State should not occur in 'GestureBaseButtonGestureState.init(state:)'")
                return .possible
            
            @unknown default:
                //Logger.baseButtonGestureRecognizer.fault("Unhandled 'NSGestureRecognizer.State' '\(String(describing: state))' in 'GestureBaseButtonGestureState.init(state:)'")
                return .possible
            }
        }()
    }
    
#endif
}

#if !os(watchOS)

#if canImport(UIKit)
public import UIKit
#elseif canImport(AppKit)
public import AppKit
#endif

final class GestureBaseButtonModel {
    private let outOfBoundsMaxOffsetToRegisterGesture: CGFloat = 10
    
    private var centerLocationOnSuperViewInitial: CGPoint?
    private let centerLocationMaxOffsetToRegisterGesture: CGFloat = 5
    
    private let stateSetter: (GestureRecognizerState) -> Void
    
    init(
        stateSetter: @escaping (GestureRecognizerState) -> Void
    ) {
        self.stateSetter = stateSetter
    }
    
    func began(
        centerLocationOnSuperView: CGPoint?
    ) -> GestureRecognizerState {
        self.centerLocationOnSuperViewInitial = centerLocationOnSuperView
        
        return .began
    }
    
    func changed(
        viewSize: CGSize,
        centerLocationOnSuperView: CGPoint?,
        location: CGPoint?
    ) -> GestureRecognizerState? {
        guard
            let location,
            location.isOn(viewSize, offset: outOfBoundsMaxOffsetToRegisterGesture),
            gestureViewLocationIsUnchanged(centerLocationOnSuperView) == true
        else {
            defer { zeroData() }
            
            setStateToPossibleOnNextRunLoop()
            return .cancelled
        }
        
        //state = .changed // Not needed
        return nil
    }
    
    func ended(
        centerLocationOnSuperView: CGPoint?
    ) -> GestureRecognizerState {
        defer { zeroData() }
        
        setStateToPossibleOnNextRunLoop()
        if gestureViewLocationIsUnchanged(centerLocationOnSuperView) == true {
            return .ended
        } else {
            return .cancelled
        }
    }
    
    func cancelled() -> GestureRecognizerState {
        defer { zeroData() }
        
        setStateToPossibleOnNextRunLoop()
        return .cancelled
    }
    
    private func zeroData() {
        centerLocationOnSuperViewInitial = nil
    }
    
    private func setStateToPossibleOnNextRunLoop() {
        Task {
            stateSetter(.possible)
        }
    }
    
    private func gestureViewLocationIsUnchanged(
        _ centerLocationOnSuperView: CGPoint?
    ) -> Bool? {
        guard
            let initial = centerLocationOnSuperViewInitial,
            let final: CGPoint = centerLocationOnSuperView
        else {
            return nil
        }
        
        return final.equals(
            initial,
            tolerance: centerLocationMaxOffsetToRegisterGesture
        )
    }
    
#if canImport(UIKit)
    typealias GestureRecognizerState = UIGestureRecognizer.State
#elseif canImport(AppKit)
    typealias GestureRecognizerState = NSGestureRecognizer.State
#endif
}

nonisolated extension CGPoint {
    fileprivate func equals(_ other: CGPoint, tolerance: CGFloat) -> Bool {
        areEqual(x, other.x, tolerance: tolerance) &&
        areEqual(y, other.y, tolerance: tolerance)
    }
}

nonisolated extension CGPoint {
    fileprivate func isOn(_ size: CGSize, offset: CGFloat) -> Bool {
        let xIsOnTarget: Bool = {
            let isPositive: Bool = x >= 0
            
            if isPositive {
                return x <= size.width + offset
            } else {
                return x >= -offset
            }
        }()
        
        let yIsOnTarget: Bool = {
            let isPositive: Bool = y >= 0
            
            if isPositive {
                return y <= size.height + offset
            } else {
                return y >= -offset
            }
        }()
        
        return xIsOnTarget && yIsOnTarget
    }
}

#endif

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

public import AppKit

final class AppKitBaseButtonGestureRecognizer: NSGestureRecognizer, NSGestureRecognizerDelegate {
    override var state: NSGestureRecognizer.State {
        get { super.state }
        set {
            guard newValue != .changed else { return } // Not used
            
            super.state = newValue
            onStateChange(GestureBaseButtonGestureState(state: newValue))
        }
    }
    private var onStateChange: (GestureBaseButtonGestureState) -> Void
    
    private lazy var model: GestureBaseButtonModel = .init(
        stateSetter: { [weak self] in self?.state = $0 }
    )
    
    init(
        onStateChange: @escaping (GestureBaseButtonGestureState) -> Void
    ) {
        self.onStateChange = onStateChange
        
        super.init(target: nil, action: nil)
        
        delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setOnStateChange(
        to onStateChange: @escaping (GestureBaseButtonGestureState) -> Void
    ) {
        self.onStateChange = onStateChange
    }
    
    override func mouseDown(with event: NSEvent) {
        guard let view else { return }
        
        state = model.began(
            centerLocationOnSuperView: view.centerLocationOnSuperView
        )
    }
    
    override func mouseDragged(with event: NSEvent) {
        guard let view else { return }
        
        if let state = model.changed(
            viewSize: view.frame.size,
            centerLocationOnSuperView: view.centerLocationOnSuperView,
            location: location(in: view)
        ) {
            self.state = state
        }
    }
    
    override func mouseUp(with event: NSEvent) {
        guard let view else { return }
        
        state = model.ended(
            centerLocationOnSuperView: view.centerLocationOnSuperView
        )
    }
    
    func gestureRecognizer(
        _ gestureRecognizer: NSGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: NSGestureRecognizer
    ) -> Bool {
        true
    }
}

extension NSView {
    fileprivate var centerLocationOnSuperView: CGPoint? {
        superview?.convert(center, to: nil)
    }
    
    private var center: CGPoint {
        .init(
            x: frame.origin.x + frame.size.width/2,
            y: frame.origin.y + frame.size.height/2
        )
    }
}

#endif

#if canImport(UIKit) && !os(watchOS)

public import UIKit

@available(tvOS, unavailable)
final class UIKitBaseButtonGestureRecognizer: UIGestureRecognizer, UIGestureRecognizerDelegate {
    override var state: UIGestureRecognizer.State {
        get { super.state }
        set {
            guard newValue != .changed else { return } // Not used
            
            super.state = newValue
            onStateChange(GestureBaseButtonGestureState(state: newValue))
        }
    }
    private var onStateChange: (GestureBaseButtonGestureState) -> Void
    
    private lazy var model: GestureBaseButtonModel = .init(
        stateSetter: { [weak self] in self?.state = $0 }
    )
    
    init(
        onStateChange: @escaping (GestureBaseButtonGestureState) -> Void
    ) {
        self.onStateChange = onStateChange
        
        super.init(target: nil, action: nil)
        
        delegate = self
    }
    
    func setOnStateChange(
        to onStateChange: @escaping (GestureBaseButtonGestureState) -> Void
    ) {
        self.onStateChange = onStateChange
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        guard let view else { return }
        
        state = model.began(
            centerLocationOnSuperView: view.centerLocationOnSuperView
        )
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        guard let view else { return }
        
        if let state = model.changed(
            viewSize: view.frame.size,
            centerLocationOnSuperView: view.centerLocationOnSuperView,
            location: location(in: view)
        ) {
            self.state = state
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        guard let view else { return }
        
        state = model.ended(
            centerLocationOnSuperView: view.centerLocationOnSuperView
        )
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        state = model.cancelled()
    }
    
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        true
    }
}

extension UIView {
    fileprivate var centerLocationOnSuperView: CGPoint? {
        superview?.convert(center, to: nil)
    }
}

#endif

@available(*, deprecated, message: "Will be removed in '9.0.0'")
@available(tvOS, unavailable) // No `UIKitBaseButtonGestureRecognizer`
@available(watchOS, unavailable) // No `UIKitBaseButtonGestureRecognizer`
public struct SwiftUIGestureBaseButton<Label>: View where Label: View {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    private var onStateChange: (GestureBaseButtonGestureState) -> Void
    
    private let label: () -> Label
    
    public init(
        onStateChange: @escaping (GestureBaseButtonGestureState) -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.onStateChange = onStateChange
        self.label = label
    }

    public init(
        action: @escaping () -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.onStateChange = { gestureState in
            if gestureState.didRecognizeClick { action() }
        }
        self.label = label
    }
    
    public var body: some View {
#if canImport(UIKit) && !os(watchOS)
        label()
            .overlay {
                SwiftUIGestureBaseButton_UIKit(
                    isEnabled: isEnabled,
                    onStateChange: onStateChange
                )
            }
#elseif canImport(AppKit)
        label()
            .overlay {
                SwiftUIGestureBaseButton_AppKit(
                    isEnabled: isEnabled,
                    onStateChange: onStateChange
                )
            }
#endif
    }
}

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

public import SwiftUI

struct SwiftUIGestureBaseButton_AppKit: NSViewRepresentable {
    private let isEnabled: Bool
    private let onStateChange: (GestureBaseButtonGestureState) -> Void
    
    @State private var gestureRecognizer: AppKitBaseButtonGestureRecognizer?
    
    init(
        isEnabled: Bool,
        onStateChange: @escaping (GestureBaseButtonGestureState) -> Void
    ) {
        self.isEnabled = isEnabled
        self.onStateChange = onStateChange
    }
    
    func makeNSView(context: Context) -> NSView {
        let view: NSView = .init(frame: .zero)
        
        Task {
            let gestureRecognizer: AppKitBaseButtonGestureRecognizer = .init(onStateChange: onStateChange)
            self.gestureRecognizer = gestureRecognizer
            
            view.addGestureRecognizer(gestureRecognizer)
        }
        
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
        guard let gestureRecognizer else { return }
        
        gestureRecognizer.setOnStateChange(to: onStateChange)
        gestureRecognizer.isEnabled = isEnabled
    }
}

#endif

#if canImport(UIKit) && !os(watchOS)

public import SwiftUI

@available(tvOS, unavailable)
struct SwiftUIGestureBaseButton_UIKit: UIViewRepresentable {
    private let isEnabled: Bool
    private let onStateChange: (GestureBaseButtonGestureState) -> Void
    
    @State private var gestureRecognizer: UIKitBaseButtonGestureRecognizer?
    
    init(
        isEnabled: Bool,
        onStateChange: @escaping (GestureBaseButtonGestureState) -> Void
    ) {
        self.isEnabled = isEnabled
        self.onStateChange = onStateChange
    }
    
    func makeUIView(context: Context) -> UIView {
        let view: UIView = .init(frame: .zero)
        
        Task {
            let gestureRecognizer: UIKitBaseButtonGestureRecognizer = .init(onStateChange: onStateChange)
            self.gestureRecognizer = gestureRecognizer
            
            view.addGestureRecognizer(gestureRecognizer)
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        guard let gestureRecognizer else { return }
        
        gestureRecognizer.setOnStateChange(to: onStateChange)
        gestureRecognizer.isEnabled = isEnabled
    }
}

#endif

#if canImport(UIKit) && !os(watchOS)

public import UIKit

@available(*, deprecated, message: "Will be removed in '9.0.0'")
@available(tvOS, unavailable)
open class UIKitBaseButton: UIView {
    private lazy var gestureRecognizer: UIKitBaseButtonGestureRecognizer = .init(onStateChange: { [weak self] gestureState in
        guard let self else { return }
        
        internalButtonState = .init(isEnabled: buttonState.isGestureEnabled, isPressed: gestureState.didRecognizeClick)
        onStateChange(gestureState)
    })
    
    open var isEnabled: Bool {
        get {
            internalButtonState.isGestureEnabled
        }
        set {
            internalButtonState = UIKitBaseButtonInternalState(isEnabled: newValue, isPressed: false)
            gestureRecognizer.isEnabled = internalButtonState.isGestureEnabled
        }
    }
    
    open var buttonState: UIKitBaseButtonState {
        switch internalButtonState {
        case .enabled: .enabled
        case .pressed: .enabled
        case .disabled: .disabled
        }
    }
    
    open private(set) var internalButtonState: UIKitBaseButtonInternalState = .enabled
    
    open var onStateChange: (GestureBaseButtonGestureState) -> Void
    
    public init(
        onStateChange: @escaping (GestureBaseButtonGestureState) -> Void
    ) {
        self.onStateChange = onStateChange
        super.init(frame: .zero)
        setUp()
    }
    
    public convenience init(
        action: @escaping () -> Void
    ) {
        self.init(onStateChange: { gestureState in
            if gestureState.didRecognizeClick { action() }
        })
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUp() {
        setUpView()
        addGestureRecognizer(gestureRecognizer)
    }
    
    private func setUpView() {
        backgroundColor = .clear
    }
    
    open func configure(state: UIKitBaseButtonState) {
        internalButtonState = UIKitBaseButtonInternalState(isEnabled: state.isGestureEnabled, isPressed: internalButtonState == .pressed)
        gestureRecognizer.isEnabled = internalButtonState.isGestureEnabled
    }
}

@available(tvOS, unavailable)
nonisolated extension UIKitBaseButtonState {
    fileprivate var isGestureEnabled: Bool {
        switch self {
        case .enabled: true
        case .disabled: false
        }
    }
}

@available(tvOS, unavailable)
nonisolated extension UIKitBaseButtonInternalState {
    fileprivate var isGestureEnabled: Bool {
        switch self {
        case .enabled: true
        case .pressed: true
        case .disabled: false
        }
    }
}

#endif

#if canImport(UIKit) && !os(watchOS)

@available(*, deprecated, message: "Will be removed in '9.0.0'")
@available(tvOS, unavailable)
public typealias UIKitBaseButtonState = GenericState_EnabledDisabled

@available(*, deprecated, message: "Will be removed in '9.0.0'")
@available(tvOS, unavailable)
public typealias UIKitBaseButtonInternalState = GenericState_EnabledPressedDisabled

#endif

#if canImport(UIKit) && !os(watchOS)

public import UIKit
import Combine

@available(*, deprecated, message: "Will be removed in '9.0.0'")
@available(tvOS, unavailable)
open class KeyboardResponsiveUIViewController: UIViewController {
    open var notifiesWhenKeyboardIsAlreadyShownOrHidden: Bool = true
    
    open var notifiesWhenViewControllerIsNotVisible: Bool = false
    
    open private(set) var keyboardIsShown: Bool = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        addKeyboardFrameChangNotificationObserver()
    }
    
    private func addKeyboardFrameChangNotificationObserver() {
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .sink { [weak self] in self?.keyboardWillShow(notification: $0) }
            .store(in: &cancellables)
        
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { [weak self] in self?.keyboardWillHide(notification: $0) }
            .store(in: &cancellables)
    }
    
    open func keyboardWillShow(_ systemKeyboardInfo: SystemKeyboardInfo) {}

    open func keyboardWillHide(_ systemKeyboardInfo: SystemKeyboardInfo) {}

    private func keyboardWillShow(notification: Notification) {
        if !notifiesWhenKeyboardIsAlreadyShownOrHidden {
            guard !keyboardIsShown else { return }
        }
        keyboardIsShown = true
        
        if !notifiesWhenViewControllerIsNotVisible {
            guard viewIsVisible else { return }
        }
        
        keyboardWillShow(SystemKeyboardInfo(notification: notification))
    }
    
    private func keyboardWillHide(notification: Notification) {
        if !notifiesWhenKeyboardIsAlreadyShownOrHidden {
            guard keyboardIsShown else { return }
        }
        keyboardIsShown = false
        
        if !notifiesWhenViewControllerIsNotVisible {
            guard viewIsVisible else { return }
        }
        
        keyboardWillHide(SystemKeyboardInfo(notification: notification))
    }
    
    private var viewIsVisible: Bool {
        isViewLoaded &&
        view.window != nil &&
        !isBeingDismissed
    }
}

#endif

#if canImport(UIKit) && !os(watchOS)

public import SwiftUI
import OSLog

@available(*, deprecated, message: "Will be removed in '9.0.0'")
@available(tvOS, unavailable)
extension UIView {
    public class func animateKeyboardResponsiveness(
        systemKeyboardInfo: SystemKeyboardInfo,
        animations: @escaping () -> Void,
        completion: ((Bool) -> Void)? = nil
    ) {
        UIView.animate(
            withDuration: systemKeyboardInfo.nonZeroAnimationDuration,
            delay: 0,
            options: systemKeyboardInfo.animationOptions,
            animations: animations,
            completion: completion
        )
    }
}

@available(*, deprecated, message: "Will be removed in '9.0.0'")
@available(tvOS, unavailable)
extension UIView {
    public class func animateKeyboardResponsivenessByUnObscuringFirstResponderView(
        keyboardWillShow: Bool,
        firstResponderView: UIView,
        containerView: UIView,
        systemKeyboardInfo: SystemKeyboardInfo,
        additionalOffset: CGFloat = 20,
        completion: ((Bool) -> Void)? = nil
    ) {
        if keyboardWillShow {
            guard let window: UIWindow = firstResponderView.window else {
                Logger.keyboardResponsiveUIViewController.error("Failed to retrieve 'UIWindow' from 'UIView': \(firstResponderView)")
                return
            }
            let windowHeight: CGFloat = window.frame.size.height

            guard let firstResponderViewSuperView: UIView = firstResponderView.superview else {
                Logger.keyboardResponsiveUIViewController.error("Failed to retrieve superview from 'UIView': \(firstResponderView)")
                return
            }
            
            let viewGlobalFrameMaxY: CGFloat = firstResponderViewSuperView.convert(firstResponderView.frame, to: nil).maxY

            let containerViewY: CGFloat = containerView.bounds.origin.y

            guard let systemKeyboardHeight: CGFloat = systemKeyboardInfo.frame?.size.height else {
                Logger.keyboardResponsiveUIViewController.error("Failed to retrieve system keyboard height from 'Notification'")
                return
            }

            let viewDistanceToBottom: CGFloat = windowHeight - viewGlobalFrameMaxY - containerViewY
            
            let obscuredHeight: CGFloat = max(0, systemKeyboardHeight + additionalOffset - viewDistanceToBottom)

            UIView.animateKeyboardResponsiveness(
                systemKeyboardInfo: systemKeyboardInfo,
                animations: {
                    containerView.bounds.origin.y = obscuredHeight
                    
                    firstResponderView.superview?.layoutIfNeeded()
                    containerView.superview?.layoutIfNeeded()
                },
                completion: completion
            )
            
        } else {
            UIView.animateKeyboardResponsiveness(
                systemKeyboardInfo: systemKeyboardInfo,
                animations: {
                    containerView.bounds.origin.y = 0
                    
                    //firstResponderView.superview?.layoutIfNeeded() // Unnecessary
                    containerView.superview?.layoutIfNeeded()
                },
                completion: completion
            )
        }
    }
}

#endif

#if canImport(UIKit) && !os(watchOS)

public import UIKit

@available(*, deprecated, message: "Will be removed in '9.0.0'")
@available(tvOS, unavailable)
open class FirstResponderViewUnObscuringUIViewController: KeyboardResponsiveUIViewController {
    open lazy var keyboardResponsivenessContainerView: UIView = view
    
    open var keyboardResponsivenessFirstResponderAdditionalOffset: CGFloat = 20

    override open func keyboardWillShow(_ systemKeyboardInfo: SystemKeyboardInfo) {
        super.keyboardWillShow(systemKeyboardInfo)
        
        guard let firstResponderSubview: UIView = view.childFirstResponderView else { return }
        
        UIView.animateKeyboardResponsivenessByUnObscuringFirstResponderView(
            keyboardWillShow: true,
            firstResponderView: firstResponderSubview,
            containerView: keyboardResponsivenessContainerView,
            systemKeyboardInfo: systemKeyboardInfo,
            additionalOffset: keyboardResponsivenessFirstResponderAdditionalOffset
        )
    }
    
    override open func keyboardWillHide(_ systemKeyboardInfo: SystemKeyboardInfo) {
        super.keyboardWillHide(systemKeyboardInfo)
        
        guard let firstResponderSubview: UIView = view.childFirstResponderView else { return }
        
        UIView.animateKeyboardResponsivenessByUnObscuringFirstResponderView(
            keyboardWillShow: false,
            firstResponderView: firstResponderSubview,
            containerView: keyboardResponsivenessContainerView,
            systemKeyboardInfo: systemKeyboardInfo,
            additionalOffset: keyboardResponsivenessFirstResponderAdditionalOffset
        )
    }
}

#endif

#if canImport(UIKit) && !os(watchOS)

public import UIKit

@available(*, deprecated, message: "Will be removed in '9.0.0'")
public protocol StandardNavigable {
    func push(_ viewController: UIViewController, animated: Bool)
    func pop(animated: Bool)
    func pop(count: Int, animated: Bool)
    func popToRoot(animated: Bool)
    func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    func dismiss(animated: Bool, completion: (() -> Void)?)
    func setRoot(to viewController: UIViewController)
}

extension StandardNavigable {
    public func push(_ viewController: UIViewController) {
        push(viewController, animated: true)
    }
    
    public func pop() {
        pop(animated: true)
    }

    public func pop(count: Int) {
        pop(count: count, animated: true)
    }
    
    public func popToRoot() {
        popToRoot(animated: true)
    }
    
    public func present(_ viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    public func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}

extension StandardNavigable where Self: UIViewController {
    public func push(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    public func pop(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
    
    public func pop(count: Int, animated: Bool) {
        guard let navigationController else { return }
        
        let viewControllers: [UIViewController] = navigationController.viewControllers
        guard viewControllers.count >= (count + 1) else { return }
        
        navigationController.popToViewController(viewControllers[(viewControllers.count-1) - count], animated: animated)
    }
    
    public func popToRoot(animated: Bool) {
        navigationController?.popToRootViewController(animated: animated)
    }
    
    public func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        (self as UIViewController).present(viewController, animated: animated, completion: completion)
    }

    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        (self as UIViewController).dismiss(animated: animated, completion: completion)
    }
}

#endif

#if canImport(UIKit) && !os(watchOS)

public import UIKit

@available(*, deprecated, message: "Will be removed in '9.0.0'")
public protocol UIActivityIndicatorViewable {
    var activityIndicator: UIActivityIndicatorView { get }
    
    func startActivityIndicatorAnimation()
    func stopActivityIndicatorAnimation()
    func startActivityIndicatorAnimationAndDisableInteraction()
    func stopActivityIndicatorAnimationAndEnableInteraction()
}

extension UIActivityIndicatorViewable {
    public func startActivityIndicatorAnimation() {
        activityIndicator.startAnimating()
    }

    public func stopActivityIndicatorAnimation() {
        activityIndicator.stopAnimating()
    }
}

extension UIActivityIndicatorViewable where Self: UIView {
    public func startActivityIndicatorAnimationAndDisableInteraction() {
        startActivityIndicatorAnimation()
        isUserInteractionEnabled = false
    }
    
    public func stopActivityIndicatorAnimationAndEnableInteraction() {
        stopActivityIndicatorAnimation()
        isUserInteractionEnabled = true
    }
}

extension UIActivityIndicatorViewable where Self: UIViewController {
    public func startActivityIndicatorAnimationAndDisableInteraction() {
        startActivityIndicatorAnimation()
        view.isUserInteractionEnabled = false
    }
    
    public func stopActivityIndicatorAnimationAndEnableInteraction() {
        stopActivityIndicatorAnimation()
        view.isUserInteractionEnabled = true
    }
}

extension UIView {
    @available(*, deprecated, message: "Will be removed in '9.0.0'")
    public func initActivityIndicator(
        scalingFactor: CGFloat? = nil,
        color: UIColor? = nil
    ) -> UIActivityIndicatorView {
        let activityIndicator: UIActivityIndicatorView = .init()
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        scalingFactor.map { activityIndicator.transform = CGAffineTransform(scaleX: $0, y: $0) }
        color.map { activityIndicator.color = $0 }
        
        return activityIndicator
    }
}

extension UIViewController {
    @available(*, deprecated, message: "Will be removed in '9.0.0'")
    public func initActivityIndicator(
        scalingFactor: CGFloat? = nil,
        color: UIColor? = nil
    ) -> UIActivityIndicatorView {
        view.initActivityIndicator(scalingFactor: scalingFactor, color: color)
    }
}

#endif

#if canImport(UIKit) && !os(watchOS)

public import UIKit
import OSLog

@available(*, deprecated, message: "Will be removed in '9.0.0'")
public protocol UITableViewCellParameter {
    var reuseID: String { get }
}

@available(*, deprecated, message: "Will be removed in '9.0.0'")
public protocol ConfigurableUITableViewCell: UITableViewCell {
    static var reuseID: String { get }
    
    func configure(parameter: any UITableViewCellParameter)
}

@available(*, deprecated, message: "Will be removed in '9.0.0'")
nonisolated extension ConfigurableUITableViewCell {
    public static var reuseID: String { .init(describing: self) }
}

@available(*, deprecated, message: "Will be removed in '9.0.0'")
public protocol UITableViewDelegable {
    func tableViewDidSelectRow(section: Int, row: Int)
}

@available(*, deprecated, message: "Will be removed in '9.0.0'")
public protocol UITableViewDataSourceable {
    var tableViewNumberOfSections: Int { get }
    
    func tableViewNumberOfRows(section: Int) -> Int
    func tableViewCellParameter(section: Int, row: Int) -> any UITableViewCellParameter
}

extension UITableView {
    @available(*, deprecated, message: "Will be removed in '9.0.0'")
    public func register(_ cells: any ConfigurableUITableViewCell.Type...) {
        cells.forEach { register($0, forCellReuseIdentifier: $0.reuseID) }
    }
}

extension UITableView {
    @available(*, deprecated, message: "Will be removed in '9.0.0'")
    public func dequeueAndConfigureReusableCell(
        parameter: any UITableViewCellParameter
    ) -> UITableViewCell {
        guard
            let cell = dequeueReusableCell(withIdentifier: parameter.reuseID) as? any ConfigurableUITableViewCell
        else {
            Logger.misc.critical("Unable to dequeue 'ConfigurableUITableViewCell' with identifier '\(parameter.reuseID)' in 'UITableView.dequeueAndConfigureReusableCell(parameter:)'")
            return UITableViewCell()
        }
        
        cell.configure(parameter: parameter)
        
        return cell
    }
}

#endif

#if canImport(UIKit) && !os(watchOS)

public import UIKit
import OSLog

@available(*, deprecated, message: "Will be removed in '9.0.0'")
public protocol UICollectionViewCellParameter {
    var reuseID: String { get }
}

@available(*, deprecated, message: "Will be removed in '9.0.0'")
public protocol ConfigurableUICollectionViewCell: UICollectionViewCell {
    static var reuseID: String { get }
    
    func configure(parameter: any UICollectionViewCellParameter)
}

nonisolated extension ConfigurableUICollectionViewCell {
    public static var reuseID: String { .init(describing: self) }
}

@available(*, deprecated, message: "Will be removed in '9.0.0'")
public protocol UICollectionViewDelegable {
    func collectionViewDidSelectRow(section: Int, row: Int)
}

@available(*, deprecated, message: "Will be removed in '9.0.0'")
public protocol UICollectionViewDataSourceable {
    var collectionViewNumberOfSections: Int { get }
    
    func collectionViewNumberOfItems(section: Int) -> Int
    func collectionViewCellParameter(section: Int, row: Int) -> any UICollectionViewCellParameter
}

extension UICollectionView {
    @available(*, deprecated, message: "Will be removed in '9.0.0'")
    public func register(_ cells: any ConfigurableUICollectionViewCell.Type...) {
        cells.forEach { register($0, forCellWithReuseIdentifier: $0.reuseID) }
    }
}

extension UICollectionView {
    @available(*, deprecated, message: "Will be removed in '9.0.0'")
    public func dequeueAndConfigureReusableCell(
        indexPath: IndexPath,
        parameter: any UICollectionViewCellParameter
    ) -> UICollectionViewCell {
        guard
            let cell = dequeueReusableCell(withReuseIdentifier: parameter.reuseID, for: indexPath) as? any ConfigurableUICollectionViewCell
        else {
            Logger.misc.critical("Failed to dequeue 'ConfigurableUICollectionViewCell' with identifier '\(parameter.reuseID)' in 'UICollectionView.dequeueAndConfigureReusableCell(indexPath:parameter:)'")
            return UICollectionViewCell()
        }
        
        cell.configure(parameter: parameter)
        
        return cell
    }
}

#endif

#if canImport(UIKit) && !os(watchOS)

public import UIKit

@available(*, deprecated, message: "'UIAlertViewable' is no longer needed. Use 'UIViewController' method directly.")
public protocol UIAlertViewable {
    func presentAlert(parameters: UIAlertParameters)
}

#endif

#if canImport(UIKit) && !os(watchOS)

public import UIKit

@available(*, deprecated, message: "'UIActionSheetViewable' is no longer needed. Use 'UIViewController' method directly.")
public protocol UIActionSheetViewable {
    func presentActionSheet(parameters: UIActionSheetParameters)
}

#endif

@available(*, deprecated, message: "Use new formatting API")
nonisolated extension Double {
    public func rounded(
        minFractions: Int = 0,
        maxFractions: Int
    ) -> String? {
        AutoPrecisionNumberFormatter(minFractions: minFractions, maxFractions: maxFractions)
            .string(from: self)
    }
}

@available(*, deprecated, message: "Use new formatting API")
nonisolated public struct AutoPrecisionNumberFormatter: Sendable {
    public var minFractions: Int
    public var maxFractions: Int
    
    public init(
        minFractions: Int = 0,
        maxFractions: Int
    ) {
        self.minFractions = minFractions
        self.maxFractions = maxFractions
    }
    
    public func string(from number: Double) -> String? {
        guard minFractions >= 0 else {
            Logger.misc.critical("'minFractions' must be greater than or equal to '0' in 'AutoPrecisionNumberFormatter.string(from:)'")
            return nil
        }

        guard maxFractions >= 0 else {
            Logger.misc.critical("'maxFractions' must be greater than or equal to '0' in 'AutoPrecisionNumberFormatter.string(from:)'")
            return nil
        }

        guard maxFractions >= minFractions else {
            Logger.misc.critical("'maxFractions' must be greater than or equal to 'minFractions' in 'AutoPrecisionNumberFormatter.string(from:)'")
            return nil
        }

        let numberFormatter: NumberFormatter = .init()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = minFractions
        numberFormatter.maximumFractionDigits = maxFractions
        
        return numberFormatter.string(from: NSNumber(value: number))
    }
}

nonisolated extension ManagedTask {
    @available(*, deprecated, renamed: "reset(cancelForAllWaiters:)")
    public func cancel(
        forAllWaiters: Bool
    ) {
        reset(
            cancelForAllWaiters: forAllWaiters
        )
    }
}

nonisolated extension KeyedManagedTask {
    @available(*, deprecated, renamed: "reset(key:cancelForAllWaiters:)")
    public func cancel(
        key: Key,
        forAllWaiters: Bool
    ) {
        reset(
            key: key,
            cancelForAllWaiters: forAllWaiters
        )
    }
    
    @available(*, deprecated, renamed: "resetAll(cancelForAllWaiters:)")
    public func cancelAll(
        forAllWaiters: Bool
    ) {
        resetAll(
            cancelForAllWaiters: forAllWaiters
        )
    }
}

nonisolated extension CachedManagedTask {
    @available(*, deprecated, renamed: "reset(cancelForAllWaiters:clearCache:)")
    public func cancel(
        forAllWaiters: Bool,
        clearCache: Bool
    ) {
        reset(
            cancelForAllWaiters: forAllWaiters,
            clearCache: clearCache
        )
    }
}

nonisolated extension CachedKeyedManagedTask {
    @available(*, deprecated, renamed: "reset(key:cancelForAllWaiters:clearCache:)")
    public func cancel(
        key: Key,
        forAllWaiters: Bool,
        clearCache: Bool
    ) {
        reset(
            key: key,
            cancelForAllWaiters: forAllWaiters,
            clearCache: clearCache
        )
    }
    
    @available(*, deprecated, renamed: "resetAll(cancelForAllWaiters:clearCache:)")
    public func cancelALL(
        forAllWaiters: Bool,
        clearCache: Bool
    ) {
        resetAll(
            cancelForAllWaiters: forAllWaiters,
            clearCache: clearCache
        )
    }
}

nonisolated extension URL {
    @available(*, deprecated, message: "Will be removed in '9.0.0'")
    public init?(
        string: String,
        pathParameters: [String],
        queryParameters: [(key: String, value: String)]
    ) {
        var string = string
        if string.hasSuffix("/") { _ = string.removeLast() }

        guard !string.isEmpty else { return nil }

        pathParameters.forEach { string.append("/\($0)") }

        guard var urlComponents: URLComponents = .init(string: string) else { return nil }
        urlComponents.addQueryItems(queryParameters)

        guard let url: URL = urlComponents.url else { return nil }

        self = url
    }
}

nonisolated extension URLComponents {
    fileprivate mutating func addQueryItems(
        _ newQueryItems: [(key: String, value: String)]
    ) {
        guard !newQueryItems.isEmpty else { return }

        let newURLQueryItems: [URLQueryItem] = newQueryItems.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }

        if queryItems == nil {
            queryItems = newURLQueryItems
        } else {
            queryItems?.append(contentsOf: newURLQueryItems)
        }
    }
}
