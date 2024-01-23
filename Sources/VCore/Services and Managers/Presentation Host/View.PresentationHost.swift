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
    ///     @State private var isPresented: Bool = false
    ///     @State private var text: String = ""
    ///
    ///     var body: some View {
    ///         VStack(content: {
    ///             Button(
    ///                 "Present",
    ///                 action: { isPresented = true }
    ///             )
    ///         })
    ///         // For `VStack` and `Button` to ignore keyboard
    ///         .frame(maxWidth: .infinity, maxHeight: .infinity)
    ///         .ignoresSafeArea(.keyboard)
    ///
    ///         .someModal(
    ///             id: "some_modal",
    ///             isPresented: $isPresented,
    ///             content: {
    ///                 ScrollView(content: {
    ///                     VStack(spacing: 20, content: {
    ///                         ForEach(0..<10, id: \.self, content: { _ in
    ///                             TextField("", text: $text)
    ///                                 .textFieldStyle(.roundedBorder)
    ///                         })
    ///                     })
    ///                     .padding(30)
    ///                 })
    ///             }
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
    ///                     content: { SomeModal(content: content) }
    ///                 )
    ///         }
    ///     }
    ///
    ///     struct SomeModal<Content>: View where Content: View {
    ///         @Environment(\.presentationHostGeometryReaderSize) private var containerSize: CGSize
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
    ///            self.content = content
    ///         }
    ///
    ///         var body: some View {
    ///             ZStack(content: {
    ///                 Color.black.opacity(0.16)
    ///                     .contentShape(Rectangle())
    ///                     .onTapGesture(perform: animateOut)
    ///
    ///                 ZStack(content: {
    ///                     Color(uiColor: .systemBackground)
    ///
    ///                     content()
    ///                 })
    ///                 .clipped() // Prevents keyboard content from overflowing
    ///
    ///                 .frame(
    ///                     width: containerSize.width * 0.9,
    ///                     height: containerSize.height * 0.6
    ///                 )
    ///                 //.safeAreaPaddings(edges: .all, insets: safeAreaInsets) // Can be used to introduce safe areas
    ///
    ///                 .offset(y: isInternallyPresented ? 0 : containerSize.height)
    ///             })
    ///             .onAppear(perform: animateIn)
    ///             .onChange(
    ///                 of: presentationMode.isExternallyDismissed,
    ///                 { (_, newValue) in if newValue && isInternallyPresented { animateOutFromExternalDismiss() } }
    ///             )
    ///
    ///             .onReceive( // For ensuring proper stating when changing device/interface orientation
    ///                 NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification),
    ///                 perform: { _ in UIApplication.shared.sendResignFirstResponderAction() }
    ///             )
    ///         }
    ///
    ///         private func animateIn() {
    ///             withAnimation(
    ///                 .easeInOut(duration: 0.3),
    ///                 { isInternallyPresented = true }
    ///            )
    ///         }
    ///
    ///         private func animateOut() {
    ///             withAnimation(
    ///                 .easeInOut(duration: 0.3),
    ///                 { isInternallyPresented = false },
    ///                 completion: presentationMode.dismiss
    ///             )
    ///         }
    ///
    ///         private func animateOutFromExternalDismiss() {
    ///             withAnimation(
    ///                 .easeInOut(duration: 0.3),
    ///                 { isInternallyPresented = false },
    ///                 completion: presentationMode.externalDismissCompletion
    ///             )
    ///         }
    ///     }
    ///
    /// Due to a presented modal context, content loses its intrinsic safe area properties, and requires custom handling and implementation.
    public func presentationHost<Content>(
        id: String,
        uiModel: PresentationHostUIModel = .init(),
        isPresented: Binding<Bool>,
        content: @escaping () -> Content
    ) -> some View
        where Content: View
    {
        self
            ._presentationHost(
                id: id,
                uiModel: uiModel,
                isPresented: isPresented,
                content: content
            )
    }

    /// Injects a Presentation Host in view hierarchy for modal presentation.
    ///
    /// For additional info, refer to `View.presentationHost(id:allowsHitTests:isPresented:content:)`.
    public func presentationHost<Item, Content>(
        id: String,
        uiModel: PresentationHostUIModel = .init(),
        item: Binding<Item?>,
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
                content: content
            )
    }
    
    /// Injects a Presentation Host in view hierarchy for modal presentation.
    ///
    /// For additional info, refer to `View.presentationHost(id:allowsHitTests:isPresented:content:)`.
    public func presentationHost<T, Content>(
        id: String,
        uiModel: PresentationHostUIModel = .init(),
        isPresented: Binding<Bool>,
        presenting data: T?,
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
                content: content
            )
    }
    
    /// Injects a Presentation Host in view hierarchy for modal presentation.
    ///
    /// For additional info, refer to `View.presentationHost(id:allowsHitTests:isPresented:content:)`.
    public func presentationHost<E, Content>(
        id: String,
        uiModel: PresentationHostUIModel = .init(),
        isPresented: Binding<Bool>,
        error: E?,
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
                content: content
            )
    }

    @ViewBuilder private func _presentationHost<Content>(
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
            .background(content: {
                PresentationHostView(
                    id: id,
                    uiModel: uiModel,
                    isPresented: isPresented,
                    content: content
                )
            })
#endif
    }
}

// MARK: - Preview
#if DEBUG

#if canImport(UIKit) && !(os(tvOS) || os(watchOS))

#Preview(body: {
    guard #available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *) else { return EmptyView() }

    struct ContentView: View {
        @State private var isPresented: Bool = false

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
                content: { SomeModal(content: content) }
            )
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
private struct SomeModal<Content>: View where Content: View {
    @Environment(\.presentationHostGeometryReaderSize) private var containerSize: CGSize
    @Environment(\.presentationHostGeometryReaderSafeAreaInsets) private var safeAreaInsets: EdgeInsets

    @Environment(\.presentationHostPresentationMode) private var presentationMode: PresentationHostPresentationMode
    @State private var isInternallyPresented: Bool = false

    private let content: () -> Content

    init(
        @ViewBuilder content: @escaping () -> Content
    ) {
       self.content = content
    }

    var body: some View {
        ZStack(content: {
            Color.black.opacity(0.16)
                .contentShape(Rectangle())
                .onTapGesture(perform: animateOut)

            ZStack(content: {
                Color(uiColor: UIColor.systemBackground)

                content()
            })
            .clipped() // Prevents keyboard content from overflowing

            .frame(
                width: containerSize.width * 0.9,
                height: containerSize.height * 0.6
            )
            //.safeAreaPaddings(edges: .all, insets: safeAreaInsets) // Can be used to introduce safe areas

            .offset(y: isInternallyPresented ? 0 : containerSize.height)
        })
        .onAppear(perform: animateIn)
        .onChange(
            of: presentationMode.isExternallyDismissed,
            { (_, newValue) in if newValue && isInternallyPresented { animateOutFromExternalDismiss() } }
        )
    }

    private func animateIn() {
        withAnimation(
            .easeInOut(duration: 0.3),
            { isInternallyPresented = true }
       )
    }

    private func animateOut() {
        withAnimation(
            .easeInOut(duration: 0.3),
            { isInternallyPresented = false },
            completion: presentationMode.dismiss
        )
    }

    private func animateOutFromExternalDismiss() {
        withAnimation(
            .easeInOut(duration: 0.3),
            { isInternallyPresented = false },
            completion: presentationMode.externalDismissCompletion
        )
    }
}

#endif

#endif
