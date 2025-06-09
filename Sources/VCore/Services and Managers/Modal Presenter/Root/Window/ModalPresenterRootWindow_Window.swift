//
//  ModalPresenterRootWindow_Window.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.05.25.
//

#if !(os(macOS) || os(tvOS) || os(watchOS) || os(visionOS))

import SwiftUI

// MARK: - Modal Presenter Root Window (Window)
// https://developer.apple.com/forums/thread/762292?answerId=803885022
// https://medium.com/@adarsh.ranjan/fixing-tap-interactions-in-ios-18-understanding-and-resolving-the-root-view-hit-testing-issue-37c6c858e2d4
final class ModalPresenterRootWindow_Window: UIWindow {
    // MARK: Properties
    private let model: ModalPresenterRootModel_Window
    
    private let touchEventAndTouchViewDictionary: ModalPresenterTouchEventAndViewDictionary = .init()
    
    // MARK: Initializers
    init(
        windowScene: UIWindowScene,
        model: ModalPresenterRootModel_Window
    ) {
        self.model = model
        super.init(windowScene: windowScene)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Hit Test
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let view: UIView = super.hitTest(point, with: event) else { return nil }

        // `UIHostingController` doesn't allow hit tests of it's view to be overriden.
        // The only way to achieve passthrough behavior is to handle them in `UIWindow`.
        //
        // - When a touch occurs on a real subview inside `UIHostingController`,
        // currently overriden `hitTest(...)` method first is called from that way,
        // continuing up the view hierarchy, eventually reaching `UIHostingController.
        //
        // - When a touch occurs on area surrounding subview inside `UIHostingController`,
        // currently overriden `hitTest(...)` method if called directly from `UIHostingController`.
        //
        // So, we need to detect that. A dictionary is created that maps event ID to the very first view that triggered it.
        // There is no simple way of identifying events, so it's timestamps can be used.
        //
        // If no view can be found inside dictionary, meaning it's the very first entry in the method,
        // and view type is `_UIHostingView<ModalPresenterRootModalContent_Window>`, we can pass touches through.
        // Otherwise, view is saved in the dictionary to enable normal touches.
        if
            model.uiModel.dimmingViewTapAction == .passTapsThrough,
            let eventTimestamp: TimeInterval = event?.timestamp
        {
            let viewType: String = .init(describing: type(of: view))
            let targetViewTypeFragment: String = .init(describing: ModalPresenterRootModalContent_Window.self)
            
            if touchEventAndTouchViewDictionary.get(key: eventTimestamp) == nil {
                if viewType.contains(targetViewTypeFragment) {
                    return nil
                } else {
                    touchEventAndTouchViewDictionary.set(key: eventTimestamp, value: viewType)
                }
            }
        }
        
        if #available(iOS 18, *) {
            guard _hitTest(point, from: view) != rootViewController?.view else { return nil }
        } else {
            guard view != rootViewController?.view else { return nil }
        }

        return view
    }
    
    private func _hitTest(_ point: CGPoint, from view: UIView) -> UIView? {
        let convertedPoint: CGPoint = convert(point, to: view)
        
        guard
            view.bounds.contains(convertedPoint),
            view.isUserInteractionEnabled,
            !view.isHidden,
            view.alpha > 0
        else {
            return nil
        }
        
        for subview in view.subviews.reversed() {
            if let hitView: UIView = _hitTest(point, from: subview) {
                return hitView
            }
        }

        return view
    }
}

// MARK: - Modal Presenter Touch Event and View Dictionary
private final class ModalPresenterTouchEventAndViewDictionary {
    // MARK: Properties
    private let cache: NSCache<NSNumber, NSString> = {
        let cache: NSCache<NSNumber, NSString> = .init()
        cache.countLimit = 10
        return cache
    }()
    
    // MARK: Initializers
    init() {}
    
    // MARK: Operations
    func get(key: Double) -> String? {
        let keyNSNumber: NSNumber = .init(value: key)
        guard let valueNSString: NSString = cache.object(forKey: keyNSNumber) else { return nil }
        let value: String = valueNSString as String
        return value
    }
    
    func set(key: Double, value: String) {
        let keyNSNumber: NSNumber = .init(value: key)
        let valueNSString: NSString = value as NSString
        cache.setObject(valueNSString, forKey: keyNSNumber)
    }
}

#endif
