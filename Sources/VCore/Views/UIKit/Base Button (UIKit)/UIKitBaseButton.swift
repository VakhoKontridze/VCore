//
//  UIKitBaseButton.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

/// `UIKit` `UIView` that can be used as a base for all interactive views and buttons.
///
/// `UIKitBaseButton` can be used as a basis for all interactive UI components.
///
/// Model:
///
///     struct PlainButtonAppearance {
///         var labelTextColors: StateColors = .init(
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
///     typealias PlainButtonState = GenericState_EnabledDisabled
///
///     typealias PlainButtonInternalState = GenericState_EnabledPressedDisabled
///
/// Button:
///
///     final class PlainButton: UIView {
///         // Action is passed during configuration
///         private lazy var baseButton: UIKitBaseButton = {
///             let button: UIKitBaseButton = .init(action: { [weak self] in self?.configureFromStateAppearanceChange() })
///             button.translatesAutoresizingMaskIntoConstraints = false
///             return button
///         }()
///
///         private let titleLabel: UILabel = {
///             let label: UILabel = .init()
///             label.translatesAutoresizingMaskIntoConstraints = false
///             label.textAlignment = .center
///             return label
///         }()
///
///         private var appearance: PlainButtonAppearance
///
///         var isEnabled: Bool {
///             get { internalState.isGestureEnabled }
///             set { configure(state: PlainButtonState(isEnabled: newValue)) }
///         }
///         var state: PlainButtonState { .init(isEnabled: internalState.isGestureEnabled) }
///         private var internalState: PlainButtonInternalState = .enabled
///             { didSet { baseButton.isEnabled = internalState.isGestureEnabled } }
///
///         init(
///             appearance: PlainButtonAppearance = .init(),
///             action: @escaping () -> Void,
///             title: String
///         ) {
///             self.appearance = appearance
///             super.init(frame: .zero)
///             setUp()
///             configure(appearance: appearance)
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
///                 baseButton.leadingAnchor.constraint(equalTo: leftAnchor),
///                 baseButton.trailingAnchor.constraint(equalTo: trailingAnchor),
///                 baseButton.topAnchor.constraint(equalTo: topAnchor),
///                 baseButton.bottomAnchor.constraint(equalTo: bottomAnchor),
///
///                 titleLabel.heightAnchor.constraint(equalToConstant: titleLabel.singleLineHeight),
///                 titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
///                 titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
///                 titleLabel.topAnchor.constraint(equalTo: topAnchor),
///                 titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
///             ])
///         }
///
///         func configure(appearance: PlainButtonAppearance) {
///             self.appearance = appearance
///
///             configureFromStateAppearanceChange()
///         }
///
///         func configure(state: PlainButtonState) {
///             internalState = PlainButtonInternalState(isEnabled: state.isGestureEnabled, isPressed: baseButton.internalButtonState == .pressed)
///
///             configureFromStateAppearanceChange()
///         }
///
///         func configure(action: @escaping () -> Void) {
///             baseButton.stateChangeHandler = { [weak self] gestureState in
///                 guard let self else { return }
///
///                 internalState = PlainButtonInternalState(isEnabled: state.isGestureEnabled, isPressed: gestureState.didRecognizePress)
///
///                 configureFromStateAppearanceChange()
///                 if gestureState.didRecognizeClick { action() }
///             }
///         }
///
///         func configure(title: String) {
///             titleLabel.text = title
///         }
///
///         private func configureFromStateAppearanceChange() {
///             titleLabel.textColor = appearance.labelTextColors.value(for: internalState)
///         }
///     }
///
///     let button: PlainButton = .init(
///         action: { print("Clicked") },
///         title: "Lorem Ipsum"
///     )
///
@available(tvOS, unavailable)
open class UIKitBaseButton: UIView {
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

#if DEBUG

#if !os(tvOS) // Redundant

#Preview {
    PlainButton(
        action: {},
        title: "Lorem Ipsum"
    )
}

// Macros aren't allowed in Preview macro
private struct PlainButtonAppearance {
    // MARK: Properties
    var labelTextColors: StateColors = .init(
        enabled: UIColor.label,
        pressed: UIColor.secondaryLabel,
        disabled: UIColor.secondaryLabel
    )

    // MARK: Types
    typealias StateColors = GenericStateModel_EnabledPressedDisabled<UIColor>
}

private typealias PlainButtonState = GenericState_EnabledDisabled

private typealias PlainButtonInternalState = GenericState_EnabledPressedDisabled

private final class PlainButton: UIView {
    // MARK: Properties - Appearance
    private var appearance: PlainButtonAppearance
    
    // MARK: Properties - State
    var isEnabled: Bool {
        get { internalState.isGestureEnabled }
        set { configure(state: PlainButtonState(isEnabled: newValue)) }
    }
    var state: PlainButtonState { .init(isEnabled: internalState.isGestureEnabled) }
    private var internalState: PlainButtonInternalState = .enabled
        { didSet { baseButton.isEnabled = internalState.isGestureEnabled } }
    
    // MARK: Properties - Subviews
    // Action is passed during configuration
    private lazy var baseButton: UIKitBaseButton = {
        let button: UIKitBaseButton = .init(action: { [weak self] in self?.configureFromStateAppearanceChange() })
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    // MARK: Initializers
    init(
        appearance: PlainButtonAppearance = .init(),
        action: @escaping () -> Void,
        title: String
    ) {
        self.appearance = appearance
        super.init(frame: .zero)
        setUp()
        configure(appearance: appearance)
        configure(action: action)
        configure(title: title)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: Setup
    private func setUp() {
        addSubview(baseButton)
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            baseButton.leadingAnchor.constraint(equalTo: leftAnchor),
            baseButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            baseButton.topAnchor.constraint(equalTo: topAnchor),
            baseButton.bottomAnchor.constraint(equalTo: bottomAnchor),

            titleLabel.heightAnchor.constraint(equalToConstant: titleLabel.singleLineHeight),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: Configuration
    func configure(appearance: PlainButtonAppearance) {
        self.appearance = appearance

        configureFromStateAppearanceChange()
    }

    func configure(state: PlainButtonState) {
        internalState = PlainButtonInternalState(isEnabled: state.isGestureEnabled, isPressed: baseButton.internalButtonState == .pressed)

        configureFromStateAppearanceChange()
    }

    func configure(action: @escaping () -> Void) {
        baseButton.stateChangeHandler = { [weak self] gestureState in
            guard let self else { return }

            internalState = PlainButtonInternalState(isEnabled: state.isGestureEnabled, isPressed: gestureState.didRecognizePress)

            configureFromStateAppearanceChange()
            if gestureState.didRecognizeClick { action() }
        }
    }

    func configure(title: String) {
        titleLabel.text = title
    }

    private func configureFromStateAppearanceChange() {
        titleLabel.textColor = appearance.labelTextColors.value(for: internalState)
    }
}

#endif

#endif

#endif
