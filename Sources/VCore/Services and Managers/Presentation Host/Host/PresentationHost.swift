//
//  PresentationHost.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.07.24.
//

import SwiftUI

// MARK: - Extension
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
    ///         .presentationHostLayer()
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
    ///             .opacity(isPresentedInternally ? 1 : 0)
    ///
    ///             .onReceive(presentationMode.presentPublisher, perform: animateIn)
    ///             .onReceive(presentationMode.dismissPublisher, perform: animateOut)
    ///             .onReceive(presentationMode.dimmingViewTapActionPublisher, perform: didTapDimmingView)
    ///         }
    ///
    ///         private func animateIn() {
    ///             withAnimation(
    ///                 .easeInOut(duration: 0.3),
    ///                 { isPresentedInternally = true }
    ///             )
    ///         }
    ///
    ///         private func animateOut() {
    ///            withAnimation(
    ///                 .easeInOut(duration: 0.3),
    ///                 { isPresentedInternally = false },
    ///                 completion: presentationMode.dismissCompletion
    ///             )
    ///         }
    ///
    ///         private func didTapDimmingView() {
    ///             isPresented = false
    ///         }
    ///     }
    ///     
    public func presentationHost<Content>(
        layerID: String? = nil,
        id: String,
        uiModel: PresentationHostUIModel = .init(),
        isPresented: Binding<Bool>,
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
                    content: content
                )
            )
    }
}

// MARK: - Presentation Host View Modifier
private struct PresentationHostViewModifier<ModalContent>: ViewModifier where ModalContent: View {
    // MARK: Properties
    private let id: String

    private let uiModel: PresentationHostUIModel

    @Binding private var isPresented: Bool

    private let modalContent: () -> ModalContent

    @ObservedObject private var internalPresentationMode: PresentationHostInternalPresentationMode

    // MARK: Initializers
    init(
        layerID: String?,
        id: String,
        uiModel: PresentationHostUIModel,
        isPresented: Binding<Bool>,
        @ViewBuilder content modalContent: @escaping () -> ModalContent
    ) {
        self.id = id
        self._isPresented = isPresented
        self.uiModel = uiModel
        self.modalContent = modalContent
        self._internalPresentationMode = ObservedObject(
            wrappedValue: PresentationHostInternalPresentationModeRegistrar.shared.resolve(layerID: layerID)
        )
    }

    // MARK: Body
    func body(content: Content) -> some View {
        updateModal()

        return content
            .applyModifier({
                if #available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *) {
                    $0
                        .onChange(of: isPresented, initial: true, { (_, newValue) in
                            if newValue {
                                presentModal()
                            } else {
                                dismissModal()
                            }
                        })

                } else {
                    $0
                        .onFirstAppear(perform: {
                            if isPresented {
                                presentModal()
                            } else {
                                dismissModal()
                            }
                        })
                        .onChange(of: isPresented, perform: { newValue in
                            if newValue {
                                presentModal()
                            } else {
                                dismissModal()
                            }
                        })
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
                view: { modalContent().eraseToAnyView() }
            )
        )
    }

    private func updateModal() {
        internalPresentationMode.updatePublisher.send(
            PresentationHostInternalPresentationMode.UpdateData(
                id: id,
                view: { modalContent().eraseToAnyView() }
            )
        )
    }

    private func dismissModal() {
        internalPresentationMode.dismissPublisher.send(
            PresentationHostInternalPresentationMode.DismissData(
                id: id
            )
        )
    }
}

// MARK: - Preview
#if DEBUG

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *) // TODO: iOS 17.0 - Move all type declaration within the macro
#Preview(body: {
    ContentView()
})

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
private struct ContentView: View {
    @State private var isPresented: Bool = true

    var body: some View {
        let backgroundColor: Color? = {
#if os(visionOS)
            Color.white
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
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
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

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
private struct SomeModal<Content>: View where Content: View {
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

        .opacity(isPresentedInternally ? 1 : 0)

        .onReceive(presentationMode.presentPublisher, perform: animateIn)
        .onReceive(presentationMode.dismissPublisher, perform: animateOut)
        .onReceive(presentationMode.dimmingViewTapActionPublisher, perform: didTapDimmingView)
    }

    private func animateIn() {
        withAnimation(
            .easeInOut(duration: 0.3),
            { isPresentedInternally = true }
        )
    }

    private func animateOut() {
        withAnimation(
            .easeInOut(duration: 0.3),
            { isPresentedInternally = false },
            completion: presentationMode.dismissCompletion
        )
    }

    private func didTapDimmingView() {
        isPresented = false
    }
}

#endif
