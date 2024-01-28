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
@available(visionOS, unavailable)
extension View {
    /// Injects a Presentation Host in view hierarchy for modal presentation.
    ///
    ///     @State private var isPresented: Bool = false
    ///
    ///     var body: some View {
    ///         Button(
    ///             "Present",
    ///             action: { isPresented = true }
    ///         )
    ///         .someModal(
    ///             id: "some_modal",
    ///             isPresented: $isPresented,
    ///             content: { Color.accentColor }
    ///         )
    ///     }
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
    ///         @Environment(\.presentationHostGeometryReaderSize) private var containerSize: CGSize
    ///         @Environment(\.presentationHostGeometryReaderSafeAreaInsets) private var safeAreaInsets: EdgeInsets
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
    ///            self.content = content
    ///         }
    ///
    ///         var body: some View {
    ///             ZStack(content: {
    ///                 Color.black.opacity(0.1)
    ///                     .contentShape(Rectangle())
    ///                     .onTapGesture(perform: { isPresented = false })
    ///
    ///                 ZStack(content: {
    ///                     Color(uiColor: .systemBackground)
    ///
    ///                     content()
    ///                         .padding()
    ///                 })
    ///                 .frame(
    ///                     width: containerSize.width * 0.9,
    ///                     height: containerSize.height * 0.6
    ///                 )
    ///                 .offset(y: isPresentedInternally ? 0 : containerSize.height)
    ///             })
    ///             .onReceive(presentationMode.presentPublisher, perform: animateIn)
    ///             .onReceive(presentationMode.dismissPublisher, perform: animateOut)
    ///         }
    ///
    ///         private func animateIn() {
    ///             withAnimation(
    ///                 .easeInOut(duration: 0.3),
    ///                 { isPresentedInternally = true }
    ///            )
    ///         }
    ///
    ///         private func animateOut() {
    ///             withAnimation(
    ///                 .easeInOut(duration: 0.3),
    ///                 { isPresentedInternally = false },
    ///                 completion: presentationMode.dismissCompletion
    ///             )
    ///         }
    ///     }
    ///
    /// Due to implementation, content loses its intrinsic safe area properties, and requires custom handling and implementation.
    /// For additional info, refer to `presentationHostGeometryReaderSize` and `presentationHostGeometryReaderSafeAreaInsets`.
    ///
    /// Additional usage examples are documented under `Documentation/Presentation Host Examples and Tests`.
    public func presentationHost<Content>(
        id: String,
        uiModel: PresentationHostUIModel = .init(),
        isPresented: Binding<Bool>,
        onPresent presentHandler: (() -> Void)? = nil,
        onDismiss dismissHandler: (() -> Void)? = nil,
        content: @escaping () -> Content
    ) -> some View
        where Content: View
    {
        self
            ._presentationHost(
                id: id,
                uiModel: uiModel,
                isPresented: isPresented,
                onPresent: presentHandler,
                onDismiss: dismissHandler,
                content: content
            )
    }

    /// Injects a Presentation Host in view hierarchy for modal presentation.
    ///
    /// For additional info, refer to `View.presentationHost(id:uiModel:isPresented:onPresent:onDismiss:content:)`.
    public func presentationHost<Item, Content>(
        id: String,
        uiModel: PresentationHostUIModel = .init(),
        item: Binding<Item?>,
        onPresent presentHandler: (() -> Void)? = nil,
        onDismiss dismissHandler: (() -> Void)? = nil,
        content: @escaping () -> Content
    ) -> some View
        where Content: View
    {
        self
            ._presentationHost(
                id: id,
                uiModel: uiModel,
                isPresented: Binding(
                    get: { item.wrappedValue != nil },
                    set: { if !$0 { item.wrappedValue = nil } }
                ),
                onPresent: presentHandler,
                onDismiss: dismissHandler,
                content: content
            )
    }
    
    /// Injects a Presentation Host in view hierarchy for modal presentation.
    ///
    /// For additional info, refer to `View.presentationHost(id:uiModel:isPresented:onPresent:onDismiss:content:)`.
    public func presentationHost<T, Content>(
        id: String,
        uiModel: PresentationHostUIModel = .init(),
        isPresented: Binding<Bool>,
        presenting data: T?,
        onPresent presentHandler: (() -> Void)? = nil,
        onDismiss dismissHandler: (() -> Void)? = nil,
        content: @escaping () -> Content
    ) -> some View
        where Content: View
    {
        self
            ._presentationHost(
                id: id,
                uiModel: uiModel,
                isPresented: Binding(
                    get: { isPresented.wrappedValue && data != nil },
                    set: { if !$0 { isPresented.wrappedValue = false } }
                ),
                onPresent: presentHandler,
                onDismiss: dismissHandler,
                content: content
            )
    }
    
    /// Injects a Presentation Host in view hierarchy for modal presentation.
    ///
    /// For additional info, refer to `View.presentationHost(id:uiModel:isPresented:onPresent:onDismiss:content:)`.
    public func presentationHost<E, Content>(
        id: String,
        uiModel: PresentationHostUIModel = .init(),
        isPresented: Binding<Bool>,
        error: E?,
        onPresent presentHandler: (() -> Void)? = nil,
        onDismiss dismissHandler: (() -> Void)? = nil,
        content: @escaping () -> Content
    ) -> some View
        where Content: View
    {
        self
            ._presentationHost(
                id: id,
                uiModel: uiModel,
                isPresented: Binding(
                    get: { isPresented.wrappedValue && error != nil },
                    set: { if !$0 { isPresented.wrappedValue = false } }
                ),
                onPresent: presentHandler,
                onDismiss: dismissHandler,
                content: content
            )
    }

    @ViewBuilder private func _presentationHost<Content>(
        id: String,
        uiModel: PresentationHostUIModel = .init(),
        isPresented: Binding<Bool>,
        onPresent presentHandler: (() -> Void)?,
        onDismiss dismissHandler: (() -> Void)?,
        content: @escaping () -> Content
    ) -> some View
        where Content: View
    {
#if canImport(UIKit) && !os(watchOS)
        self
            .onDisappear(perform: {
                isPresented.wrappedValue = false
                PresentationHostViewController.forceDismissHostedView(id: id)
            })
            .background(content: {
                PresentationHostView(
                    id: id,
                    uiModel: uiModel,
                    isPresented: isPresented,
                    onPresent: presentHandler,
                    onDismiss: dismissHandler,
                    content: content
                )
            })
#endif
    }
}

// MARK: - Preview
#if DEBUG

#if canImport(UIKit) && !(os(tvOS) || os(watchOS) || os(visionOS))

#Preview(body: {
    guard #available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *) else { return EmptyView() }

    struct ContentView: View {
        @State private var isPresented: Bool = true

        var body: some View {
            Button(
                "Present",
                action: { isPresented = true }
            )
            .someModal(
                id: "some_modal",
                isPresented: $isPresented,
                content: { Color.accentColor }
            )
        }
    }

    return ContentView()
})

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension View {
    fileprivate func someModal(
        id: String,
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> some View
    ) -> some View {
        self
            .presentationHost(
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
    @Environment(\.presentationHostGeometryReaderSize) private var containerSize: CGSize
    @Environment(\.presentationHostGeometryReaderSafeAreaInsets) private var safeAreaInsets: EdgeInsets

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
        ZStack(content: {
            Color.black.opacity(0.1)
                .contentShape(Rectangle())
                .onTapGesture(perform: { isPresented = false })

            ZStack(content: {
                Color(uiColor: .systemBackground)

                content()
                    .padding()
            })
            .frame(
                width: containerSize.width * 0.9,
                height: containerSize.height * 0.6
            )
            .offset(y: isPresentedInternally ? 0 : containerSize.height)
        })
        .onReceive(presentationMode.presentPublisher, perform: animateIn)
        .onReceive(presentationMode.dismissPublisher, perform: animateOut)
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
}

#endif

#endif
