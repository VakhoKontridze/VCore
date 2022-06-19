//  ___FILEHEADER___
import SwiftUI
import VCore

// MARK: - ___VARIABLE_productName___ Scene View
struct ___VARIABLE_productName___View<Presentable>: View
    where Presentable: ___VARIABLE_productName___Presentable
{
    // MARK: Properties
    @Environment(\.navigationStackCoordinator) private var navigationStackCoordinator: NavigationStackCoordinator
    @StateObject private var presenter: Presentable
    
    private typealias Model = ___VARIABLE_productName___UIModel
    
    // MARK: Initializers
    init(presenter: Presentable) {
        self._presenter = .init(wrappedValue: presenter)
    }

    // MARK: Body
    var body: some View {
        ZStack(content: {
            canvas
            contentView
        })
            .onFirstAppear(perform: { presenter.navigationStackCoordinator = navigationStackCoordinator })
            .background(canvas)
            .standardNavigationTitle("___VARIABLE_productName___")
            .alert(parameters: $presenter.alertParameters)
            .progressView(parameters: presenter.progressViewParameters)
    }
    
    private var canvas: some View {
        Model.Colors.background.ignoresSafeArea()
    }
    
    private var contentView: some View {
        EmptyView()
    }
}

// MARK: - Previews
struct ___VARIABLE_productName___View___VARIABLE_productName___Previews: PreviewProvider {
    static var previews: some View {
        CoordinatingNavigationStack(root: {
            ___VARIABLE_productName___Factory.mock()
        })
    }
}
