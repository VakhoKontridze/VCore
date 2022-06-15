//  ___FILEHEADER___

import UIKit

// MARK: - ___VARIABLE_productName___ Factory
struct ___VARIABLE_productName___Factory {
    // MARK: Initalizers
    private init() {}
    
    // MARK: Factory
    static func `default`(viewModel: ___VARIABLE_productName___ViewModel) -> UIViewController {
        let viewController: ___VARIABLE_productName___ViewController = .init()
        
        let router: ___VARIABLE_productName___Router = .init(navigable: viewController)

        let interactor: ___VARIABLE_productName___Interactor = .init()

        let presenter: ___VARIABLE_productName___Presenter = .init(
            view: viewController,
            router: router,
            interactor: interactor,
            viewModel: viewModel
        )

        viewController.presenter = presenter
        
        return viewController
    }
}
