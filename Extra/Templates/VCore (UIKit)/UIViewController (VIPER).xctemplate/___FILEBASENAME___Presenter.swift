//  ___FILEHEADER___

import Foundation
import VCore

// MARK: - ___VARIABLE_productName___ Presenter
final class ___VARIABLE_productName___Presenter: ___VARIABLE_productName___Presentable {
    // MARK: Properties
    private unowned let view: any ___VARIABLE_productName___Viewable
    private let router: any ___VARIABLE_productName___Routable
    private let interactor: any ___VARIABLE_productName___Interactive
    private let viewModel: ___VARIABLE_productName___ViewModel

    // MARK: Initializers
    init(
        view: ___VARIABLE_productName___Viewable,
        router: ___VARIABLE_productName___Routable,
        interactor: ___VARIABLE_productName___Interactive,
        viewModel: ___VARIABLE_productName___ViewModel
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.viewModel = viewModel
    }

    // MARK: Presentable
    
}
