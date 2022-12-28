//  ___FILEHEADER___

import SwiftUI
import VCore

// MARK: - ___VARIABLE_productName___ View
struct ___VARIABLE_productName___View<Presenter>: View
    where Presenter: ___VARIABLE_productName___Presentable
{
    // MARK: Properties
    @Environment(\.navigationStackCoordinator) private var navigationStackCoordinator: NavigationStackCoordinator?
    @StateObject private var presenter: Presenter
    
    private typealias UIModel = ___VARIABLE_productName___UIModel
    
    @State private var didAppearForTheFirstTime: Bool = false
    
    // MARK: Initializers
    init(
        presenter: @escaping @autoclosure () -> Presenter
    ) {
        self._presenter = .init(wrappedValue: presenter())
    }

    // MARK: Body
    var body: some View {
        ZStack(content: {
            canvas
            contentView
        })
            .onFirstAppear($didAppearForTheFirstTime, perform: { presenter.navigationStackCoordinator = navigationStackCoordinator })
            .inlineNavigationTitle("___VARIABLE_productName___")
            .alert(parameters: $presenter.alertParameters)
            .progressView(parameters: presenter.progressViewParameters)
    }
    
    private var canvas: some View {
        UIModel.Colors.background.ignoresSafeArea()
    }
    
    private var contentView: some View {
        EmptyView()
    }
}

// MARK: - Preview
struct ___VARIABLE_productName___View_Previews: PreviewProvider {
    static var previews: some View {
        CoordinatingNavigationStack(root: {
            ___VARIABLE_productName___Factory.mock()
        })
    }
}
