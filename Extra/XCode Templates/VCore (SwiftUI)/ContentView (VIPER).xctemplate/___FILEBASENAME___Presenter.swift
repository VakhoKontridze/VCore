//  ___FILEHEADER___

import Foundation
import VCore

// MARK: - ___VARIABLE_productName___ Presenter
@MainActor final class ___VARIABLE_productName___Presenter<Interactor>: ___VARIABLE_productName___Presentable
    where Interactor: ___VARIABLE_productName___Interactive
{
    // MARK: Properties
    private let interactor: Interactor
    private let parameters: ___VARIABLE_productName___Parameters
    
    // MARK: Initializers
    nonisolated init(
        interactor: Interactor,
        parameters: ___VARIABLE_productName___Parameters
    ) {
        self.interactor = interactor
        self.parameters = parameters
    }

    // MARK: Presentable
    // ...

    // MARK: Navigation Stack Coordinable
    var navigationStackCoordinator: NavigationStackCoordinator?

    // MARK: Alert Presentable
    @Published var alertParameters: AlertParameters?

    // MARK: Progress View Presentable
    @Published var progressViewParameters: ProgressViewParameters?
}
