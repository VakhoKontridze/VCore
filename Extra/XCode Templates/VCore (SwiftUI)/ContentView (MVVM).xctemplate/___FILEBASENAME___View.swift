//  ___FILEHEADER___

import SwiftUI
import VCore

// MARK: - ___VARIABLE_productName___ View
struct ___VARIABLE_productName___View: View {
    // MARK: Properties - Architecture
    @State private var viewModel: ___VARIABLE_productName___ViewModel

    @Environment(\.navigationStackCoordinator) private var navigationStackCoordinator: NavigationStackCoordinator!
    
    // MARK: Properties - UI Model
    // ...

    // MARK: Properties - ???
    // ...

    // MARK: Initializers
    init(parameters: ___VARIABLE_productName___Parameters) {
        self._viewModel = State(wrappedValue: ___VARIABLE_productName___ViewModel(parameters: parameters))
    }
    
    // MARK: Body
    var body: some View {
        ZStack(content: {
            backgroundView
            contentView
        })
        .onFirstAppear(perform: {
            viewModel.navigationStackCoordinator = navigationStackCoordinator
            viewModel.didLoad()
        })

        .inlineNavigationTitle("___VARIABLE_productName___")

        .alert(parameters: $viewModel.alertParameters)
        .progressView(parameters: viewModel.progressViewParameters)
    }
    
    private var backgroundView: some View {
        Color(uiColor: .systemBackground)
            .ignoresSafeArea()
    }
    
    private var contentView: some View {
        EmptyView()
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
