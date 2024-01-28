import SwiftUI
import VCore

struct ContentView: View {
    @State private var isPresented1: Bool = false
    @State private var isPresented2: Bool = false

    var body: some View {
        Button(
            "Present",
            action: {
                Task(operation: {
                    // 1
                    //try? await Task.sleep(seconds: 1)
                    isPresented1 = true

                    try? await Task.sleep(seconds: 1)
                    isPresented2 = true

                    try? await Task.sleep(seconds: 1)
                    isPresented2 = false

                    try? await Task.sleep(seconds: 1)
                    isPresented1 = false

                    // 2
                    try? await Task.sleep(seconds: 1)
                    isPresented1 = true

                    try? await Task.sleep(seconds: 1)
                    isPresented2 = true

                    try? await Task.sleep(seconds: 1)
                    isPresented1 = false
                })
            }
        )
        .someModal(
            id: "some_modal_1",
            isPresented: $isPresented1,
            content: {
                Color.red
                    .someModal(
                        id: "some_modal_2",
                        isPresented: $isPresented2,
                        content: { Color.blue }
                    )
            }
        )
    }
}

// ...
