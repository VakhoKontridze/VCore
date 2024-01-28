import SwiftUI
import VCore

struct ContentView: View {
    @State private var isPresented: Bool = false

    var body: some View {
        Button(
            "Present",
            action: {
                isPresented = true

                Task(operation: {
                    try? await Task.sleep(seconds: 1)
                    isPresented = false
                })
            }
        )
        .someModal(
            id: "some_modal",
            isPresented: $isPresented,
            content: { Color.accentColor }
        )
    }
}

// ...
