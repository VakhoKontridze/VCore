//  ___FILEHEADER___

import UIKit

// MARK: - ___VARIABLE_productName___ Factory
struct ___VARIABLE_productName___Factory {
    // MARK: Initializers
    private init() {}
    
    // MARK: Factory
    static func `default`(parameters: ___VARIABLE_productName___Parameters) -> UIViewController {
        let viewController: ___VARIABLE_productName___ViewController = .init()
        
        let router: ___VARIABLE_productName___Router = .init(navigator: viewController)

        let interactor: ___VARIABLE_productName___Interactor = .init()

        let presenter: ___VARIABLE_productName___Presenter = .init(
            view: viewController,
            router: router,
            interactor: interactor,
            parameters: parameters
        )

        viewController.presenter = presenter
        
        return viewController
    }
}
