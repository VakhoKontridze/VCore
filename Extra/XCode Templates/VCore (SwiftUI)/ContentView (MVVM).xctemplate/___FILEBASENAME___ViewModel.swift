//  ___FILEHEADER___

import Foundation
import VCore

// MARK: - ___VARIABLE_productName___ View Model
@MainActor final class ___VARIABLE_productName___ViewModel: ObservableObject {
    // MARK: Properties
    private let parameters: ___VARIABLE_productName___Parameters

    var navigationStackCoordinator: NavigationStackCoordinator!
    @Published var alertParameters: AlertParameters?
    @Published var progressViewParameters: ProgressViewParameters?
    
    // MARK: Initializers
    init(parameters: ___VARIABLE_productName___Parameters) {
        self.parameters = parameters
    }
}
