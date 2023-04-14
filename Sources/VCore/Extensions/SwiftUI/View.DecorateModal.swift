//
//  View.DecorateModal.swift
//  
//
//  Created by Vakhtang Kontridze on 14.04.23.
//

#if canImport(UIKit) && !os(watchOS)

import SwiftUI

// MARK: - View Decorate Modal
extension View {
    /// Retrieves modal's superview and `UITransitionView` for customization.
    ///
    ///     @State private var isPresented: Bool = false
    ///
    ///     var body: some View {
    ///         Button("Present", action: { isPresented = true })
    ///             .fullScreenCover(
    ///                 isPresented: $isPresented,
    ///                 content: {
    ///                     Color.accentColor
    ///                         .ignoresSafeArea()
    ///                         .onTapGesture(perform: { isPresented = false })
    ///                         .decorateModal({ (modalSuperView, transitionView) in
    ///                             if
    ///                                 let modalSuperView,
    ///                                 let displayCornerRadius = UIScreen.main.displayCornerRadius
    ///                             {
    ///                                 modalSuperView.roundCorners(.layerMinYCorners, by: displayCornerRadius)
    ///                             }
    ///
    ///                             if let transitionView {
    ///                                 transitionView.backgroundColor = .gray.withAlphaComponent(0.16)
    ///                             }
    ///                         })
    ///                 }
    ///             )
    ///     }
    ///
    public func decorateModal(
        _ decorate: @escaping (UIView?, UIView?) -> Void
    ) -> some View {
        self
            .background(ModalDecoratorView(
                decorate: decorate
            ))
    }
}

// MARK: - Modal Decorator View
private struct ModalDecoratorView: UIViewRepresentable {
    // MARK: Properties
    private let decorate: (UIView?, UIView?) -> Void
    
    // MARK: Initializers
    init(
        decorate: @escaping (UIView?, UIView?) -> Void
    ) {
        self.decorate = decorate
    }
    
    // MARK: Representable
    func makeUIView(context: Context) -> _ModalDecoratorView {
        .init(
            decorate: decorate
        )
    }
    
    func updateUIView(_ uiView: _ModalDecoratorView, context: Context) {}
}

// MARK: - _ Modal Decorator View
private final class _ModalDecoratorView: UIView {
    // MARK: Properties
    private let decorate: (UIView?, UIView?) -> Void
    
    // MARK: Initializers
    init(
        decorate: @escaping (UIView?, UIView?) -> Void
    ) {
        self.decorate = decorate
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Lifecycle
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        if window != nil {
            setUp()
        }
    }
    
    // MARK: Setup
    private func setUp() {
        let transitionViewChild: UIView? = Self.findSuperview(
            on: self,
            where: { $0.superview?.isTransitionView ?? false }
        )
        
        decorate(
            transitionViewChild,
            transitionViewChild?.superview
        )
    }
    
    // MARK: Finding Superview
    private static func findSuperview(
        on view: UIView,
        where predicate: (UIView) -> Bool
    ) -> UIView? {
        if predicate(view) {
            return view
        } else if let superview: UIView = view.superview {
            return findSuperview(on: superview, where: predicate)
        } else {
            return nil
        }
    }
}

// MARK: - Helpers
extension UIView {
    fileprivate var isTransitionView: Bool {
        String(describing: type(of: self)) == "UITransitionView"
    }
}

#endif
