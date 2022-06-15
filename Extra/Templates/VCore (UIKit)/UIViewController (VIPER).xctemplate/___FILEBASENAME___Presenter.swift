//  ___FILEHEADER___

import Foundation
import VCore

// MARK: - ___VARIABLE_productName___ Presenter
final class ___VARIABLE_productName___Presenter<View, Router, Interactor>: ___VARIABLE_productName___Presentable
    where
        View: ___VARIABLE_productName___Viewable,
        Router: ___VARIABLE_productName___Routable,
        Interactor: ___VARIABLE_productName___Interactive
{
    // MARK: Properties
    private unowned let view: View
    private let router: Router
    private let interactor: Interactor
    private let viewModel: ___VARIABLE_productName___ViewModel

    // MARK: Initializers
    init(
        view: View,
        router: Router,
        interactor: Interactor,
        viewModel: ___VARIABLE_productName___ViewModel
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.viewModel = viewModel
    }

    // MARK: Presentable
    
}
