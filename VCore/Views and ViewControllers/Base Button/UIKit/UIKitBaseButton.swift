//
//  UIKitBaseButton.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

import UIKit

// MARK: - UIKit Base Button
/// A `UIKit` `UIView` that can be used as a base for all interactive views and buttons.
///
/// One implementation of `UIKitBaseButton` is using it as a base for another button.
/// In this case, `UIKitBaseButton` would handle state and clicks on it's own,
/// allowing a custom button to focus on UI and API.
///
/// Model:
///
///     struct SomeButtonModel {
///         static let titleColor: StateColors = .init(
///             enabled: .black,
///             pressed: .gray,
///             disabled: .gray
///         )
///
///         private init() {}
///
///         typealias StateColors = GenericStateModel_EPD<UIColor?>
///     }
///
/// State:
///
///     public enum SomeButtonState {
///         case enabled
///         case disabled
///
///         init(internalState: SomeButtonInternalState) {
///             switch internalState {
///             case .enabled: self = .enabled
///             case .pressed: self = .enabled
///             case .disabled: self = .disabled
///             }
///         }
///     }
///
///     enum SomeButtonInternalState {
///         case enabled
///         case pressed
///         case disabled
///
///         var isUserInteractionEnabled: Bool {
///             switch self {
///             case .enabled: return true
///             case .pressed: return true
///             case .disabled: return false
///             }
///         }
///
///         init(state: SomeButtonState, isPressed: Bool) {
///             switch (state, isPressed) {
///             case (.enabled, false): self = .enabled
///             case (.enabled, true): self = .pressed
///             case (.disabled, _): self = .disabled
///             }
///         }
///
///         static var `default`: Self { .enabled }
///     }
///
/// State-Model Mapping:
///
///     extension GenericStateModel_EPD {
///         func `for`(_ state: SomeButtonInternalState) -> Value {
///             switch state {
///             case .enabled: return enabled
///             case .pressed: return pressed
///             case .disabled: return disabled
///             }
///         }
///     }
///
/// Button:
///
///     public final class SomeButton: UIView {
///         private lazy var baseButton: UIKitBaseButton = {
///             let button: UIKitBaseButton = .init(gesture: { [weak self] gestureState in
///                 guard let self = self else { return }
///
///                 self.internalState = .init(state: self.state, isPressed: gestureState.isPressed)
///                 self.configureFromStateModelChange()
///                 if gestureState.isClicked { self.action() }
///             })
///             button.translatesAutoresizingMaskIntoConstraints = false
///             return button
///         }()
///
///         private let titleLabel: UILabel = {
///             let label: UILabel = .init()
///             label.translatesAutoresizingMaskIntoConstraints = false
///             label.isUserInteractionEnabled = false
///             label.textAlignment = .center
///             return label
///         }()
///
///         private typealias Model = SomeButtonModel
///
///         var state: SomeButtonState { .init(internalState: internalState) }
///         private var internalState: SomeButtonInternalState = .default
///         public override var isUserInteractionEnabled: Bool {
///             get {
///                 internalState.isUserInteractionEnabled
///             }
///             set {
///                 baseButton.isUserInteractionEnabled = newValue
///                 internalState = .init(state: state, isPressed: baseButton.buttonState == .pressed)
///                 configureFromStateModelChange()
///             }
///         }
///
///         private let action: () -> Void
///
///         var title: String {
///             get { titleLabel.text ?? "" }
///             set { titleLabel.text = newValue }
///         }
///
///         public init(
///             action: @escaping () -> Void,
///             title: String
///         ) {
///             self.action = action
///
///             super.init(frame: .zero)
///
///             self.title = title
///
///             backgroundColor = .clear
///
///             addSubview(baseButton)
///             addSubview(titleLabel)
///
///             NSLayoutConstraint.activate([
///                 baseButton.leadingAnchor.constraint(equalTo: leadingAnchor),
///                 baseButton.trailingAnchor.constraint(equalTo: trailingAnchor),
///                 baseButton.topAnchor.constraint(equalTo: topAnchor),
///                 baseButton.bottomAnchor.constraint(equalTo: bottomAnchor),
///
///                 titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
///                 titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
///                 titleLabel.topAnchor.constraint(equalTo: topAnchor),
///                 titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
///             ])
///
///             configureFromStateModelChange()
///         }
///
///         required init?(coder: NSCoder) {
///             fatalError()
///         }
///
///         func configure(with state: SomeButtonState) {
///             self.internalState = .init(state: state, isPressed: baseButton.internalButtonState == .pressed)
///
///             configureFromStateModelChange()
///         }
///
///         private func configureFromStateModelChange() {
///             print(internalState)
///             titleLabel.textColor = Model.titleColor.for(internalState)
///         }
///     }
///
/// Usage Example:
///
///     let button: SomeButton = {
///         let button: SomeButton = .init(
///             action: { print("Clicked") },
///             title: "Lorem Ipsum"
///         )
///         button.translatesAutoresizingMaskIntoConstraints = false
///         return button
///     }()
///
open class UIKitBaseButton: UIView {
    // MARK: Properties
    private lazy var gestureRecognizer: BaseButtonTapGestureRecognizer = .init(
        gesture: { [weak self] gestureState in
            guard let self = self else { return }
            
            self.internalButtonState = .init(state: self.buttonState, isPressed: gestureState.isPressed)
            self.gestureHandler(gestureState)
        }
    )
    
    open override var isUserInteractionEnabled: Bool {
        get {
            gestureRecognizer.isEnabled
        }
        set {
            internalButtonState = .init(isUserInteractionEnabled: newValue)
            gestureRecognizer.isEnabled = internalButtonState.isUserInteractionEnabled
        }
    }
    
    /// Button state.
    open var buttonState: UIKitBaseButtonState { .init(internalState: internalButtonState) }
    
    /// Internal button state.
    private(set) open var internalButtonState: UIKitBaseButtonInternalState = .default
    
    /// Gesture handler that return `BaseButtonGestureState`.
    open var gestureHandler: (BaseButtonGestureState) -> Void
    
    // MARK: Initializers
    /// Initializes `UIKitBaseButton` with gestureHandler.
    public init(
        gesture gestureHandler: @escaping (BaseButtonGestureState) -> Void
    ) {
        self.gestureHandler = gestureHandler
        super.init(frame: .zero)
    }
    
    /// Initializes `UIKitBaseButton` with action.
    public convenience init(
        action: @escaping () -> Void
    ) {
        self.init(gesture: { gestureState in
            if gestureState.isClicked { action() }
        })
    }
    
    required public init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Lifecycle
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setUp()
    }
    
    // MARK: Setup
    private func setUp() {
        setUpView()
        addGestureRecognizer(gestureRecognizer)
    }
    
    private func setUpView() {
        backgroundColor = .clear
    }
    
    // MARK: Configuration - State
    /// Configures `UIKitBaseButton` with state.
    open func configure(with state: UIKitBaseButtonState) {
        internalButtonState = .init(state: state, isPressed: internalButtonState == .pressed)
        gestureRecognizer.isEnabled = internalButtonState.isUserInteractionEnabled
    }
}
