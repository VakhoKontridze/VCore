import SwiftUI
import VCore

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

// ...
