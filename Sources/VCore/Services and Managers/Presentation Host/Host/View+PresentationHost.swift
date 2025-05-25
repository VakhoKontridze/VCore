//
//  View+PresentationHost.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.07.24.
//

import SwiftUI

// MARK: - View + Presentation Host
extension View {
    /// Injects a Presentation Host in view hierarchy for modal presentation.
    ///
    ///     @State private var isPresented: Bool = true
    ///
    ///     var body: some View {
    ///         ZStack(content: {
    ///             Button(
    ///                 "Present",
    ///                 action: { isPresented = true }
    ///             )
    ///             .someModal(
    ///                 id: "some_modal",
    ///                 isPresented: $isPresented,
    ///                 content: { Color.accentColor }
    ///             )
    ///         })
    ///         .frame(maxWidth: .infinity, maxHeight: .infinity)
    ///         .presentationHostLayer() // Or declare in `App` on a `WindowScene`-level
    ///     }
    ///
    ///     extension View {
    ///         func someModal<Content>(
    ///             layerID: String? = nil,
    ///             id: String,
    ///             isPresented: Binding<Bool>,
    ///             @ViewBuilder content: @escaping () -> Content
    ///         ) -> some View
    ///             where Content: View
    ///         {
    ///             self
    ///                 .presentationHost(
    ///                     layerID: layerID,
    ///                     id: id,
    ///                     isPresented: isPresented,
    ///                     content: {
    ///                         SomeModal(
    ///                             isPresented: isPresented,
    ///                             content: content
    ///                         )
    ///                     }
    ///                 )
    ///         }
    ///     }
    ///
    ///     struct SomeModal<Content>: View where Content: View {
    ///         @Environment(\.presentationHostContainerSize) private var containerSize: CGSize
    ///         @Environment(\.presentationHostSafeAreaInsets) private var safeAreaInsets: EdgeInsets
    ///
    ///         @Environment(\.presentationHostPresentationMode) private var presentationMode: PresentationHostPresentationMode!
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
    ///             ZStack(content: {
    ///                 Color(uiColor: .systemBackground)
    ///
    ///                 content()
    ///                     .padding()
    ///             })
    ///             .frame(dimension: 300)
    ///
    ///             .compositingGroup() // For shadow
    ///             .shadow(
    ///                 color: .black.opacity(0.15),
    ///                 radius: 10
    ///             )
    ///
    ///             .offset(y: isPresentedInternally ? 0 : (containerSize.height + 300)/2)
    ///
    ///             .onReceive(presentationMode.presentPublisher, perform: animateIn)
    ///             .onReceive(presentationMode.dismissPublisher, perform: animateOut)
    ///             .onReceive(presentationMode.dimmingViewTapActionPublisher, perform: didTapDimmingView)
    ///         }
    ///
    ///         private func didTapDimmingView() {
    ///             isPresented = false
    ///         }
    ///
    ///         private func animateIn() {
    ///             withAnimation(
    ///                 .easeInOut(duration: 0.3),
    ///                 { isPresentedInternally = true }
    ///             )
    ///         }
    ///
    ///         private func animateOut(
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
    public func presentationHost<Content>(
        layerID: String? = nil,
        id: String,
        uiModel: PresentationHostUIModel = .init(),
        isPresented: Binding<Bool>,
        onPresent presentHandler: (() -> Void)? = nil,
        onDismiss dismissHandler: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View
        where Content: View
    {
        self
            .modifier(
                PresentationHostViewModifier(
                    layerID: layerID,
                    id: id,
                    uiModel: uiModel,
                    isPresented: isPresented,
                    onPresent: presentHandler,
                    onDismiss: dismissHandler,
                    content: content
                )
            )
    }
}

// MARK: - Presentation Host View Modifier
private struct PresentationHostViewModifier<ModalContent>: ViewModifier where ModalContent: View {
    // MARK: Properties - ID
    private let id: String

    // MARK: Properties - UI Model
    private let uiModel: PresentationHostUIModel

    // MARK: Properties - State
    @Binding private var isPresented: Bool

    // MARK: Properties - Actions
    private let presentHandler: (() -> Void)?
    private let dismissHandler: (() -> Void)?

    // MARK: Properties - Content
    private let modalContent: () -> ModalContent

    // MARK: Properties - Presentation Mode
    @State private var internalPresentationMode: PresentationHostInternalPresentationMode

    // MARK: Initializers
    init(
        layerID: String?,
        id: String,
        uiModel: PresentationHostUIModel,
        isPresented: Binding<Bool>,
        onPresent presentHandler: (() -> Void)?,
        onDismiss dismissHandler: (() -> Void)?,
        @ViewBuilder content modalContent: @escaping () -> ModalContent
    ) {
        self.id = id
        self._isPresented = isPresented
        self.uiModel = uiModel
        self.presentHandler = presentHandler
        self.dismissHandler = dismissHandler
        self.modalContent = modalContent
        self._internalPresentationMode = State(
            wrappedValue: PresentationHostInternalPresentationModeRegistrar.shared.resolve(layerID: layerID)
        )
    }

    // MARK: Body
    func body(content: Content) -> some View {
        updateModal()

        return content
            .onChange(of: isPresented, initial: true, { (_, newValue) in
                if newValue {
                    presentModal()
                } else {
                    dismissModal()
                }
            })
            .onDisappear(perform: {
                if uiModel.dismissesModalWhenHostDisappears {
                    isPresented = false
                    dismissModal() // Needed, despite setting flag to `false`
                }
            })
    }

    // MARK: Actions
    private func presentModal() {
        internalPresentationMode.presentPublisher.send(
            PresentationHostInternalPresentationMode.PresentationData(
                id: id,
                uiModel: uiModel,
                view: { modalContent().eraseToAnyView() },
                completion: { presentHandler?() }
            )
        )
    }

    private func updateModal() {
        internalPresentationMode.updatePublisher.send(
            PresentationHostInternalPresentationMode.UpdateData(
                id: id,
                uiModel: uiModel,
                view: { modalContent().eraseToAnyView() }
            )
        )
    }

    private func dismissModal() {
        internalPresentationMode.dismissPublisher.send(
            PresentationHostInternalPresentationMode.DismissData(
                id: id,
                completion: { dismissHandler?() }
            )
        )
    }
}

// MARK: - Preview
#if DEBUG

#Preview(body: {
    @Previewable @State var isPresented: Bool = true

    let backgroundColor: Color? = {
#if os(visionOS)
        Color.clear
#else
        nil
#endif
    }()

    let contentColor: Color = {
#if os(tvOS)
        Color.blue
#elseif os(watchOS)
        Color.blue
#else
        Color.accentColor
#endif
    }()

    return ZStack(content: {
        backgroundColor

        Button(
            "Present",
            action: { isPresented = true }
        )
        .someModal(
            id: "some_modal",
            isPresented: $isPresented,
            content: { contentColor }
        )
    })
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .presentationHostLayer()
})

extension View {
    fileprivate func someModal<Content>(
        layerID: String? = nil,
        id: String,
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View
    where Content: View
    {
        self
            .presentationHost(
                layerID: layerID,
                id: id,
                isPresented: isPresented,
                content: {
                    SomeModal(
                        isPresented: isPresented,
                        content: content
                    )
                }
            )
    }
}

private struct SomeModal<Content>: View where Content: View {
    @Environment(\.presentationHostContainerSize) private var containerSize: CGSize
    @Environment(\.presentationHostSafeAreaInsets) private var safeAreaInsets: EdgeInsets

    @Environment(\.presentationHostPresentationMode) private var presentationMode: PresentationHostPresentationMode!

    @Binding private var isPresented: Bool
    @State private var isPresentedInternally: Bool = false

    private let content: () -> Content

    init(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._isPresented = isPresented
        self.content = content
    }

    var body: some View {
        let backgroundColor: Color = {
#if os(iOS)
            Color(uiColor: .systemBackground)
#elseif os(macOS)
            Color(nsColor: .windowBackgroundColor)
#elseif os(tvOS)
            Color.dynamic(Color.white, Color.black)
#elseif os(watchOS)
            Color.black
#elseif os(visionOS)
            Color(uiColor: .systemBackground)
#endif
        }()

        let dimension: CGFloat = {
#if os(iOS)
            300
#elseif os(macOS)
            250
#elseif os(tvOS)
            750
#elseif os(watchOS)
            150
#elseif os(visionOS)
            500
#endif
        }()

        return ZStack(content: {
            backgroundColor

            content()
                .padding()
        })
        .frame(dimension: dimension)
        
        .compositingGroup() // For shadow
        .shadow(
            color: .black.opacity(0.15),
            radius: 10
        )

        .offset(y: isPresentedInternally ? 0 : (containerSize.height + dimension)/2)

        .onReceive(presentationMode.presentPublisher, perform: animateIn)
        .onReceive(presentationMode.dismissPublisher, perform: animateOut)
        .onReceive(presentationMode.dimmingViewTapActionPublisher, perform: didTapDimmingView)
    }

    private func didTapDimmingView() {
        isPresented = false
    }

    private func animateIn() {
        withAnimation(
            .easeInOut(duration: 0.3),
            { isPresentedInternally = true }
        )
    }

    private func animateOut(
        completion: @escaping () -> Void
    ) {
        withAnimation(
            .easeInOut(duration: 0.3),
            { isPresentedInternally = false },
            completion: completion
        )
    }
}

#endif
