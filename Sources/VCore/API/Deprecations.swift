//
//  Deprecations.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import SwiftUI

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import AppKit

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

import UIKit

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

#if canImport(UIKit) && !os(watchOS)

import UIKit

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
import UIKit
#elseif canImport(AppKit)
import AppKit
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
import UIKit
#elseif canImport(AppKit)
import AppKit
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

import AppKit

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

import UIKit

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

import SwiftUI

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

import SwiftUI

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

import UIKit

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

nonisolated extension UIKitBaseButtonState {
    fileprivate var isGestureEnabled: Bool {
        switch self {
        case .enabled: true
        case .disabled: false
        }
    }
}

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
