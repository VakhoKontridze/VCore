import SwiftUI
import VCore

struct ContentView: View {
    @State private var isPresented1: Bool = false
    @State private var isPresented2: Bool = false

    var body: some View {
        Button(
            "Present",
            action: {
                isPresented1 = true

                Task(operation: {
                    try? await Task.sleep(seconds: 1)
                    isPresented1 = false

                    try? await Task.sleep(seconds: 1)
                    isPresented2 = true
                })
            }
        )
        .someModal(
            id: "some_modal_1",
            isPresented: $isPresented1,
            content: { Color.red }
        )
        .someModal(
            id: "some_modal_2",
            isPresented: $isPresented2,
            content: { Color.blue }
        )
    }
}

// ...
