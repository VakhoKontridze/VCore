//  ___FILEHEADER___

import SwiftUI
import VCore

// MARK: - ___VARIABLE_productName___ Factory
@MainActor struct ___VARIABLE_productName___Factory {
    // MARK: Initalizers
    private init() {}
    
    // MARK: Factory
    static func `default`() -> some View {
        ___VARIABLE_productName___View(
            presenter: ___VARIABLE_productName___Presenter(
                interactor: ___VARIABLE_productName___Interactor()
            )
        )
            .modifier(___VARIABLE_productName___Router())
    }
    
    static func mock() -> some View {
        ___VARIABLE_productName___View(
            presenter: ___VARIABLE_productName___Presenter(
                interactor: ___VARIABLE_productName___MockInteractor()
            )
        )
            .modifier(___VARIABLE_productName___Router())
    }
}
