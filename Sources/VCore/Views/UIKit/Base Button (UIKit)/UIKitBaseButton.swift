//
//  UIKitBaseButton.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - UI Kit Base Button
/// `UIKit` `UIView` that can be used as a base for all interactive views and buttons.
///
/// `UIKitBaseButton` can be used as a basis for all interactive UI components.
///
/// Model:
///
///     struct SomeButtonUIModel {
///         var titleColors: StateColors = .init(
///             enabled: UIColor.label,
///             pressed: UIColor.secondaryLabel,
///             disabled: UIColor.secondaryLabel
///         )
///
///         typealias StateColors = GenericStateModel_EnabledPressedDisabled<UIColor>
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
///         private lazy var baseButton: UIKitBaseButton = .init(action: { [weak self] in self?.configureFromStateUIModelChange() })
///             .withTranslatesAutoresizingMaskIntoConstraints(false)
///
///         private let titleLabel: UILabel = {
///             let label: UILabel = .init()
///             label.translatesAutoresizingMaskIntoConstraints = false
///             label.textAlignment = .center
///             return label
///         }()
///
///         private var uiModel: SomeButtonUIModel
///
///         var isEnabled: Bool {
///             get { internalState.isGestureEnabled }
///             set { configure(state: SomeButtonState(isEnabled: newValue)) }
///         }
///         var state: SomeButtonState { .init(isEnabled: internalState.isGestureEnabled) }
///         private var internalState: SomeButtonInternalState = .enabled
///             { didSet { baseButton.isEnabled = internalState.isGestureEnabled } }
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
///         @available(*, unavailable)
///         required init?(coder: NSCoder) {
///             fatalError()
///         }
///
///         private func setUp() {
///             addSubview(baseButton)
///             addSubview(titleLabel)
///
///             NSLayoutConstraint.activate([
///                 baseButton.leadingAnchor.constraint(equalTo: leadingAnchor),
///                 baseButton.trailingAnchor.constraint(equalTo: trailingAnchor),
///                 baseButton.topAnchor.constraint(equalTo: topAnchor),
///                 baseButton.bottomAnchor.constraint(equalTo: bottomAnchor),
///
///                 titleLabel.constraintHeight(to: nil, constant: titleLabel.singleLineHeight),
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
///             configureFromStateUIModelChange()
///         }
///
///         func configure(state: SomeButtonState) {
///             internalState = SomeButtonInternalState(isEnabled: state.isGestureEnabled, isPressed: baseButton.internalButtonState == .pressed)
///
///             configureFromStateUIModelChange()
///         }
///
///         func configure(action: @escaping () -> Void) {
///             baseButton.stateChangeHandler = { [weak self] gestureState in
///                 guard let self else { return }
///
///                 internalState = SomeButtonInternalState(isEnabled: state.isGestureEnabled, isPressed: gestureState.didRecognizePress)
///
///                 configureFromStateUIModelChange()
///                 if gestureState.didRecognizeClick { action() }
///             }
///         }
///
///         func configure(title: String) {
///             titleLabel.text = title
///         }
///
///         private func configureFromStateUIModelChange() {
///             titleLabel.textColor = uiModel.titleColors.value(for: internalState)
///         }
///     }
///
///     let button: SomeButton = .init(
///         action: { print("Clicked") },
///         title: "Lorem Ipsum"
///     )
///
@available(tvOS, unavailable)
open class UIKitBaseButton: UIView, Sendable {
    // MARK: Properties
    private lazy var gestureRecognizer: UIKitBaseButtonGestureRecognizer = .init(onStateChange: { [weak self] gestureState in
        guard let self else { return }
        
        internalButtonState = .init(isEnabled: buttonState.isGestureEnabled, isPressed: gestureState.didRecognizeClick)
        stateChangeHandler(gestureState)
    })
    
    /// Indicates if interaction is enabled.
    open var isEnabled: Bool {
        get {
            internalButtonState.isGestureEnabled
        }
        set {
            internalButtonState = UIKitBaseButtonInternalState(isEnabled: newValue)
            gestureRecognizer.isEnabled = internalButtonState.isGestureEnabled
        }
    }
    
    /// Button state.
    open var buttonState: UIKitBaseButtonState { .init(internalState: internalButtonState) }
    
    /// Internal button state.
    private(set) open var internalButtonState: UIKitBaseButtonInternalState = .default
    
    /// State change handler.
    open var stateChangeHandler: (GestureBaseButtonGestureState) -> Void
    
    // MARK: Initializers
    /// Initializes `UIKitBaseButton` with state change handler.
    public init(
        onStateChange stateChangeHandler: @escaping (GestureBaseButtonGestureState) -> Void
    ) {
        self.stateChangeHandler = stateChangeHandler
        super.init(frame: .zero)
    }
    
    /// Initializes `UIKitBaseButton` with action.
    convenience public init(
        action: @escaping () -> Void
    ) {
        self.init(onStateChange: { gestureState in
            if gestureState.didRecognizeClick { action() }
        })
    }
    
    @available(*, unavailable)
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
        internalButtonState = UIKitBaseButtonInternalState(isEnabled: state.isGestureEnabled, isPressed: internalButtonState == .pressed)
        gestureRecognizer.isEnabled = internalButtonState.isGestureEnabled
    }
}

// MARK: - Preview
#if DEBUG

#if !os(tvOS)

#Preview(body: {
    SomeButton(
        action: {},
        title: "Lorem Ipsum"
    )
})

// Preview macro doesn’t support nested macro expansions
private struct SomeButtonUIModel {
    var titleColors: StateColors = .init(
        enabled: UIColor.label,
        pressed: UIColor.secondaryLabel,
        disabled: UIColor.secondaryLabel
    )

    typealias StateColors = GenericStateModel_EnabledPressedDisabled<UIColor>
}

private typealias SomeButtonState = GenericState_EnabledDisabled

private typealias SomeButtonInternalState = GenericState_EnabledPressedDisabled

private final class SomeButton: UIView {
    // Action is passed during configuration
    private lazy var baseButton: UIKitBaseButton = .init(action: { [weak self] in self?.configureFromStateUIModelChange() })
        .withTranslatesAutoresizingMaskIntoConstraints(false)

    private let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    private var uiModel: SomeButtonUIModel

    var isEnabled: Bool {
        get { internalState.isGestureEnabled }
        set { configure(state: SomeButtonState(isEnabled: newValue)) }
    }
    var state: SomeButtonState { .init(isEnabled: internalState.isGestureEnabled) }
    private var internalState: SomeButtonInternalState = .enabled
        { didSet { baseButton.isEnabled = internalState.isGestureEnabled } }

    init(
        uiModel: SomeButtonUIModel = .init(),
        action: @escaping () -> Void,
        title: String
    ) {
        self.uiModel = uiModel
        super.init(frame: .zero)
        setUp()
        configure(uiModel: uiModel)
        configure(action: action)
        configure(title: title)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setUp() {
        addSubview(baseButton)
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            baseButton.constraintLeading(to: self),
            baseButton.constraintTrailing(to: self),
            baseButton.constraintTop(to: self),
            baseButton.constraintBottom(to: self),

            titleLabel.constraintHeight(to: nil, constant: titleLabel.singleLineHeight),
            titleLabel.constraintLeading(to: self),
            titleLabel.constraintTrailing(to: self),
            titleLabel.constraintTop(to: self),
            titleLabel.constraintBottom(to: self)
        ])
    }

    func configure(uiModel: SomeButtonUIModel) {
        self.uiModel = uiModel

        configureFromStateUIModelChange()
    }

    func configure(state: SomeButtonState) {
        internalState = SomeButtonInternalState(isEnabled: state.isGestureEnabled, isPressed: baseButton.internalButtonState == .pressed)

        configureFromStateUIModelChange()
    }

    func configure(action: @escaping () -> Void) {
        baseButton.stateChangeHandler = { [weak self] gestureState in
            guard let self else { return }

            internalState = SomeButtonInternalState(isEnabled: state.isGestureEnabled, isPressed: gestureState.didRecognizePress)

            configureFromStateUIModelChange()
            if gestureState.didRecognizeClick { action() }
        }
    }

    func configure(title: String) {
        titleLabel.text = title
    }

    private func configureFromStateUIModelChange() {
        titleLabel.textColor = uiModel.titleColors.value(for: internalState)
    }
}

#endif

#endif

#endif
