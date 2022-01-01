//  ___FILEHEADER___

import Foundation
import VCore

// MARK: - ___VARIABLE_productName___ Presenter
final class ___VARIABLE_productName___Presenter: ___VARIABLE_productName___Presentable {
    // MARK: Properties
    private unowned let view: ___VARIABLE_productName___Viewable
    private let router: ___VARIABLE_productName___Routable
    private let interactor: ___VARIABLE_productName___Interactive
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

    // MARK: Table View Delegatable
    func tableViewDidSelectRow(section: Int, row: Int) {
        TODO()
    }

    // MARK: Table View DataSourceable
    var tableViewNumberOfSections: Int {
        TODO()
    }
    
    func tableViewNumberOfRows(section: Int) -> Int {
        TODO()
    }
    
    func tableViewCellViewModel(section: Int, row: Int) -> UITableViewCellViewModelable {
        TODO()
    }
}
