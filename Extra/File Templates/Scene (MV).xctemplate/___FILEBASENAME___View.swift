//  ___FILEHEADER___

import SwiftUI
import VCore

struct ___VARIABLE_productName___View: View {
    // MARK: Properties - Appearance
    // ...
    
    // MARK: Properties - Parameters
    @State private var parameters: ___VARIABLE_productName___Parameters

    // MARK: Properties - Dependencies
    @Environment(\.navigationPath) private var navigationPath: NavigationCoordinator.Path?

    // ...
    
    // MARK: Properties - ???
    // ...
    
    // MARK: Properties - Progress
    private var progressViewParameters: ProgressViewParameters? {
        let isVisible: Bool = false
        
        return isVisible ? ProgressViewParameters() : nil
    }
    
    // MARK: Properties - Alert
    @State private var alertParameters: AlertParameters?

    // MARK: Properties - Subscriptions
    // ...

    // MARK: Initializers
    init(parameters: ___VARIABLE_productName___Parameters) {
        self._parameters = State(wrappedValue: parameters)
    }
    
    // MARK: Body
    var body: some View {
        ZStack {
            backgroundView
            contentView
        }
        // Toolbar
        .inlineNavigationTitle("___VARIABLE_productName___")
        
        // Progress & Alert
        .progressView(parameters: progressViewParameters)
        .alert(parameters: $alertParameters)
        
        // Child Scenes
        // ...
        
        // Lifecycle
        .onAppear(perform: onAppear)
        .onDisappear(perform: onDisappear)
    }
    
    private var backgroundView: some View {
        Color(uiColor: UIColor.systemBackground)
            .ignoresSafeArea()
    }
    
    private var contentView: some View {
        EmptyView()
    }

    // MARK: Lifecycle
    private func onAppear(isFirst: Bool) {
        // ...
    }
    
    private func onDisappear() {
        // ...
    }
    
    // MARK: Actions
    // ...

    // MARK: ???
    // ...
}

#if DEBUG

#Preview {
    CoordinatingNavigationStack {
        ___VARIABLE_productName___View(parameters: .mock)
    }
}

#endif
