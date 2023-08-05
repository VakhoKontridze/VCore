//  ___FILEHEADER___

import SwiftUI

// MARK: - ___VARIABLE_productName___ Factory
struct ___VARIABLE_productName___Factory {
    // MARK: Initializers
    private init() {}
    
    // MARK: Factory
    static func `default`(parameters: ___VARIABLE_productName___Parameters) -> some View {
        ___VARIABLE_productName___View(
            presenter: ___VARIABLE_productName___Presenter(
                interactor: ___VARIABLE_productName___Interactor(),
                parameters: parameters
            )
        )
        .modifier(___VARIABLE_productName___Router())
    }
    
    static func mock() -> some View {
        ___VARIABLE_productName___View(
            presenter: ___VARIABLE_productName___Presenter(
                interactor: ___VARIABLE_productName___MockInteractor(),
                parameters: .mock
            )
        )
        .modifier(___VARIABLE_productName___Router())
    }
}
