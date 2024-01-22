//  ___FILEHEADER___

import SwiftUI
import VCore

// MARK: - ___VARIABLE_productName___ View
struct ___VARIABLE_productName___View: View {
    // MARK: Properties
    @State private var viewModel: ___VARIABLE_productName___ViewModel

    private typealias UIModel = ___VARIABLE_productName___UIModel

    @Environment(\.navigationStackCoordinator) private var navigationStackCoordinator: NavigationStackCoordinator!
    
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
        })

        .inlineNavigationTitle("___VARIABLE_productName___".localized)

        .alert(parameters: $viewModel.alertParameters)
        .progressView(parameters: viewModel.progressViewParameters)
    }
    
    private var backgroundView: some View {
        UIModel.backgroundColor.ignoresSafeArea()
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
