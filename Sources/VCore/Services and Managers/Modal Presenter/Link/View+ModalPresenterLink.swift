//
//  View+ModalPresenterLink.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.07.24.
//

import SwiftUI

extension View {
    /// Injects Modal Presenter link in view hierarchy for modal presentation.
    ///
    ///     @State private var isPresented: Bool = true
    ///
    ///     var body: some View {
    ///         ZStack {
    ///             Button("Present") {
    ///                 isPresented = true
    ///             }
    ///             .modal(
    ///                 link: .window(linkID: "modal"),
    ///                 isPresented: $isPresented)
    ///             ) {
    ///                 Color.accentColor
    ///             }
    ///         }
    ///         .frame(maxWidth: .infinity, maxHeight: .infinity) // For `overlay` configuration
    ///         .modalPresenterRoot(root: .window()) // Or declare in `App` on a `WindowScene`-level
    ///     }
    ///
    ///     extension View {
    ///         func modal<Content>(
    ///             link: ModalPresenterLink,
    ///             isPresented: Binding<Bool>,
    ///             @ViewBuilder content: @escaping () -> Content
    ///         ) -> some View
    ///             where Content: View
    ///         {
    ///             self
    ///                 .modalPresenterLink(
    ///                     link: link,
    ///                     isPresented: isPresented,
    ///                  ) {
    ///                     Modal(
    ///                         isPresented: isPresented,
    ///                         content: content
    ///                     )
    ///                 }
    ///         }
    ///     }
    ///
    ///     struct Modal<Content>: View where Content: View {
    ///         @Environment(\.modalPresenterInterfaceOrientation) private var interfaceOrientation: PlatformInterfaceOrientation
    ///         @Environment(\.modalPresenterContainerSize) private var containerSize: CGSize
    ///         @Environment(\.modalPresenterSafeAreaInsets) private var safeAreaInsets: EdgeInsets
    ///
    ///         @Environment(\.modalPresenterPresentationMode) private var presentationMode: ModalPresenterPresentationMode!
    ///
    ///         @Binding private var isPresented: Bool
    ///         @State private var isPresentedInternally: Bool = false
    ///
    ///         private let content: () -> Content
    ///
    ///         init(
    ///             isPresented: Binding<Bool>,
    ///             @ViewBuilder content: @escaping () -> Content
    ///         ) {
    ///             self._isPresented = isPresented
    ///             self.content = content
    ///         }
    ///
    ///         var body: some View {
    ///             ZStack {
    ///                 Color(uiColor: UIColor.systemBackground)
    ///
    ///                 content()
    ///                     .padding()
    ///             }
    ///             .frame(dimension: 300)
    ///             .clipped()
    ///
    ///             .compositingGroup() // For shadow
    ///             .shadow(
    ///                 color: Color.black.opacity(0.15),
    ///                 radius: 10
    ///             )
    ///
    ///             .offset(y: isPresentedInternally ? 0 : (containerSize.height + 300)/2)
    ///
    ///             .onReceive(presentationMode.presentPublisher, perform: onPresent)
    ///             .onReceive(presentationMode.dismissPublisher, perform: onDismiss)
    ///             .onReceive(presentationMode.dimmingViewTapActionPublisher, perform: onDimmingViewTap)
    ///         }
    ///
    ///         private func onDimmingViewTap() {
    ///             isPresented = false
    ///         }
    ///
    ///         private func onPresent() {
    ///             withAnimation(
    ///                 .easeInOut(duration: 0.3),
    ///                 { isPresentedInternally = true }
    ///             )
    ///         }
    ///
    ///         private func onDismiss(
    ///             completion: @escaping () -> Void
    ///         ) {
    ///             withAnimation(
    ///                 .easeInOut(duration: 0.3),
    ///                 { isPresentedInternally = false },
    ///                 completion: completion
    ///             )
    ///         }
    ///     }
    ///
    public func modalPresenterLink<Content>(
        link: ModalPresenterLink,
        appearance: ModalPresenterLinkAppearance = .init(),
        isPresented: Binding<Bool>,
        onPresent presentHandler: (() -> Void)? = nil,
        onDismiss dismissHandler: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View
        where Content: View
    {
        self
            .modifier(
                ModalPresenterLinkViewModifier(
                    link: link,
                    appearance: appearance,
                    isPresented: isPresented,
                    onPresent: presentHandler,
                    onDismiss: dismissHandler,
                    content: content
                )
            )
    }
}
