//  ___FILEHEADER___

import SwiftUI
import VCore

// MARK: - ___VARIABLE_productName___ View
struct ___VARIABLE_productName___View: View {
    // MARK: Properties - Architecture
    @State private var parameters: ___VARIABLE_productName___Parameters

    @Environment(\.navigationStackCoordinator) private var navigationStackCoordinator: NavigationStackCoordinator!
    @State private var alertParameters: AlertParameters?
    @State private var progressViewParameters: ProgressViewParameters?
    
    // MARK: Properties - Model Injection
    // ...
    
    // MARK: Properties - UI Model
    // ...

    // MARK: Properties - Data
    // ...

    // MARK: Properties - ???
    // ...

    // MARK: Properties - Cancellables
    // ...

    // MARK: Initializers
    init(parameters: ___VARIABLE_productName___Parameters) {
        self._parameters = State(wrappedValue: parameters)
    }
    
    // MARK: Body
    var body: some View {
        ZStack(content: {
            backgroundView
            contentView
        })
        .onFirstAppear(perform: didLoad)

        .inlineNavigationTitle("___VARIABLE_productName___")

        .alert(parameters: $alertParameters)
        .progressView(parameters: progressViewParameters)
    }
    
    private var backgroundView: some View {
        Color(uiColor: .systemBackground)
            .ignoresSafeArea()
    }
    
    private var contentView: some View {
        EmptyView()
    }

    // MARK: Lifecycle
    private func didLoad() {
        // ...
    }
}

// MARK: - Preview
#if DEBUG

#Preview(body: {
    CoordinatingNavigationStack(root: {
        ___VARIABLE_productName___View(parameters: .mock)
    })
})

#endif
