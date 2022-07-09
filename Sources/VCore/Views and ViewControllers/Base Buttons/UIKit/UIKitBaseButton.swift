//
//  UIKitBaseButton.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

#if os(iOS)

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
///     struct SomeButtonUIModel {
///         var colors: Colors = .init()
///
///         struct Colors {
///             var title: StateColors = .init(
///                 enabled: .black,
///                 pressed: .gray,
///                 disabled: .gray
///             )
///
///             typealias StateColors = GenericStateModel_EnabledPressedDisabled<UIColor?>
///         }
///     }
///
/// State:
///
///     typealias SomeButtonState = GenericState_EnabledDisabled
///
///     typealias SomeButtonInternalState = GenericState_EnabledPressedDisabled
///
/// Button:
///
///     final class SomeButton: UIView {
///         // Action is passed during configuration
///         private lazy var baseButton: UIKitBaseButton = .init(action: configureFromStateModelChange)
///             .withTranslatesAutoresizingMaskIntoConstraints(false)
///
///         private let titleLabel: UILabel = {
///             let label: UILabel = .init()
///             label.translatesAutoresizingMaskIntoConstraints = false
///             label.isUserInteractionEnabled = false
///             label.textAlignment = .center
///             return label
///         }()
///
///         private var uiModel: SomeButtonUIModel
///
///         var state: SomeButtonState { .init(isEnabled: internalState.isEnabled) }
///         private var internalState: SomeButtonInternalState = .enabled
///             { didSet { baseButton.isEnabled = internalState.isEnabled } }
///
///         init(
///             uiModel: SomeButtonUIModel = .init(),
///             action: @escaping () -> Void,
///             title: String
///         ) {
///             self.uiModel = uiModel
///             super.init(frame: .zero)
///             setUp()
///             configure(uiModel: uiModel)
///             configure(action: action)
///             configure(title: title)
///         }
///
///         required init?(coder: NSCoder) {
///             fatalError()
///         }
///
///         private func setUp() {
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
///         }
///
///         func configure(uiModel: SomeButtonUIModel) {
///             self.uiModel = uiModel
///
///             configureFromStateModelChange()
///         }
///
///         func configure(state: SomeButtonState) {
///             internalState = .init(isEnabled: state.isEnabled, isPressed: baseButton.internalButtonState == .pressed)
///
///             configureFromStateModelChange()
///         }
///
///         func configure(action: @escaping () -> Void) {
///             baseButton.gestureHandler = { [weak self] gestureState in
///                 guard let self = self else { return }
///
///                 self.internalState = .init(isEnabled: self.state.isEnabled, isPressed: gestureState.isPressed)
///
///                 self.configureFromStateModelChange()
///                 if gestureState.isClicked { action() }
///             }
///         }
///
///         func configure(title: String) {
///             titleLabel.text = title
///         }
///
///         private func configureFromStateModelChange() {
///             titleLabel.textColor = uiModel.colors.title.value(for: internalState)
///         }
///     }
///
///     let button: SomeButton = .init(
///         action: { print("Clicked") },
///         title: "Lorem Ipsum"
///     ).withTranslatesAutoresizingMaskIntoConstraints(false)
///
open class UIKitBaseButton: UIView {
    // MARK: Properties
    private lazy var gestureRecognizer: BaseButtonTapGestureRecognizer = .init(
        gesture: { [weak self] gestureState in
            guard let self = self else { return }
            
            self.internalButtonState = .init(isEnabled: self.buttonState.isEnabled, isPressed: gestureState.isPressed)
            self.gestureHandler(gestureState)
        }
    )
    
    open var isEnabled: Bool {
        get {
            internalButtonState.isEnabled
        }
        set {
            internalButtonState = .init(isEnabled: newValue)
            gestureRecognizer.isEnabled = internalButtonState.isEnabled
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
    open func configure(state: UIKitBaseButtonState) {
        internalButtonState = .init(isEnabled: state.isEnabled, isPressed: internalButtonState == .pressed)
        gestureRecognizer.isEnabled = internalButtonState.isEnabled
    }
}

#endif
