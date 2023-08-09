//
//  View.PresentationHost.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 06.03.23.
//

import SwiftUI

// MARK: - View Presentation Host
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension View {
    /// Injects a Presentation Host in view hierarchy for modal presentation.
    ///
    /// For `allowHitTests`=`false` to have an effect, underlying `SwiftUI` `View` shouldn't have gestures.
    ///
    ///     extension View {
    ///         func someModal(
    ///             id: String,
    ///             isPresented: Binding<Bool>,
    ///             @ViewBuilder content: @escaping () -> some View
    ///         ) -> some View {
    ///             self
    ///                 .presentationHost(
    ///                     id: id,
    ///                     isPresented: isPresented,
    ///                     content: {
    ///                         SomeModal(content: content)
    ///                     }
    ///                 )
    ///         }
    ///     }
    ///
    ///     struct SomeModal<Content>: View where Content: View {
    ///         @Environment(\.presentationHostGeometryReaderSize) private var screenSize: CGSize
    ///         @Environment(\.presentationHostGeometryReaderSafeAreaInsets) private var safeAreaInsets: EdgeInsets
    ///
    ///         @Environment(\.presentationHostPresentationMode) private var presentationMode: PresentationHostPresentationMode
    ///         @State private var isInternallyPresented: Bool = false
    ///
    ///         private let content: () -> Content
    ///
    ///         init(
    ///             @ViewBuilder content: @escaping () -> Content
    ///         ) {
    ///             self.content = content
    ///         }
    ///
    ///         var body: some View {
    ///             ZStack(content: {
    ///                 Color.black.opacity(0.16)
    ///                     .edgesIgnoringSafeArea(.all)
    ///                     .onTapGesture(perform: animateOut)
    ///
    ///                 content()
    ///                     .offset(y: isInternallyPresented ? 0 : screenSize.height)
    ///             })
    ///             .onAppear(perform: animateIn)
    ///             .onChange(
    ///                 of: presentationMode.isExternallyDismissed,
    ///                 perform: { if $0 && isInternallyPresented { animateOutFromExternalDismiss() } }
    ///             )
    ///         }
    ///
    ///         private func animateIn() {
    ///             withBasicAnimation(
    ///                 BasicAnimation(curve: .easeInOut, duration: 0.3),
    ///                 body: { isInternallyPresented = true },
    ///                 completion: nil
    ///            )
    ///        }
    ///
    ///         private func animateOut() {
    ///             withBasicAnimation(
    ///                 BasicAnimation(curve: .easeInOut, duration: 0.3),
    ///                 body: { isInternallyPresented = false },
    ///                 completion: presentationMode.dismiss
    ///             )
    ///         }
    ///
    ///         private func animateOutFromExternalDismiss() {
    ///             withBasicAnimation(
    ///                 BasicAnimation(curve: .easeInOut, duration: 0.3),
    ///                 body: { isInternallyPresented = false },
    ///                 completion: presentationMode.externalDismissCompletion
    ///             )
    ///         }
    ///     }
    ///
    @ViewBuilder public func presentationHost<Content>(
        id: String,
        uiModel: PresentationHostUIModel = .init(),
        isPresented: Binding<Bool>,
        content: @escaping () -> Content
    ) -> some View
        where Content: View
    {
#if canImport(UIKit) && !os(watchOS)
        self
            .onDisappear(perform: { PresentationHostViewController.forceDismiss(id: id) })
            .background(PresentationHostView(
                id: id,
                uiModel: uiModel,
                isPresented: isPresented,
                content: content
            ))
#endif
    }
    
    /// Injects a Presentation Host in view hierarchy for modal presentation.
    ///
    /// For additional info, refer to `View.presentationHost(id:allowsHitTests:isPresented:content).`
    public func presentationHost<Item ,Content>(
        id: String,
        uiModel: PresentationHostUIModel = .init(),
        item: Binding<Item?>,
        content: @escaping () -> Content
    ) -> some View
        where Content: View
    {
        self
            .presentationHost(
                id: id,
                uiModel: uiModel,
                isPresented: Binding(
                    get: { item.wrappedValue != nil },
                    set: { if !$0 { item.wrappedValue = nil } }
                ),
                content: content
            )
    }
    
    /// Injects a Presentation Host in view hierarchy for modal presentation.
    ///
    /// For additional info, refer to `View.presentationHost(id:allowsHitTests:isPresented:content).`
    public func presentationHost<T ,Content>(
        id: String,
        uiModel: PresentationHostUIModel = .init(),
        isPresented: Binding<Bool>,
        presenting data: T?,
        content: @escaping () -> Content
    ) -> some View
        where Content: View
    {
        self
            .presentationHost(
                id: id,
                uiModel: uiModel,
                isPresented: Binding(
                    get: { isPresented.wrappedValue && data != nil },
                    set: { if !$0 { isPresented.wrappedValue = false } }
                ),
                content: content
            )
    }
    
    /// Injects a Presentation Host in view hierarchy for modal presentation.
    ///
    /// For additional info, refer to `View.presentationHost(id:allowsHitTests:isPresented:content).`
    public func presentationHost<E ,Content>(
        id: String,
        uiModel: PresentationHostUIModel = .init(),
        isPresented: Binding<Bool>,
        error: E?,
        content: @escaping () -> Content
    ) -> some View
        where Content: View
    {
        self
            .presentationHost(
                id: id,
                uiModel: uiModel,
                isPresented: Binding(
                    get: { isPresented.wrappedValue && error != nil },
                    set: { if !$0 { isPresented.wrappedValue = false } }
                ),
                content: content
            )
    }
}
