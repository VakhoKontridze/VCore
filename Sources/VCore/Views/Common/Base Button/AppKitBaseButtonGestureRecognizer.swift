//
//  AppKitBaseButtonGestureRecognizer.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 23.03.23.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import AppKit

// MARK: - AppKit Base Button Gesture Recognizer
final class AppKitBaseButtonGestureRecognizer: NSGestureRecognizer, NSGestureRecognizerDelegate {
    // MARK: Properties
    override var state: NSGestureRecognizer.State {
        get { super.state }
        set {
            guard newValue != .changed else { return } // Not supported
            
            super.state = newValue
            stateChangedHandler(GestureBaseButtonGestureState(state: newValue))
        }
    }
    private var stateChangedHandler: (GestureBaseButtonGestureState) -> Void
    
    private lazy var model: GestureBaseButtonModel = .init(stateSetter: { [weak self] state in
        guard let self else { return }
        self.state = state
    })
    
    // MARK: Initializers
    init(
        onStateChange stateChangedHandler: @escaping (GestureBaseButtonGestureState) -> Void
    ) {
        self.stateChangedHandler = stateChangedHandler
        
        super.init(target: nil, action: nil)
        
        delegate = self
        stateChangedHandler(GestureBaseButtonGestureState(state: state)) // Setter isn't called from initializer
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Configuration
    func setStateChangeHandler(
        to stateChangedHandler: @escaping (GestureBaseButtonGestureState) -> Void
    ) {
        self.stateChangedHandler = stateChangedHandler
    }
    
    // MARK: Touches
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
    
    // MARK: Gesture Recognizer Delegate
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
