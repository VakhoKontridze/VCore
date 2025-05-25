//
//  View+DecorateModal.swift
//  
//
//  Created by Vakhtang Kontridze on 14.04.23.
//

#if canImport(UIKit) && !os(watchOS)

import SwiftUI

// MARK: - View + Decorate Modal
extension View {
    /// Retrieves modal's top-most superview and `UITransitionView` for customization.
    ///
    /// This method assumes implementation details about presentation API,
    /// and could break in future OS releases.
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
    ///                                 let displayCornerRadius: CGFloat = modalSuperView.window?.screen.displayCornerRadius
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
            .background(content: {
                ModalDecoratorView(
                    decorate: decorate
                )
                .allowsHitTesting(false) // Avoids blocking gestures
            })
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
    
    @available(*, unavailable)
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
            ofView: self,
            where: { $0.superview?.isUITransitionView ?? false }
        )
        
        decorate(
            transitionViewChild,
            transitionViewChild?.superview
        )
    }
    
    // MARK: Finding Superview
    private static func findSuperview(
        ofView view: UIView,
        where predicate: (UIView) -> Bool
    ) -> UIView? {
        if predicate(view) {
            view
        } else if let superview: UIView = view.superview {
            findSuperview(ofView: superview, where: predicate)
        } else {
            nil
        }
    }
}

// MARK: - Helpers
extension UIView {
    fileprivate var isUITransitionView: Bool {
        String(describing: type(of: self)) == "UITransitionView"
    }
}

// MARK: - Preview
#if DEBUG

#if !(os(watchOS) || os(visionOS))

#Preview(body: {
    @Previewable @State var isPresented: Bool = false

    Button("Present", action: { isPresented = true })
        .fullScreenCover(
            isPresented: $isPresented,
            content: {
                Color.accentColor
                    .ignoresSafeArea()
                    .onTapGesture(perform: { isPresented = false })
                    .decorateModal({ (modalSuperView, transitionView) in
                        if
                            let modalSuperView,
                            let displayCornerRadius: CGFloat = modalSuperView.window?.screen.displayCornerRadius
                        {
                            modalSuperView.roundCorners(.layerMinYCorners, by: displayCornerRadius)
                        }

                        if let transitionView {
                            transitionView.backgroundColor = .gray.withAlphaComponent(0.16)
                        }
                    })
            }
        )
})

#endif

#endif

#endif
