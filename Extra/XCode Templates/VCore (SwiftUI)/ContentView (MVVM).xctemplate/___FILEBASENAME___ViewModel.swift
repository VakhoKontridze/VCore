//  ___FILEHEADER___

import Foundation
import VCore

// MARK: - ___VARIABLE_productName___ View Model
@Observable
final class ___VARIABLE_productName___ViewModel {
    // MARK: Properties - Architecture
    @ObservationIgnored private let parameters: ___VARIABLE_productName___Parameters

    @ObservationIgnored var navigationStackCoordinator: NavigationStackCoordinator!
    var alertParameters: AlertParameters?
    private(set) var progressViewParameters: ProgressViewParameters?

    // MARK: Properties - Data
    // ...

    // MARK: Properties - ???
    // ...

    // MARK: Properties - Cancellables
    // ...

    // MARK: Initializers
    init(parameters: ___VARIABLE_productName___Parameters) {
        self.parameters = parameters
    }

    // MARK: Lifecycle
    func didLoad() {
        // ...
    }

    // MARK: Actions
    // ...

    // MARK: Child Scenes
    // ...

    // MARK: Requests
    // ...

    // MARK: ???
    // ...
}
