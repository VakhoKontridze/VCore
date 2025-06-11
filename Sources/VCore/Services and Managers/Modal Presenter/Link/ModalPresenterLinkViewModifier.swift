//
//  ModalPresenterLinkViewModifier.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.05.25.
//

import SwiftUI

// MARK: - Modal Presenter Link View Modifier
struct ModalPresenterLinkViewModifier<ModalContent>: ViewModifier where ModalContent: View {
    // MARK: Properties - Link
    private let link: ModalPresenterLink
    
    // MARK: Properties - UI Model
    private let uiModel: ModalPresenterLinkUIModel

    // MARK: Properties - State
    @Binding private var isPresented: Bool

    // MARK: Properties - Actions
    private let presentHandler: (() -> Void)?
    private let dismissHandler: (() -> Void)?

    // MARK: Properties - Content
    private let modalContent: () -> ModalContent

    // MARK: Properties - Presentation Mode
    @State private var internalPresentationMode: ModalPresenterInternalPresentationMode

    // MARK: Initializers
    init(
        link: ModalPresenterLink,
        uiModel: ModalPresenterLinkUIModel,
        isPresented: Binding<Bool>,
        onPresent presentHandler: (() -> Void)?,
        onDismiss dismissHandler: (() -> Void)?,
        @ViewBuilder content modalContent: @escaping () -> ModalContent
    ) {
        self.link = link
        self.uiModel = uiModel
        self._isPresented = isPresented
        self.presentHandler = presentHandler
        self.dismissHandler = dismissHandler
        self.modalContent = modalContent
        self._internalPresentationMode = State(
            wrappedValue: ModalPresenterInternalPresentationModeRegistrar.shared.resolve(
                key: ModalPresenterInternalPresentationModeKey(
                    link: link
                )
            )
        )
    }

    // MARK: Body
    func body(content: Content) -> some View {
        updateModal()

        return content
            .onChange(of: isPresented, initial: true) { (_, newValue) in
                if newValue {
                    presentModal()
                } else {
                    dismissModal()
                }
            }
            .onDisappear(perform: didDisappear)
    }
    
    // MARK: Lifecycle
    private func didDisappear() {
        if uiModel.dismissesModalWhenLinkDisappears {
            isPresented = false
            dismissModal() // Needed, despite setting flag to `false`
        }
    }

    // MARK: Actions
    private func presentModal() {
        internalPresentationMode.presentSubject.send(
            ModalPresenterInternalPresentationMode.PresentationData(
                link: link,
                uiModel: uiModel,
                view: { modalContent().eraseToAnyView() },
                completion: { presentHandler?() }
            )
        )
    }

    private func updateModal() {
        internalPresentationMode.updateSubject.send(
            ModalPresenterInternalPresentationMode.UpdateData(
                link: link,
                uiModel: uiModel,
                view: { modalContent().eraseToAnyView() }
            )
        )
    }

    private func dismissModal() {
        internalPresentationMode.dismissSubject.send(
            ModalPresenterInternalPresentationMode.DismissData(
                link: link,
                completion: { dismissHandler?() }
            )
        )
    }
}

// MARK: - Preview
#if DEBUG

#Preview("Overlay") {
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

    return ZStack {
        backgroundColor

        Button("Present") {
            isPresented = true
        }
        .someModal(
            link: .overlay(linkID: "some_modal"),
            isPresented: $isPresented
        ) { contentColor }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .modalPresenterRoot(root: .overlay())
}

#if !(os(macOS) || os(tvOS) || os(watchOS) || os(visionOS)) // No `window` type

#Preview("Window") {
    @Previewable @State var isPresented: Bool = true

    ZStack {
        Button("Present") {
            isPresented = true
        }
        .someModal(
            link: .window(linkID: "some_modal"),
            isPresented: $isPresented
        ) { Color.accentColor }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .modalPresenterRoot(root: .window())
}

#endif

extension View {
    func someModal<Content>(
        link: ModalPresenterLink,
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View
        where Content: View
    {
        self
            .modalPresenterLink(
                link: link,
                isPresented: isPresented,
            ) {
                SomeModal(
                    isPresented: isPresented,
                    content: content
                )
            }
    }
}

private struct SomeModal<Content>: View where Content: View {
    @Environment(\.modalPresenterContainerSize) private var containerSize: CGSize
    @Environment(\.modalPresenterSafeAreaInsets) private var safeAreaInsets: EdgeInsets

    @Environment(\.modalPresenterPresentationMode) private var presentationMode: ModalPresenterPresentationMode!

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
            Color(uiColor:UIColor .systemBackground)
#elseif os(macOS)
            Color(nsColor: NSColor.windowBackgroundColor)
#elseif os(tvOS)
            Color.dynamic(Color.white, Color.black)
#elseif os(watchOS)
            Color.black
#elseif os(visionOS)
            Color(uiColor: UIColor.systemBackground)
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

        return ZStack {
            backgroundColor

            content()
                .padding()
        }
        .frame(dimension: dimension)
        
        .compositingGroup() // For shadow
        .shadow(
            color: Color.black.opacity(0.15),
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
