import SwiftUI
import VCore

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

extension View {
    func someModal<Content>(
        id: String,
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View
        where Content: View
    {
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

struct SomeModal<Content>: View where Content: View {
    @Environment(\.presentationHostGeometryReaderSize) private var containerSize: CGSize
    @Environment(\.presentationHostGeometryReaderSafeAreaInsets) private var safeAreaInsets: EdgeInsets

    @Environment(\.presentationHostPresentationMode) private var presentationMode: PresentationHostPresentationMode!
    
    @Binding private var isPresented: Bool
    @State private var isPresentedInternally: Bool = false
    @State private var didFinishInternalPresentation: Bool = false

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
                .onTapGesture(perform: dismissFromDimmingViewTap)

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

    private func dismissFromDimmingViewTap() {
        guard didFinishInternalPresentation else { return }

        isPresented = false
    }

    private func animateIn() {
        withAnimation(
            .easeInOut(duration: 0.3),
            { isPresentedInternally = true },
            completion: { didFinishInternalPresentation = true }
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
