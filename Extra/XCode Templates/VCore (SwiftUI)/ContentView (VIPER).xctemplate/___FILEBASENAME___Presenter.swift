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
    init(
        interactor: Interactor,
        parameters: ___VARIABLE_productName___Parameters
    ) {
        self.interactor = interactor
        self.parameters = parameters
    }

    // MARK: Presentable
    var navigationStackCoordinator: NavigationStackCoordinator?
    @Published var alertParameters: AlertParameters?
    @Published var progressViewParameters: ProgressViewParameters?
}
