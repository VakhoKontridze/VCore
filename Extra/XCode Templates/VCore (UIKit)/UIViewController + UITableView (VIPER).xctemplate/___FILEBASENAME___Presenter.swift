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
    private let parameters: ___VARIABLE_productName___Parameters

    // MARK: Initializers
    init(
        view: View,
        router: Router,
        interactor: Interactor,
        parameters: ___VARIABLE_productName___Parameters
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.parameters = parameters
    }

    // MARK: Presentable
    // ...

    // MARK: Table View Delegable
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
    
    func tableViewCellParameter(section: Int, row: Int) -> any UITableViewCellParameter {
        TODO()
    }
}
