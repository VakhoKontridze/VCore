//  ___FILEHEADER___

import Foundation
import VCore

// MARK: - ___VARIABLE_productName___ Presenter
@MainActor final class ___VARIABLE_productName___Presenter<Interactor>: ___VARIABLE_productName___Presentable
    where Interactor: ___VARIABLE_productName___Interactive
{
    // MARK: Properties
    private let interactor: Interactor
    
    // MARK: Initialzers
    init(interactor: Interactor) {
        self.interactor = interactor
    }

    // MARK: Presentable
    @Published var navigationStackCoordinator: NavigationStackCoordinator?
    @Published var alertParameters: AlertParameters?
    @Published var progressViewParameters: ProgressViewParameters?
}
