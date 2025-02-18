//  ___FILEHEADER___

import SwiftUI
import VCore

// MARK: - ___VARIABLE_productName___ View
struct ___VARIABLE_productName___View: View {
    // MARK: Properties - Model Injection
    @Environment(\.navigationStackCoordinator) private var navigationStackCoordinator: NavigationStackCoordinator!
    
    // ...
    
    // MARK: Properties - UI Model
    // ...
    
    // MARK: Properties - Parameters
    @State private var parameters: ___VARIABLE_productName___Parameters
    
    // MARK: Properties - ???
    // ...
    
    // MARK: Properties - Progress & Alert & Error
    private var progressViewParameters: ProgressViewParameters? {
        let isVisible: Bool = false
        
        return isVisible ? ProgressViewParameters() : nil
    }
    
    @State private var alertParameters: AlertParameters?

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

        .progressView(parameters: progressViewParameters)
        .alert(parameters: $alertParameters)
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
    
    // MARK: Actions
    // ...
    
    // MARK: Requests
    // ...
    
    // MARK: ???
    // ...
}

// MARK: - Preview
#if DEBUG

#Preview(body: {
    CoordinatingNavigationStack(root: {
        ___VARIABLE_productName___View(parameters: .mock)
    })
})

#endif
