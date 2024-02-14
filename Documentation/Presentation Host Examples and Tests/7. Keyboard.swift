import SwiftUI
import VCore

struct ContentView: View {
    @State private var isPresented: Bool = false
    @State private var text: String = ""

    var body: some View {
        ZStack(content: {
            Button(
                "Present",
                action: { isPresented = true }
            )
        })
        // Disables keyboard responsiveness
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.keyboard)

        .someModal(
            id: "some_modal",
            isPresented: $isPresented,
            content: {
                ScrollView(content: {
                    VStack(spacing: 20, content: {
                        ForEach(0..<10, id: \.self, content: { _ in
                            TextField("", text: $text)
                                .textFieldStyle(.roundedBorder)
                        })
                    })
                })
            }
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
                Color(uiColor: UIColor.systemBackground)

                content()
                    .padding()
            })
            .clipped() // Fixes flickering issues caused by the keyboard
            .frame(
                width: containerSize.width * 0.9,
                height: containerSize.height * 0.6
            )
            .offset(y: isPresentedInternally ? 0 : containerSize.height)
        })
        .onReceive(presentationMode.presentPublisher, perform: animateIn)
        .onReceive(presentationMode.dismissPublisher, perform: animateOut)

        .onReceive( // Ensures proper animation when changing device/interface orientation
            NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification),
            perform: { _ in UIApplication.shared.sendResignFirstResponderAction() }
        )
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
