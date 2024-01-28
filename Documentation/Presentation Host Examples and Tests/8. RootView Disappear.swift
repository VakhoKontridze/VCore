import SwiftUI
import VCore

struct ContentView: View {
    @State private var isRendered: Bool = true
    @State private var isPresented: Bool = false

    var body: some View {
        ZStack(content: {
            VStack(content: {
                Button(
                    "Render/Unrender",
                    action: { isRendered.toggle() }
                )

                if isRendered {
                    Button(
                        "Present",
                        action: { isPresented = true }
                    )
                    .someModal(
                        id: "some_modal",
                        isPresented: $isPresented,
                        content: {
                            Color.accentColor
                                .onTapGesture(perform: { isRendered = false })
                        }
                    )
                }
            })
        })
    }
}

// ...
